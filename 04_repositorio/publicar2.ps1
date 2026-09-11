<#
.SYNOPSIS
    Publica o repositorio da atividade no GitHub e abre o Pull Request.

.DESCRIPTION
    Roda na SUA maquina, com a SUA conta do GitHub. O repositorio local
    (repo-siga) ja esta pronto, com as duas branches e o historico limpo:
    este script so cria o repositorio remoto, empurra as branches, abre o
    PR e corrige o numero do PR em todos os materiais da aula.

    E seguro rodar de novo se algo falhar no meio: ele detecta o que ja
    existe e continua de onde parou.

.EXAMPLE
    .\publicar.ps1 -Repo PPrauchner/siga-matricula

.EXAMPLE
    .\publicar.ps1 -Repo PPrauchner/siga-matricula -PularAjuste
#>

param(
    [Parameter(Mandatory = $true, HelpMessage = "Destino no formato <org-ou-usuario>/<nome-do-repo>")]
    [ValidatePattern('^[\w.-]+/[\w.-]+$')]
    [string]$Repo,

    [switch]$PularAjuste
)

# git e gh escrevem informacao normal em stderr (progresso de push, avisos).
# Com 'Stop' o PowerShell trata isso como erro fatal, entao usamos 'Continue'
# e verificamos o resultado real via $LASTEXITCODE.
$ErrorActionPreference = 'Continue'
$ProgressPreference = 'SilentlyContinue'

function Fail($msg) { Write-Host "`nERRO: $msg" -ForegroundColor Red; exit 1 }
function Step($msg) { Write-Host "`n==> $msg" -ForegroundColor Cyan }
function Info($msg) { Write-Host "    $msg" }

# Executa um comando nativo, mostra a saida indentada e devolve o codigo de saida.
function Run {
    param([string]$Exe, [string[]]$CmdArgs, [switch]$Quiet)
    $saida = & $Exe @CmdArgs 2>&1
    $codigo = $LASTEXITCODE
    if (-not $Quiet) { $saida | ForEach-Object { Info $_ } }
    return $codigo
}

$src = Join-Path $PSScriptRoot 'repo-siga'
if (-not (Test-Path (Join-Path $src '.git'))) {
    Fail "nao encontrei o repositorio em $src"
}

# ---------------------------------------------------------------- pre-requisitos
Step "verificando pre-requisitos"

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Fail "git nao encontrado. Instale com:  winget install --id Git.Git"
}
Info "git   OK"

if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    Write-Host @"

    GitHub CLI (gh) nao encontrado.

    Instale com um destes:
        winget install --id GitHub.cli
        scoop install gh
    ou baixe em https://cli.github.com

    Depois rode:  gh auth login
    E entao rode este script de novo.

    (Se preferir nao instalar o gh, siga o "Modo manual" em
     INSTRUCOES_REPOSITORIO.md - sao 4 passos no navegador.)
"@ -ForegroundColor Yellow
    exit 1
}
Info "gh    OK"

$null = & gh auth status 2>&1
if ($LASTEXITCODE -ne 0) { Fail "gh nao esta autenticado. Rode:  gh auth login" }
Info "conta OK"

# ---------------------------------------------------------------- estado local
Step "conferindo o repositorio local"

Push-Location $src
try {
    $branches = & git branch --format='%(refname:short)' 2>&1
    Info "branches: $($branches -join ', ')"

    if ($branches -notcontains 'feature/rf-014-matricula') {
        Fail "a branch feature/rf-014-matricula nao existe neste repositorio"
    }

    # PR_BODY.md e material de apoio, nao faz parte do projeto
    $exclude = Join-Path $src '.git\info\exclude'
    if ((Get-Content $exclude -Raw -ErrorAction SilentlyContinue) -notmatch 'PR_BODY') {
        Add-Content $exclude "`nPR_BODY.md"
    }

    # ------------------------------------------------------------ criar remoto
    $null = & gh repo view $Repo 2>&1
    if ($LASTEXITCODE -eq 0) {
        Step "o repositorio $Repo ja existe - reaproveitando"
    }
    else {
        Step "criando o repositorio publico $Repo"
        $codigo = Run gh @('repo', 'create', $Repo, '--public',
            '--description', 'Modulo de matricula do SIGA - repositorio didatico da aula de Revisao de Software')
        if ($codigo -ne 0) { Fail "nao consegui criar o repositorio $Repo" }
    }

    # remote origin: remove so se existir, depois recria apontando para o destino
    $remotes = & git remote 2>&1
    if ($remotes -contains 'origin') { $null = & git remote remove origin 2>&1 }
    $null = & git remote add origin "https://github.com/$Repo.git" 2>&1

    # ------------------------------------------------------------ push
    Step "enviando a branch main"
    $codigo = Run git @('push', '-u', 'origin', 'main')
    if ($codigo -ne 0) { Fail "falha ao enviar a branch main" }

    Step "enviando a branch do PR"
    $codigo = Run git @('push', '-u', 'origin', 'feature/rf-014-matricula')
    if ($codigo -ne 0) { Fail "falha ao enviar a branch feature/rf-014-matricula" }

    # ------------------------------------------------------------ abrir o PR
    $prUrl = $null

    $existente = & gh pr list --repo $Repo --head feature/rf-014-matricula --state open --json url --jq '.[0].url' 2>&1
    if ($LASTEXITCODE -eq 0 -and $existente -match 'https://') {
        Step "ja existe um PR aberto para essa branch - reaproveitando"
        $prUrl = ($existente | Select-String -Pattern 'https://\S+').Matches[0].Value
    }
    else {
        Step "abrindo o Pull Request"
        $saida = & gh pr create `
            --repo $Repo `
            --base main `
            --head feature/rf-014-matricula `
            --title "feat(matricula): implementa RF-014 - matricula em turma" `
            --body-file (Join-Path $src 'PR_BODY.md') 2>&1
        $codigo = $LASTEXITCODE
        $saida | ForEach-Object { Info $_ }
        if ($codigo -ne 0) { Fail "falha ao abrir o Pull Request" }

        $match = $saida | Select-String -Pattern 'https://\S+/pull/\d+' | Select-Object -Last 1
        if ($match) { $prUrl = $match.Matches[0].Value }
    }
}
finally {
    Pop-Location
}

$prNum = if ($prUrl -match '/pull/(\d+)') { $Matches[1] } else { $null }

# ---------------------------------------------------------------- ajuste do numero
if ($prNum -and -not $PularAjuste) {
    Step "ajustando o numero do PR nos materiais da aula (#142 -> #$prNum)"
    & (Join-Path $PSScriptRoot 'ajustar_numero_do_pr.ps1') -Numero $prNum -Repo $Repo
}
elseif (-not $prNum) {
    Write-Host "`nAVISO: nao consegui identificar o numero do PR automaticamente." -ForegroundColor Yellow
    Write-Host "       Veja o numero em https://github.com/$Repo/pulls e rode:"
    Write-Host "       .\ajustar_numero_do_pr.ps1 -Numero <numero> -Repo $Repo`n"
}

# ---------------------------------------------------------------- resumo
Write-Host @"

======================================================================
 Publicado.

   Repositorio : https://github.com/$Repo
   Pull Request: $prUrl

 ANTES DA AULA:
   1. Abra os dois links em uma JANELA ANONIMA (sem estar logado).
      A turma nao vai ter conta - tem que abrir sem login.
   2. Confira a aba "Files changed" do PR: 2 arquivos, 150 linhas.
   3. Gere o QR code do link do PR e cole no slide 34 e no A0_ENUNCIADO.
   4. NAO faca merge do PR.
======================================================================

"@ -ForegroundColor Green
