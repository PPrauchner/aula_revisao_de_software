# Aula — Revisão de Software: conceitos, tipos e papéis

**Squad de 5:** Pietro Mendes Prauchner (A1) · Lorenzo Ponsi Ficher (A2) ·
Inaurrara Flores Rozado (A3) · Andreus Dean Ferreira Almeida Rodrigues Vargas (A4) ·
Bruno da Silva Rocha (A5)
**Data:** terça-feira, 15/09/2026 · **Duração:** 90 min · **Turma:** 7 grupos, 40 alunos

---

## ✅ O repositório já está publicado

🔗 **github.com/PPrauchner/siga-matricula** · **PR #1 aberto**

Não é preciso rodar `publicar2.ps1` de novo — o script já foi executado, as duas branches
estão no remoto e o número do PR foi corrigido em todo o material (era `#142`; o GitHub
numera a partir de 1).

> ⚠️ **Pendência conhecida:** o README da branch `feature/rf-014-matricula` ainda diz
> `#142`. A `main` está correta, então quem abre o repositório vê o número certo.
> O procedimento para limpar a branch está no `R1_ROTEIRO_DA_AULA.md`, seção
> *Repositório — já feito, só conferir*.

**Não fazer merge do PR.**

---

## Conteúdo do pacote

### 📋 Roteiro

| Arquivo | O que é |
|---|---|
| `R1_ROTEIRO_DA_AULA.md` | **Comece por aqui.** Roteiro minuto a minuto, divisão dos 6 apresentadores, checklist de preparação e planos de contingência |

### 🎞️ Slides da apresentação

| Arquivo | O que é |
|---|---|
| `01_slides/S1_CONTEUDO_DOS_SLIDES.md` | Os 40 slides — conteúdo de tela + notas do apresentador |
| `01_slides/S2_INSTRUCOES_PARA_GERAR_O_HTML.md` | Especificação e prompt para gerar o deck HTML |

### 🌐 Repositório público (o artefato que a turma revisa)

| Arquivo | O que é |
|---|---|
| `04_repositorio/repo-siga/` | Repositório git pronto, com `main`, a branch do PR e o histórico já limpo |
| `04_repositorio/publicar2.ps1` | **Windows:** cria o repo, empurra, abre o PR e ajusta o número. É este que você roda |
| `04_repositorio/ajustar_numero_do_pr.ps1` | Corrige o número do PR nos materiais (o `publicar2.ps1` já chama sozinho) |
| `04_repositorio/publicar_repositorio.sh` | Mesma coisa, para Linux / macOS / Git Bash |
| `04_repositorio/ajustar_numero_do_pr.sh` | Versão bash do ajuste de número |
| `04_repositorio/INSTRUCOES_REPOSITORIO.md` | Publicação, modo manual, verificação anti-spoiler e o que fazer depois da aula |

> ℹ️ Existe um `publicar.ps1` antigo na pasta que não chegou a ser atualizado.
> **Use o `publicar2.ps1`** — o outro pode ser apagado.

### 🧪 Exemplo prático real

| Arquivo | O que é | Distribuir para |
|---|---|---|
| `02_atividade/A0_ENUNCIADO.md` | Enunciado da atividade | todos os grupos (papel) |
| `02_atividade/A4_cartoes_modos_de_revisao.md` | **6 cartões** de modo + distribuição nos **7 grupos** | **1 cartão por grupo** |
| `02_atividade/A5_checklist.md` | Checklist de revisão da equipe | só G3 e G6 |
| `02_atividade/A6_ata_de_revisao.md` | Formulário de ata — **é a entrega dos alunos** | todos os grupos (papel) |
| `02_atividade/A7_prompts_IA.md` | Prompt genérico (G4) e prompt estruturado (G7) | só G4 e G7 |
| `02_atividade/A8_saida_IA_planoB.md` | Saídas de IA pré-geradas, caso a internet falhe | só se necessário |
| `02_atividade/A9_quadro_comparativo.md` | Quadro preenchido ao vivo no projetor | squad |
| `02_atividade/copia_impressa/` | Cópia exata do que está no repositório, com números de linha | backup de contingência |

> O código, os testes, a especificação RF-014 e o padrão de codificação **vivem no
> repositório público**. A pasta `copia_impressa/` é backup — o conteúdo é idêntico,
> inclusive os números de linha citados no gabarito.

### ✅ Gabarito / resolução esperada

| Arquivo | O que é |
|---|---|
| `03_gabarito/G1_GABARITO.md` | Os 12 defeitos com localização, severidade e correção; matriz de detecção esperada por modo; falsos positivos plantados; roteiro da revelação; perguntas prováveis da turma |
| `03_gabarito/G2_matricula_corrigido.py` | Código corrigido, com cada correção marcada pelo ID do defeito |
| `03_gabarito/G3_testes_corrigidos.py` | Testes derivados dos critérios de aceitação (em vez do código) |

---

## A ideia da aula em um parágrafo

A turma revisa **um único Pull Request**, num repositório público real, mas cada um dos
7 grupos aplica um **tipo diferente de revisão** — informal, walkthrough, revisão técnica
com checklist, leitura baseada em perspectiva e revisão assistida por IA (em duas
variantes de prompt).
Dentro de cada grupo, todos os integrantes assumem **papéis formais** (moderador, autor,
leitor, revisor, escriba). Ao final, os resultados vão para um quadro comparativo único,
e a turma descobre empiricamente o que a teoria afirma: **cada tipo de revisão detecta
uma classe diferente de defeito, nenhum detecta todos, e o método escolhido determina o
que se consegue enxergar.**

Dois modos são atribuídos a **dois grupos cada**, de propósito:

- **G3 e G6** (mesmo checklist) expõem a **variabilidade entre revisores**
- **G4 e G7** (mesma IA, prompts diferentes) expõem que a qualidade da revisão
  assistida depende do **contexto fornecido**, não do modelo

Esses quatro grupos têm **tamanho travado em 6**: comparação pareada com tamanhos
diferentes deixa de medir o método. Toda falta é absorvida por **G1 e G2** (os grupos
de 5) — a tabela de degradação está no roteiro, em *Plano de faltas*.

**Pair review saiu da atividade** (a turma tem 7 grupos, não 8), mas continua nos slides
como eixo ortogonal do espectro. O A2 menciona isso em voz alta no bloco de tipos.

## Por que repositório e não papel

O diff do PR dá **números de linha reais, syntax highlighting e a visão de "o que mudou"** —
os grupos revisam onde revisão acontece de verdade. Ninguém precisa de conta no GitHub:
a atividade é só leitura. Duas regras protegem o exercício e estão no enunciado, no
README do repo e no roteiro:

1. **Ninguém comenta no PR** — senão os grupos veem os achados uns dos outros e o quadro
   comparativo perde o sentido.
2. **Ferramentas automáticas proibidas** — `ruff` e `bandit` entregam o SQL injection e o
   `except: pass` em 5 segundos e achatam a comparação. Exceção: os grupos com o cartão
   de revisão assistida por IA, e só com o prompt que receberam.

## Fronteira com a próxima aula

Esta aula é o **mapa completo** do espectro de revisão. A **inspeção formal de Fagan**
aparece deliberadamente como o extremo do espectro e como gancho (slides 16 e 33),
**sem detalhamento de fases** — esse é o tema da squad seguinte.

## Pré-requisitos de conteúdo

A turma já viu conceitos básicos de Verificação e Validação e o panorama de IA
generativa em V&V. A aula se apoia nos dois: revisão é posicionada como **verificação
estática** e o bloco de IA (slides 30–32) retoma o panorama já apresentado, agora
aplicado a uma tarefa concreta.
