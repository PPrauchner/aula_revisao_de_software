#!/usr/bin/env bash
#
# Troca o número do Pull Request em TODOS os materiais da aula.
# O GitHub numera PRs a partir de 1, então o "#142" da narrativa
# quase certamente não vai ser o número real.
#
# Uso:
#     ./ajustar_numero_do_pr.sh 1                        # só o número
#     ./ajustar_numero_do_pr.sh 1 minha-squad/siga-matricula   # número + link
#
# Rode a partir da pasta 04_repositorio/, com a pasta da aula acima dela.

set -euo pipefail

NUM="${1:-}"
REPO="${2:-}"

if [[ -z "$NUM" || ! "$NUM" =~ ^[0-9]+$ ]]; then
    echo "uso: ./ajustar_numero_do_pr.sh <numero-do-PR> [<org>/<repo>]" >&2
    exit 1
fi

RAIZ="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
echo "==> ajustando materiais em $RAIZ"

ARQUIVOS=$(find "$RAIZ" -type f \( -name '*.md' -o -name '*.txt' \) \
           -not -path '*/repo-siga/*' -not -path '*/.git/*')

COUNT=0
for f in $ARQUIVOS; do
    if grep -q '#142' "$f"; then
        sed -i.bak "s/#142/#$NUM/g" "$f" && rm -f "$f.bak"
        echo "   PR #142 -> #$NUM   $(basename "$f")"
        COUNT=$((COUNT+1))
    fi
done

if [[ -n "$REPO" ]]; then
    for f in $ARQUIVOS; do
        if grep -q '<org>/<repo>\|github.com/<org>' "$f"; then
            sed -i.bak "s|<org>/<repo>|$REPO|g; s|github.com/<org>/<repo>|github.com/$REPO|g" "$f" && rm -f "$f.bak"
            echo "   link -> $REPO        $(basename "$f")"
        fi
    done
fi

echo
echo "==> $COUNT arquivos ajustados."
echo "    Confira o slide 2, o slide 34 e o A0_ENUNCIADO antes de imprimir."
