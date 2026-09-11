<#
.SYNOPSIS
    Troca o numero do Pull Request em todos os materiais da aula.

.DESCRIPTION
    O GitHub numera PRs a partir de 1, entao o "#142" da narrativa quase
    nunca vai ser o numero real. Este script corrige slides, enunciado,
    cartoes, gabarito e roteiro de uma vez.

    O publicar.ps1 ja chama este script automaticamente. Use-o sozinho
    apenas se tiver publicado o repositorio no modo manual.

.EXAMPLE
    .\ajustar_numero_do_pr.ps1 -Numero 1

.EXAMPLE
    .\ajustar_numero_do_pr.ps1 -Numero 1 -Repo minha-squad/siga-matricula
#>

param(
    [Parameter(Mandatory = $true)]
    [ValidateRange(1, 99999)]
    [int]$Numero,

    [string]$Repo
)

$ErrorActionPreference = 'Stop'

$raiz = Split-Path $PSScriptRoot -Parent
Write-Host "==> ajustando materiais em $raiz" -ForegroundColor Cyan

$arquivos = Get-ChildItem -Path $raiz -Recurse -File |
            Where-Object {
                $_.Extension -in '.md', '.txt' -and
                $_.FullName -notmatch '\\repo-siga\\' -and
                $_.FullName -notmatch '\\\.git\\'
            }

$alterados = 0
foreach ($f in $arquivos) {
    $texto = Get-Content $f.FullName -Raw -Encoding UTF8
    $novo = $texto

    if ($novo -match '#142') {
        $novo = $novo -replace '#142', "#$Numero"
    }
    if ($Repo -and $novo -match '<org>/<repo>') {
        $novo = $novo -replace '<org>/<repo>', $Repo
    }

    if ($novo -ne $texto) {
        # sem BOM, para nao quebrar o markdown
        [System.IO.File]::WriteAllText($f.FullName, $novo, (New-Object System.Text.UTF8Encoding $false))
        Write-Host "    $($f.Name)"
        $alterados++
    }
}

Write-Host "`n==> $alterados arquivos ajustados." -ForegroundColor Green
Write-Host "    Confira o slide 2, o slide 34 e o A0_ENUNCIADO antes de imprimir.`n"
