#!/usr/bin/env bash
#
# Cria e publica o repositório público da atividade, com a branch do PR #142
# e o Pull Request já aberto.
#
# Uso:
#     chmod +x publicar_repositorio.sh
#     ./publicar_repositorio.sh <org-ou-usuario>/<nome-do-repo>
#
# Exemplo:
#     ./publicar_repositorio.sh minha-squad/siga-matricula
#
# Pré-requisitos:
#     - git
#     - GitHub CLI (gh) autenticado:   gh auth login
#       (se não tiver o gh, veja o modo manual em INSTRUCOES_REPOSITORIO.md)

set -euo pipefail

REPO="${1:-}"
if [[ -z "$REPO" ]]; then
    echo "erro: informe o destino. Ex.: ./publicar_repositorio.sh minha-squad/siga-matricula" >&2
    exit 1
fi

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/repo-siga"
if [[ ! -d "$SRC/.git" ]]; then
    echo "erro: não encontrei o repositório em $SRC" >&2
    exit 1
fi

WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

echo "==> copiando o repositório para uma área temporária"
cp -r "$SRC" "$WORK/repo"
cd "$WORK/repo"
git remote remove origin 2>/dev/null || true

echo "==> criando o repositório público $REPO"
gh repo create "$REPO" --public \
    --description "Módulo de matrícula do SIGA — repositório didático da aula de Revisão de Software" \
    --disable-wiki 2>/dev/null || \
    gh repo create "$REPO" --public \
    --description "Módulo de matrícula do SIGA — repositório didático da aula de Revisão de Software"

git remote add origin "https://github.com/$REPO.git"

echo "==> enviando as branches"
git push -q -u origin main
git push -q -u origin feature/rf-014-matricula

echo "==> abrindo o Pull Request #142"
gh pr create \
    --repo "$REPO" \
    --base main \
    --head feature/rf-014-matricula \
    --title "feat(matricula): implementa RF-014 - matrícula em turma" \
    --body-file PR_BODY.md

echo
echo "======================================================================"
echo " Pronto."
echo
echo "   Repositório : https://github.com/$REPO"
echo "   Pull Request: https://github.com/$REPO/pulls"
echo
echo " AGORA, ANTES DA AULA:"
echo "   1. Confira o número do PR. Se não for #142, ajuste os slides,"
echo "      o enunciado e o README (ou abra e feche PRs até chegar em 142)."
echo "   2. Rode a verificação anti-spoiler:"
echo "        git -C '$SRC' log --all --oneline"
echo "        gh search code --repo $REPO gabarito"
echo "   3. Gere o QR code do link e cole no slide 34 e no enunciado."
echo "======================================================================"
