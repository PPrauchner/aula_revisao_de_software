# Repositório público da atividade — instruções para a squad

---

## ⚠️ Leia isto primeiro: o número do PR

O GitHub numera issues e PRs **sequencialmente a partir de 1**. Em um repositório novo,
o seu Pull Request vai ser o **#1**, não o **#142** — não há como escolher o número.

Você tem duas saídas, e a segunda é a certa:

1. ~~Criar 141 issues descartáveis para "queimar" a numeração~~ — funciona, mas deixa
   141 issues fechadas visíveis no repositório. Não vale a pena.
2. ✅ **Deixar o `publicar2.ps1` resolver.** Ele captura o número real do PR e troca o
   `#142` em todos os materiais (slides, enunciado, cartões, gabarito, roteiro)
   automaticamente, no fim da execução.

Se por algum motivo ele não conseguir identificar o número, rode você mesmo:

```powershell
.\ajustar_numero_do_pr.ps1 -Numero 1 -Repo minha-squad/siga-matricula
```

**Confirme que o número foi trocado antes de imprimir qualquer coisa.**

---

## Publicando

> **Isto precisa rodar na sua máquina, com a sua conta do GitHub.**
> O repositório local em `repo-siga/` já está pronto — as duas branches, os dois
> commits e o histórico limpo. O que falta é só criar o remoto, empurrar e abrir o PR,
> e isso exige a sua autenticação.

### Windows — PowerShell (recomendado)

Uma linha. O script publica, abre o PR **e já corrige o número do PR** nos materiais.
É seguro rodar de novo se falhar no meio: ele detecta o que já existe e continua.

```powershell
cd "C:\Users\Pietro\Documents\ES\4° Semestre\V&V\aula_revisao_de_software\04_repositorio"
.\publicar2.ps1 -Repo minha-squad/siga-matricula
```

> ⚠️ **É o `publicar2.ps1`, com o "2".** Existe um `publicar.ps1` antigo na pasta que
> falha logo no começo (`error: No such remote: 'origin'`). Pode apagar esse arquivo.

Se o PowerShell recusar por política de execução, rode nesta sessão apenas:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

**Pré-requisitos** (o script confere e avisa se faltar algo):

```powershell
winget install --id Git.Git
winget install --id GitHub.cli
gh auth login                 # escolha: GitHub.com → HTTPS → login pelo navegador
```

### Linux / macOS / Git Bash

Precisa de [GitHub CLI](https://cli.github.com) autenticado (`gh auth login`):

```bash
chmod +x publicar_repositorio.sh ajustar_numero_do_pr.sh
./publicar_repositorio.sh minha-squad/siga-matricula
./ajustar_numero_do_pr.sh 1          # use o número real que o gh imprimiu
```

### Modo manual (sem o `gh`)

1. Crie um repositório **público e vazio** no GitHub — sem README, sem .gitignore,
   sem licença (senão o push conflita).
2. Empurre as duas branches:

```bash
cd repo-siga
git remote add origin https://github.com/<org>/<repo>.git
git push -u origin main
git push -u origin feature/rf-014-matricula
```

3. No GitHub, abra **Pull requests → New pull request**
   - base: `main` · compare: `feature/rf-014-matricula`
   - título: `feat(matricula): implementa RF-014 - matrícula em turma`
   - descrição: cole o conteúdo de `repo-siga/PR_BODY.md`
4. **Deixe o PR aberto.** Não faça merge.
5. Rode `./ajustar_numero_do_pr.sh <número>` com o número que o GitHub deu.

---

## O que está no repositório

**Branch `main`** — o estado *antes* do PR:

```
README.md            projeto + enunciado da atividade + regras
CONTRIBUTING.md      padrão de codificação da equipe
docs/RF-014.md       especificação do requisito (fonte da verdade)
matricula.py         modelos de domínio + serviço com NotImplementedError
.gitignore
```

**Branch `feature/rf-014-matricula`** — o que o PR adiciona:

```
matricula.py         implementação do RF-014  (+86 linhas)
test_matricula.py    os dois testes do autor  (+67 linhas)
```

**Diff do PR: 150 linhas adicionadas em 2 arquivos.**
Dentro do limite de 200–400 linhas do slide 27 — de propósito.

## O que NÃO está no repositório (e não pode entrar)

| Fora do repo | Por quê |
|---|---|
| Gabarito | óbvio |
| Cartões de modo | se um grupo souber que G3 e G6 têm o mesmo cartão, a revelação 3 morre |
| Prompts de IA | se G4 vir o PROMPT B, a revelação 4 morre |
| Saídas de IA do plano B | idem |
| Ata de revisão | é entrega em papel |
| Roteiro e slides | material da squad |

## Detalhes que fazem a narrativa funcionar

- O commit do PR está assinado por **`dev.junior <dev.junior@siga.local>`**, e o do
  `main` por **`C. Ribeiro`**, a analista de requisitos. A aba *Contributors* conta a
  história sozinha.
- As mensagens de commit **não mencionam defeito, aula, gabarito ou atividade** —
  quem rodar `git log` não descobre nada.
- O `CONTRIBUTING.md` existe para tornar RNF-01 e RNF-02 **descobríveis como padrão da
  equipe**, e não só como linha perdida no documento de requisito. Revisão técnica é,
  por definição, verificação de conformidade com padrões — agora existe um padrão real
  para conferir.
- `docs/RF-014.md` está no `main` desde o primeiro commit, com o histórico de revisões
  mostrando a mudança de **24 → 28 créditos**. É a pista do defeito D01, e ela está
  onde estaria na vida real.

---

## Verificação antes da aula

```bash
# 1. Histórico não vaza nada
git -C repo-siga log --all --format='%h %an | %s'

# 2. Nenhuma menção proibida em nenhuma branch
git -C repo-siga grep -in "gabarito\|defeito\|plantad\|aula\|atividade" $(git -C repo-siga rev-list --all) -- . | grep -v README.md

# 3. Os testes passam na branch do PR (a armadilha do "2/2 verdes")
git -C repo-siga checkout feature/rf-014-matricula && python3 repo-siga/test_matricula.py

# 4. O main não tem a implementação
git -C repo-siga checkout main && grep -c NotImplementedError repo-siga/matricula.py
```

E, no navegador, com uma **janela anônima** (sem estar logado):

- [ ] O repositório abre sem login
- [ ] O PR abre sem login e a aba **Files changed** mostra o diff
- [ ] `docs/RF-014.md` renderiza a tabela de regras corretamente
- [ ] O link do README para o PR funciona

---

## Depois da aula

Sugestões, se quiserem manter o repositório vivo:

1. **Publiquem o gabarito como uma review no próprio PR**, comentário por comentário,
   nas linhas exatas. Vira o exemplo de "como se escreve um bom comentário de revisão"
   (slide 28) e a turma revisita quando quiser.
2. **Abram um PR de correção** (`fix/rf-014-revisao`) com o conteúdo de
   `03_gabarito/G2_matricula_corrigido.py` e `G3_testes_corrigidos.py`. A turma vê o
   antes e o depois em diff.
3. Só depois disso, façam o merge do #1 — ou fechem sem merge, o que é mais honesto.

> Se optarem por publicar o gabarito, façam **depois** da aula. Um repositório público
> com o gabarito dentro é encontrável por busca.
