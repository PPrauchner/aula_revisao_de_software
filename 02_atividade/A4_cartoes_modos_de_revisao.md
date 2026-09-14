# Cartões dos Modos de Revisão

> **Para a squad:** um cartão por grupo. Para imprimir, use os PDFs avulsos em
> `pdf_impressao/cartoes/` — um arquivo de uma página por cartão, já nomeado pelo grupo. Os grupos **não** devem
> saber qual modo os outros receberam antes da rodada de comparação.

## Distribuição (7 grupos · 40 alunos)

| Grupo | Modo | Nº de integrantes | Observação |
|---|---|---|---|
| **G1** | M1 — Revisão informal (ad hoc) | **5** | grupo de controle; funciona com qualquer tamanho |
| **G2** | M2 — Walkthrough guiado pelo autor | **5** | |
| **G3** | M3 — Revisão técnica com checklist | **6** | 🔒 par controlado |
| **G4** | M4-A — Revisão assistida por IA (**prompt genérico**) | **6** | 🔒 par controlado |
| **G5** | M5 — Leitura baseada em perspectiva | **6** | 5 perspectivas + escriba |
| **G6** | M3 — Revisão técnica com checklist | **6** | 🔒 ⭐ **duplicado de propósito** |
| **G7** | M4-B — Revisão assistida por IA (**prompt estruturado**) | **6** | 🔒 ⭐ **duplicado de propósito** |

> 🔒 **G3, G4, G6 e G7 têm tamanho travado em 6.** São os pares comparados na
> revelação final; se um encolher, a comparação deixa de medir o método e passa a
> medir o número de pessoas. Toda falta é absorvida por **G1 e G2**, nesta ordem.
> Se for inevitável encolher um par, **encolha os dois juntos** — simetria vale
> mais que tamanho.

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
| **Participantes** | 3 | Interrompem com perguntas. Não podem afirmar "isso está errado" — só podem **perguntar**: "o que acontece se...?", "por que aqui é `<=`?" |
| **Escriba** | 1 | Anota os pontos em que o autor **hesitou, se contradisse ou não soube responder** |

**Procedimento**

1. (3 min) O Autor lê sozinho o código para conseguir explicá-lo.
2. (14 min) O Autor percorre o arquivo de cima a baixo explicando. Os participantes
   só fazem perguntas.
3. (3 min) O grupo converte as hesitações do autor em defeitos na ata.

**Restrição de ouro**

> Participante que afirmar um defeito em vez de perguntar perde a vez.
> A técnica é: **a pergunta certa faz o autor achar o próprio defeito.**

**Se o grupo tiver menos gente**

> Tire dos **Participantes**. Autor e Escriba nunca saem. O piso do modo é **3**
> (autor + 1 participante + escriba) — abaixo disso não há plateia e o walkthrough
> vira leitura em voz alta.

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

**Se o grupo tiver 5**

> O **Leitor acumula o papel de Revisor C** (seção 5 do checklist + contraditório).
> Moderador e Escriba **nunca** acumulam nada: são justamente os papéis que a aula
> quer mostrar como não-produtores de achado.

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

**Se o grupo tiver 5**

> Três Triadores viram **dois**. Operador, Caçador de omissões e Escriba permanecem —
> o Caçador é quem sustenta a pergunta "o que a IA **não** disse".

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

**Se o grupo tiver 5**

> A mesma regra do Modo 4-A: três Triadores viram dois.

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

**Se o grupo tiver 5**

> A perspectiva **Mantenedor** acumula o Escriba/Moderador. É a lente com menos
> achado exclusivo. **Cliente/Requisito** e **Operação** ficam intactas — elas carregam
> os defeitos de conformidade e a condição de corrida.

⏱ **20 minutos.**
