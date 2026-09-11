<#
.SYNOPSIS
    Publica o repositorio da atividade no GitHub e abre o Pull Request.

.DESCRIPTION
    Roda na SUA maquina, com a SUA conta do GitHub. O repositorio local
    (repo-siga) ja esta pronto, com as duas branches e o historico limpo:
    este script so cria o repositorio remoto, empurra as branches, abre o
    PR e corrige o numero do PR em todos os materiais da aula.

.EXAMPLE
    .\publicar.ps1 -Repo minha-squad/siga-matricula

.EXAMPLE
    .\publicar.ps1 -Repo pietroprauchner/siga-matricula -PularAjuste
#>

param(
    [Parameter(Mandatory = $true, HelpMessage = "Destino no formato <org-ou-usuario>/<nome-do-repo>")]
    [ValidatePattern('^[\w.-]+/[\w.-]+$')]
    [string]$Repo,

    [switch]$PularAjuste
)

$ErrorActionPreference = 'Stop'

function Fail($msg) { Write-Host "`nERRO: $msg" -ForegroundColor Red; exit 1 }
function Step($msg) { Write-Host "`n==> $msg" -ForegroundColor Cyan }

$src = Join-Path $PSScriptRoot 'repo-siga'
if (-not (Test-Path (Join-Path $src '.git'))) {
    Fail "nao encontrei o repositorio em $src"
}

# ---------------------------------------------------------------- pre-requisitos
Step "verificando pre-requisitos"

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Fail "git nao encontrado. Instale em https://git-scm.com/download/win"
}
Write-Host "    git   OK"

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
Write-Host "    gh    OK"

gh auth status 2>&1 | Out-Null
if ($LASTEXITCODE -ne 0) {
    Fail "gh nao esta autenticado. Rode:  gh auth login"
}
Write-Host "    conta OK"

# ---------------------------------------------------------------- estado local
Step "conferindo o repositorio local"

Push-Location $src
try {
    $branches = (git branch --format='%(refname:short)') -join ', '
    Write-Host "    branches: $branches"

    if ((git branch --list 'feature/rf-014-matricula').Length -eq 0) {
        Fail "a branch feature/rf-014-matricula nao existe neste repositorio"
    }

    # PR_BODY.md e material de apoio, nao faz parte do projeto
    $exclude = Join-Path $src '.git\info\exclude'
    if ((Get-Content $exclude -Raw -ErrorAction SilentlyContinue) -notmatch 'PR_BODY') {
        Add-Content $exclude "`nPR_BODY.md"
    }

    git remote remove origin 2>&1 | Out-Null

    # ------------------------------------------------------------ criar remoto
    Step "criando o repositorio publico $Repo"
    gh repo create $Repo --public --description "Modulo de matricula do SIGA - repositorio didatico da aula de Revisao de Software"
    if ($LASTEXITCODE -ne 0) { Fail "nao consegui criar o repositorio. Ele ja existe?" }

    git remote add origin "https://github.com/$Repo.git"

    # ------------------------------------------------------------ push
    Step "enviando as branches"
    git push -u origin main
    if ($LASTEXITCODE -ne 0) { Fail "falha ao enviar a branch main" }
    git push -u origin feature/rf-014-matricula
    if ($LASTEXITCODE -ne 0) { Fail "falha ao enviar a branch do PR" }

    # ------------------------------------------------------------ abrir o PR
    Step "abrindo o Pull Request"
    $prUrl = gh pr create `
        --repo $Repo `
        --base main `
        --head feature/rf-014-matricula `
        --title "feat(matricula): implementa RF-014 - matricula em turma" `
        --body-file (Join-Path $src 'PR_BODY.md')

    if ($LASTEXITCODE -ne 0) { Fail "falha ao abrir o Pull Request" }

    $prUrl = ($prUrl | Select-String -Pattern 'https://\S+' | ForEach-Object { $_.Matches[0].Value } | Select-Object -Last 1)
    $prNum = if ($prUrl -match '/pull/(\d+)') { $Matches[1] } else { $null }
}
finally {
    Pop-Location
}

# ---------------------------------------------------------------- ajuste do numero
if ($prNum -and -not $PularAjuste) {
    Step "ajustando o numero do PR nos materiais da aula (#142 -> #$prNum)"
    & (Join-Path $PSScriptRoot 'ajustar_numero_do_pr.ps1') -Numero $prNum -Repo $Repo
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
