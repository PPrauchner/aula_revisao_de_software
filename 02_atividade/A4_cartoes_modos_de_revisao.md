# Cartões dos Modos de Revisão

> **Para a squad:** imprimir e recortar. Um cartão por grupo. Os grupos **não** devem
> saber qual modo os outros receberam antes da rodada de comparação.

## Distribuição sugerida (8 grupos)

| Grupo | Modo | Nº ideal | Observação |
|---|---|---|---|
| **G1** | M1 — Revisão informal (ad hoc) | 5 ou 6 | ✅ funciona com 5 integrantes |
| **G2** | M2 — Walkthrough guiado pelo autor | 6 | |
| **G3** | M3 — Revisão técnica com checklist | 6 | |
| **G4** | M4-A — Revisão assistida por IA (**prompt genérico**) | 6 | |
| **G5** | M5 — Leitura baseada em perspectiva | 6 | |
| **G6** | M3 — Revisão técnica com checklist | 6 | ⭐ **duplicado de propósito** |
| **G7** | M4-B — Revisão assistida por IA (**prompt estruturado**) | 6 | ⭐ **duplicado de propósito** |
| **G8** | M6 — Pair review / over-the-shoulder | 5 ou 6 | ✅ funciona com 5 integrantes |

**Por que dois pares duplicados?**

- **G3 vs G6** (mesmo método rigoroso) → mostra a **variabilidade entre revisores**:
  duas equipes com o mesmo checklist e o mesmo tempo encontram conjuntos diferentes.
  É o argumento empírico para revisão em grupo em vez de revisor único.
- **G4 vs G7** (mesma IA, prompts diferentes) → mostra que a qualidade da revisão
  assistida por IA depende quase inteiramente do **contexto que você dá a ela**.
  G4 não recebe o requisito no prompt; G7 recebe.

---
---

# ✂️ CARTÃO — MODO 1
## Revisão Informal (*ad hoc* / peer desk-check)

> É o que a maioria das equipes de verdade faz — e o nosso grupo de controle.

**Papéis**

| Papel | Quantos | O que faz |
|---|---|---|
| Revisor | todos | Lê o código e aponta o que achar estranho |
| Escriba | 1 (acumula com revisor) | Anota os achados na ata |

**Procedimento**

1. **Não use checklist. Não distribua áreas. Não leia o documento de requisitos primeiro.**
2. Abram o diff do PR #1 (`matricula.py`) e leiam do começo ao fim, comentando em voz alta o que
   parecer errado. É uma conversa, não um processo.
3. O escriba anota tudo que o grupo concordar que é defeito.
4. Se alguém quiser consultar o requisito no meio do caminho, pode — mas ninguém é
   obrigado.

**Restrições**

- Sem preparação individual. Comecem a discutir imediatamente.
- Sem critério de parada: leiam até o tempo acabar.

⏱ **20 minutos.**

---
---

# ✂️ CARTÃO — MODO 2
## Walkthrough guiado pelo autor

> O autor conduz a plateia pelo raciocínio dele. Formalidade baixa, foco em
> entendimento compartilhado.

**Papéis**

| Papel | Quantos | O que faz |
|---|---|---|
| **Autor** | 1 | Assume o papel do @dev.junior. Lê o código em voz alta e **explica a intenção de cada bloco**, como se defendesse o PR |
| **Participantes** | 4 | Interrompem com perguntas. Não podem afirmar "isso está errado" — só podem **perguntar**: "o que acontece se...?", "por que aqui é `<=`?" |
| **Escriba** | 1 | Anota os pontos em que o autor **hesitou, se contradisse ou não soube responder** |

**Procedimento**

1. (3 min) O Autor lê sozinho o código para conseguir explicá-lo.
2. (14 min) O Autor percorre o arquivo de cima a baixo explicando. Os participantes
   só fazem perguntas.
3. (3 min) O grupo converte as hesitações do autor em defeitos na ata.

**Restrição de ouro**

> Participante que afirmar um defeito em vez de perguntar perde a vez.
> A técnica é: **a pergunta certa faz o autor achar o próprio defeito.**

⏱ **20 minutos.**

---
---

# ✂️ CARTÃO — MODO 3
## Revisão Técnica com checklist e papéis formais

> O modo mais próximo do que a norma IEEE 1028 chama de *technical review*.

**Papéis (obrigatórios e exclusivos)**

| Papel | Quantos | O que faz |
|---|---|---|
| **Moderador** | 1 | Controla o tempo, mantém o foco em detectar (não em consertar), corta discussão de solução |
| **Leitor** | 1 | Conduz a leitura do artefato em ordem, item de checklist por item de checklist |
| **Revisor A** | 1 | Aplica a **seção 1 e 2** do checklist (conformidade com requisito, lógica) |
| **Revisor B** | 1 | Aplica a **seção 3 e 4** do checklist (segurança, testes) |
| **Revisor C** | 1 | Aplica a **seção 5** do checklist (manutenibilidade) e faz o contraditório dos demais |
| **Escriba** | 1 | Preenche a ata. **Não opina.** |

**Procedimento**

1. (4 min) **Preparação individual e silenciosa.** Cada revisor lê o
   `docs/RF-014.md` e depois o diff do PR, marcando o que der.
   *Sem conversa nesta fase.*
2. (13 min) **Reunião.** O Leitor conduz item a item pelo `A5_checklist.md` (em papel).
   Para cada item, cada revisor reporta. O Escriba registra.
3. (3 min) O Moderador classifica cada achado em severidade (Alta / Média / Baixa).

**Restrições**

- Ninguém propõe correção. Defeito registrado é defeito fechado.
- O Moderador **não** revisa. O trabalho dele é o processo.

⏱ **20 minutos.**

---
---

# ✂️ CARTÃO — MODO 4-A
## Revisão assistida por IA — *prompt genérico*

> Cenário realista: "joguei o código no chat e pedi pra revisar".

**Papéis**

| Papel | Quantos | O que faz |
|---|---|---|
| **Operador** | 1 | Executa o prompt no LLM (usa o `A7_prompts_IA.md`, **PROMPT A**) |
| **Triadores** | 3 | Para cada achado da IA, decidem: **confirmado**, **falso positivo** ou **não sei** — abrindo o código para checar |
| **Caçador de omissões** | 1 | Lê o código por conta própria procurando o que a IA **não** disse |
| **Escriba** | 1 | Preenche a ata, marcando a origem de cada achado (IA / humano) |

**Procedimento**

1. (4 min) O Operador roda o **PROMPT A** exatamente como está escrito.
   *Se não houver internet, use a saída pré-gerada em `A8_saida_IA_planoB.md` — Saída A.*
2. (11 min) Triagem: item por item, o grupo confirma ou descarta. **Nada entra na ata
   sem ser verificado no código.**
3. (5 min) O Caçador reporta o que faltou; o grupo decide o que incluir.

**Restrição de ouro**

> **Nenhum achado da IA vai para a ata sem confirmação humana no código.**
> Falso positivo aceito conta contra o grupo no quadro final.

⏱ **20 minutos.**

---
---

# ✂️ CARTÃO — MODO 4-B
## Revisão assistida por IA — *prompt estruturado*

> Mesmo modelo, mesmo código, mesmo tempo. Só muda o que se entrega à IA.

**Papéis:** iguais aos do Modo 4-A.

**Procedimento**

1. (5 min) O Operador roda o **PROMPT B** do `A7_prompts_IA.md`, que inclui o
   requisito RF-014 completo, o papel esperado, o checklist e o formato de saída.
   *Sem internet: use `A8_saida_IA_planoB.md` — Saída B.*
2. (10 min) Triagem confirmando cada achado no código.
3. (5 min) O Caçador de omissões reporta o que a IA ainda deixou passar.

**Restrição de ouro:** a mesma — nada entra na ata sem confirmação humana.

⏱ **20 minutos.**

---
---

# ✂️ CARTÃO — MODO 5
## Leitura Baseada em Perspectiva (*Perspective-Based Reading*)

> Cada revisor lê o mesmo artefato com um par de óculos diferente.

**Papéis (cada um lê o código INTEIRO, sob a sua perspectiva)**

| Papel | Pergunta que guia a leitura |
|---|---|
| **Perspectiva Cliente / Requisito** | "Abro o RF-014 ao lado do código. Cada regra RN-01 a RN-08 está implementada? Onde?" |
| **Perspectiva Testador** | "Que caso de teste eu escreveria que quebraria este código? Os testes existentes provam alguma coisa?" |
| **Perspectiva Atacante** | "Se eu quisesse invadir ou vazar dado deste sistema, por onde eu entraria?" |
| **Perspectiva Mantenedor** | "Vou mexer nisso daqui a 8 meses sem o autor. O que vai me atrapalhar?" |
| **Perspectiva Operação** | "Isso vai para produção no pico da matrícula, com 3000 alunos simultâneos. O que quebra?" |
| **Escriba/Moderador** | Consolida, elimina duplicatas e cronometra |

**Procedimento**

1. (12 min) **Leitura individual e silenciosa**, cada um na sua perspectiva.
2. (8 min) Rodada de consolidação: cada perspectiva reporta seus achados; o Escriba
   registra e marca quando dois papéis acharam o mesmo defeito.

**Restrição de ouro**

> Não saia da sua perspectiva. Se o Mantenedor vir um problema de segurança,
> ele **anota mas não reporta** — quem reporta é o Atacante. A pergunta interessante
> no final é: *quantos defeitos só uma perspectiva pegou?*

⏱ **20 minutos.**

---
---

# ✂️ CARTÃO — MODO 6
## Pair Review / Over-the-shoulder rotativo

> O modo mais barato e mais comum em equipes ágeis. Duas pessoas, uma tela.

**Papéis**

| Papel | Quantos | O que faz |
|---|---|---|
| **Piloto** | 1 por rodada | Controla a tela, rola o código, lê em voz alta |
| **Copiloto** | 1 por rodada | Questiona, aponta, dita para a ata |
| **Escriba** | 1 fixo | Registra os achados de todas as rodadas |
| **Observador de processo** | 1 fixo | Cronometra as rodadas e anota **quando** cada defeito apareceu (minuto) |

**Procedimento**

1. Formem duplas rotativas: **4 rodadas de 5 minutos**. A cada rodada, troca-se a dupla
   (quem era copiloto vira piloto; entra alguém novo).
2. Cada nova dupla **continua de onde a anterior parou** — não recomeça do zero.
3. O Escriba mantém a ata única do grupo.

**Restrição de ouro**

> Só duas pessoas olham a tela por vez. Os demais **não podem** ler o código enquanto
> esperam a vez.
> Pergunta de fechamento para este grupo: *a taxa de descoberta caiu ou subiu ao longo
> das 4 rodadas?* Olhem os minutos anotados pelo Observador.

⏱ **20 minutos (4 × 5 min).**
