# Slides — Revisão de Software: conceitos, tipos e papéis

> **Como usar este arquivo:** cada bloco `## Slide N` é um slide. `**Título**` é o
> título, o corpo é o que vai na tela, e `> 🎤` são as **notas do apresentador**
> (não vão para a tela). Formato pronto para gerar o HTML depois.
>
> **Convenção visual sugerida:** fundo claro, uma ideia por slide, no máximo 6 linhas
> de texto. Os slides 11, 17, 33 e 36 são os "slides-âncora" — a turma volta a eles.

---

# BLOCO 1 — Abertura (A1) · slides 1–4 · 5 min

## Slide 1 — Capa

**Revisão de Software**
*conceitos, tipos e papéis*

Disciplina · Squad [nomes dos 6] · [data]

> 🎤 Não gaste mais de 15 segundos aqui. A aula começa no slide 2.

---

## Slide 2 — O Pull Request #142

```
PR #142 · feat(matricula): implementa RF-014
Autor: @dev.junior
Pipeline: ✅ verde        Testes: ✅ 2/2 passando

"Implementei o RF-014 conforme combinado na daily.
 Testes passando localmente (2/2 verdes).
 Acho que dá pra fazer o merge hoje."
```

### **Mergeia?**

> 🎤 Pergunte de verdade e espere resposta. Alguém vai dizer que sim, ou que "olharia
> rápido". Aceite a resposta sem corrigir. Diga: *"guarda essa resposta. Daqui a 40
> minutos vocês vão revisar esse PR. Ele tem 12 defeitos plantados — e nenhum grupo
> aqui vai achar os 12."*

---

## Slide 3 — O que vai acontecer hoje

| | |
|---|---|
| **40 min** | Conceitos, tipos e papéis |
| **30 min** | Vocês revisam o PR #142 — cada grupo com um **método diferente** |
| **15 min** | Comparamos os resultados no quadro |
| **5 min** | O que isso significa |

**Promessa da aula:** ao final, vocês vão saber não só *o que é* revisão de software,
mas **qual tipo escolher, quando, e o que cada um deixa passar.**

> 🎤 Deixe claro que a atividade é o centro da aula e que a ata preenchida é entregue.

---

## Slide 4 — Onde revisão se encaixa

```
                    VERIFICAÇÃO & VALIDAÇÃO
                             │
          ┌──────────────────┴──────────────────┐
          │                                     │
   ANÁLISE ESTÁTICA                     ANÁLISE DINÂMICA
   (não executa o código)               (executa o código)
          │                                     │
   ┌──────┴───────┐                    ┌────────┴────────┐
 REVISÃO    Ferramentas de           Testes        Testes de
 (humana)   análise estática      (unit/integr.)   desempenho
            (linter, SAST)
```

**Revisão = verificação estática conduzida por pessoas.**
Aplica-se a **qualquer artefato**: requisito, arquitetura, código, teste, manual, contrato.

> 🎤 Conecte com a aula anterior de conceitos de V&V. Enfatize: revisão não é só de
> código. O artefato mais lucrativo de revisar é o **requisito**, porque é onde o
> defeito é mais barato de corrigir.

---

# BLOCO 2 — Por que revisar (A2) · slides 5–9 · 7 min

## Slide 5 — Definição

> **Revisão de software** é o exame de um artefato de software por pessoas, com o
> objetivo de **detectar defeitos**, avaliar conformidade com padrões e especificações,
> e recomendar melhorias.
>
> — em linha com a **ISO/IEC/IEEE 12207** e a **IEEE Std 1028** (*Standard for Software Reviews and Audits*)

**Três palavras que definem o resto da aula:**

- **Detectar**, não corrigir
- **Artefato**, não pessoa
- **Sistemática**, não "dar uma olhada"

> 🎤 Essas três palavras voltam nas regras de ouro (slide 23) e nas regras da atividade.

---

## Slide 6 — O defeito fica mais caro a cada fase

```
Custo relativo de corrigir o MESMO defeito
(ordem de grandeza — Boehm e trabalhos posteriores)

Requisitos   ▏1×
Projeto      ▎3–6×
Codificação  ▍10×
Teste        ███ 15–40×
Produção     ██████████████ 40–100×+
```

**Revisão é a técnica que age nas duas primeiras colunas** — antes de existir código
para testar.

> 🎤 Seja honesto: esses números variam muito entre estudos e contextos. O que é
> robusto é a **forma da curva**, não o valor exato. O ponto: quanto mais cedo, mais barato.

---

## Slide 7 — O que revisão pega que teste não pega

| Defeito | Teste pega? | Revisão pega? |
|---|:---:|:---:|
| Regra do requisito **não implementada** | ❌ | ✅ |
| Constante com valor **revogado** pelo cliente | ❌ | ✅ |
| Código correto mas **ilegível / não manutenível** | ❌ | ✅ |
| Requisito **ambíguo ou não verificável** | ❌ | ✅ |
| Teste que **não testa nada** | ❌ | ✅ |
| Falha de comportamento em tempo de execução | ✅ | 🔸 |
| Vazamento de memória, lentidão sob carga | ✅ | ❌ |

**Teste só encontra o que você lembrou de testar. Revisão encontra o que você esqueceu.**

> 🎤 A linha "teste que não testa nada" é a que vai bater na atividade. Marque-a.

---

## Slide 8 — Eficácia de remoção de defeitos

Nenhuma técnica isolada chega perto de 100%. Ordens de grandeza consolidadas na
literatura (Fagan/IBM, Capers Jones e replicações posteriores):

| Técnica | Faixa típica de remoção |
|---|---|
| Teste unitário | ~30 – 35% |
| Teste de integração / sistema | ~35 – 50% |
| Revisão informal | ~25 – 40% |
| **Inspeção formal** | **~60 – 90%** |

**Só a combinação passa de 95%.** É por isso que a pergunta certa nunca é
"revisão **ou** teste".

> 🎤 Se alguém questionar os números, é justo: variam por domínio e por estudo. O ponto
> defensável é a ordem: inspeção formal > revisão informal ≈ teste unitário isolado, e
> nenhuma sozinha é suficiente.

---

## Slide 9 — Os benefícios que ninguém mede

Além de achar defeito, revisão produz:

- **Transferência de conhecimento** — o código deixa de ter um único dono
- **Padronização** — a equipe converge sem precisar de documento de padrão
- **Propriedade coletiva** — "esse código é da equipe", não "do fulano"
- **Formação** — é onde o júnior aprende mais rápido
- **Rastro de auditoria** — a ata é evidência para certificação e para postmortem

### E a pergunta da abertura: o pipeline estava **verde**. O verde prova o quê?

> 🎤 Feche seu bloco exatamente nessa pergunta e passe para o A3.

---

# BLOCO 3 — Tipos de revisão (A3) · slides 10–17 · 9 min

## Slide 10 — Três eixos para classificar

Antes de decorar nomes, entenda que "tipo de revisão" varia em **três dimensões
independentes**:

| Eixo | Extremos |
|---|---|
| **Formalidade** | ad hoc ⟷ processo definido com fases, critérios e métricas |
| **Sincronia** | reunião presencial ⟷ assíncrona por ferramenta (Pull Request) |
| **Quem conduz** | o autor apresenta ⟷ um moderador neutro conduz |

Um code review de PR no GitHub é: **formalidade média · assíncrono · conduzido pelo revisor**.

> 🎤 Esse slide evita a confusão clássica de tratar "code review" e "inspeção" como
> sinônimos ou como opostos. Eles são pontos diferentes em eixos diferentes.

---

## Slide 11 — ⭐ O espectro da formalidade

```
  MENOS FORMAL                                              MAIS FORMAL
  menor custo                                               maior custo
  menor eficácia                                            maior eficácia
  ─────────────────────────────────────────────────────────────────────▶

  Revisão      Pair review /     Walkthrough    Revisão      Inspeção      Auditoria
  informal     over-the-                        técnica      formal
  (ad hoc)     shoulder                                      (Fagan)

  minutos      minutos           ~1 hora        1–2 horas    horas         dias
  1 pessoa     2 pessoas         grupo          grupo        grupo         externo
                                 autor conduz   moderador    moderador     auditor
                                                             + métricas    + conformidade
```

> 🎤 **Slide-âncora.** Volte a ele no slide 17 e no fecho. Diga: "vocês vão aplicar
> cinco pontos diferentes desse espectro daqui a pouco, na mesma sala, no mesmo código."

---

## Slide 12 — Revisão informal (*ad hoc*)

**O que é:** alguém pede a outra pessoa para olhar. Sem processo, sem registro.

| | |
|---|---|
| ✅ **A favor** | Custo quase zero, imediata, sem burocracia |
| ❌ **Contra** | Sem registro, sem cobertura garantida, depende inteiramente de quem revisa |
| 🎯 **Quando usar** | Mudança pequena, baixo risco, artefato descartável |

> É o que **a maioria das equipes realmente faz** — e é o nosso grupo de controle na atividade.

---

## Slide 13 — Pair review / *over-the-shoulder*

**O que é:** duas pessoas, uma tela. Uma conduz, a outra questiona em tempo real.
Programação em par é o caso extremo: revisão contínua durante a escrita.

| | |
|---|---|
| ✅ **A favor** | Feedback imediato, ótimo para transferir conhecimento, zero atraso |
| ❌ **Contra** | Custa duas pessoas ao mesmo tempo; sem registro; a fadiga chega rápido |
| 🎯 **Quando usar** | Onboarding, código difícil, decisão de projeto em aberto |

---

## Slide 14 — Walkthrough

**O que é:** o **autor** conduz um grupo pelo artefato, explicando o raciocínio.
Objetivo primário é **entendimento compartilhado**; detectar defeito é consequência.

| | |
|---|---|
| ✅ **A favor** | Excelente para alinhar entendimento e formar equipe; baixa cerimônia |
| ❌ **Contra** | O autor conduz — logo, ele guia a atenção para onde **ele** acha importante |
| 🎯 **Quando usar** | Artefato novo, arquitetura, decisão que a equipe precisa comprar |

> 🎤 O viés do autor é o ponto central. Ele não esconde defeito de má-fé: ele
> simplesmente não olha para onde não desconfia. O grupo G2 vai sentir isso na pele.

---

## Slide 15 — Revisão técnica

**O que é:** grupo qualificado avalia o artefato quanto à **conformidade com
especificações e padrões**, conduzido por um **moderador** (não pelo autor), com
checklist e registro.

| | |
|---|---|
| ✅ **A favor** | Cobertura sistemática, achados registrados, independente do autor |
| ❌ **Contra** | Exige preparação individual e agenda de várias pessoas |
| 🎯 **Quando usar** | Código que vai para produção, artefato com requisito associado |

> **É o padrão do que se chama de "code review sério" na indústria.**

---

## Slide 16 — Inspeção formal (Fagan)

**O que é:** processo definido, com **fases** (planejamento, visão geral, preparação,
reunião, retrabalho, acompanhamento), **critérios de entrada e saída**, papéis
formais e **métricas coletadas** (defeitos por hora, por KLOC, taxa de retrabalho).

| | |
|---|---|
| ✅ **A favor** | A maior eficácia de remoção conhecida; gera dado para melhorar o processo |
| ❌ **Contra** | Cara. Horas de várias pessoas para poucas centenas de linhas |
| 🎯 **Quando usar** | Software crítico, artefato caro de errar, contexto certificado |

### ➡️ **A próxima squad passa uma aula inteira só neste quadradinho.**

> 🎤 **Não detalhe as fases.** Uma frase por fase no máximo. Esse slide é gancho,
> não conteúdo — a próxima aula é sobre isso.

---

## Slide 17 — ⭐ Comparação e os 5 tipos da IEEE 1028

A **IEEE Std 1028** define formalmente **cinco** tipos de revisão:

| Tipo (IEEE 1028) | Quem conduz | Objetivo principal | Registro |
|---|---|---|---|
| **Revisão gerencial** | gestão | avaliar progresso e adequação de plano | sim |
| **Revisão técnica** | moderador | conformidade com especificação e padrão | sim |
| **Inspeção** | moderador treinado | **detectar defeitos** com processo e métrica | sim, formal |
| **Walkthrough** | o autor | entendimento, formação, achados secundários | opcional |
| **Auditoria** | auditor **externo** | conformidade com regulamento/contrato | sim, formal |

> 🎤 Chame atenção para dois pontos: (1) **revisão gerencial não busca defeito** — busca
> avaliar plano; (2) **auditoria é externa** e não é feita pela equipe. Pergunta rápida
> para a turma: *"code review de Pull Request é qual desses cinco?"* Resposta honesta:
> normalmente é revisão técnica com formalidade reduzida — a norma é de 2008 e a
> indústria criou uma variante assíncrona baseada em ferramenta.

---

# BLOCO 4 — Papéis (A4) · slides 18–23 · 8 min

## Slide 18 — Por que papéis, e não "todo mundo olha"

Sem papéis definidos acontece o previsível:

- **Difusão de responsabilidade** — todos assumem que outro vai olhar aquela parte
- **Sobreposição** — três pessoas revisam o mesmo trecho e ninguém revisa o resto
- **Deriva** — a reunião vira discussão de solução e ninguém registra defeito
- **Silêncio hierárquico** — ninguém contradiz o sênior

**Papel é o mecanismo que transforma um grupo de pessoas olhando em um processo de detecção.**

---

## Slide 19 — Os papéis

| Papel | Faz | **Não faz** |
|---|---|---|
| **Moderador / Líder** | conduz, controla tempo, garante o processo, media conflito | não revisa, não decide o mérito técnico |
| **Autor** | fornece o artefato, esclarece dúvidas, faz o retrabalho | **não se defende** e não conduz (exceto no walkthrough) |
| **Leitor** | apresenta o artefato ao grupo, em ritmo controlado | não opina sobre o que lê |
| **Inspetor / Revisor** | detecta e relata defeitos | **não propõe correção durante a reunião** |
| **Escriba / Registrador** | registra cada defeito na ata: local, tipo, severidade | não opina, não filtra |
| **Gerência** | garante recursos e tempo; recebe dados agregados | **não participa da reunião** |

> 🎤 A última linha é a mais importante e a mais violada na prática.

---

## Slide 20 — O moderador

O único papel que **não produz nenhum achado** — e o que mais determina o resultado.

Ele existe para:

- Manter o foco em **detectar**, cortando toda discussão de solução
- Garantir que todo o artefato foi coberto, não só a parte interessante
- **Proteger o autor**: a conversa é sobre o artefato
- **Proteger o júnior**: garantir que ele fala antes do sênior
- Encerrar a sessão quando a detecção começa a cair

> 🎤 "Se a reunião de revisão virou reunião de arquitetura, o moderador falhou."

---

## Slide 21 — Por que gerência fica fora da sala

Se a revisão é usada para **avaliar pessoas**, ela deixa de funcionar:

- O autor esconde o que não está pronto
- Os revisores suavizam achados para não prejudicar o colega
- Ninguém submete artefato cedo — só quando "está bom"

> **Dado de revisão mede o processo, nunca o desempenho individual.**
> Essa regra está na IEEE 1028 e é o que separa uma cultura que revisa de uma que finge revisar.

---

## Slide 22 — 💬 Pergunta para a turma

### Qual desses papéis vocês acham que é o mais difícil?

*(moderador · autor · leitor · inspetor · escriba)*

> 🎤 **Deixe a turma responder antes de avançar.** Aceite qualquer resposta.
> A resposta que interessa: **moderador**, porque é o único que precisa se conter —
> ele enxerga defeitos e não pode reportá-los, ou vira revisor e para de conduzir.
> Segunda resposta boa: **autor**, porque exige separar o artefato da própria identidade.
> Amarre: *"daqui a pouco vocês vão exercer esses papéis de verdade."*

---

## Slide 23 — As três regras de ouro

### 1. Revisa-se o **artefato**, não a pessoa
"Este método retorna três tipos diferentes" ≠ "você não sabe escrever método"

### 2. **Detectar** ≠ corrigir
Discutir a solução durante a revisão consome o tempo de detecção. Anote e siga.

### 3. **Registro** é o produto
Revisão sem ata é conversa. A ata é o que permite acompanhar, medir e melhorar.

> 🎤 Essas três regras estão impressas no enunciado da atividade. Cite isso.

---

# BLOCO 5 — Como se revisa bem (A5) · slides 24–29 · 7 min

## Slide 24 — O achado mais consistente da pesquisa

> **A preparação individual e silenciosa, antes da reunião, encontra mais defeitos
> do que a reunião em si.**

A reunião serve para **consolidar, eliminar duplicatas e classificar severidade** —
não para descobrir.

**Implicação prática:** revisão que começa com o grupo abrindo o arquivo junto está
usando o formato mais caro (várias pessoas ocupadas) na fase menos produtiva.

> 🎤 Os modos M3 e M5 da atividade forçam preparação individual. Não conte isso à turma
> agora — deixe aparecer no quadro comparativo.

---

## Slide 25 — Checklist

**O que é:** lista de verificações derivada dos defeitos que a **sua** equipe realmente
comete, aplicada item a item.

- ✅ Garante **cobertura mínima**: nenhuma área fica sem olhar
- ✅ Torna a revisão **repetível** entre pessoas diferentes
- ⚠️ **Risco:** vira burocracia se ninguém o atualiza
- ⚠️ **Risco:** checklist longo demais faz o revisor marcar sem ler

**Regra prática:** o checklist nasce do **histórico de defeitos e incidentes**, não da internet.
Item que nunca pegou nada em um ano deve ser removido.

---

## Slide 26 — Leitura baseada em perspectiva

Em vez de todos lerem tudo do mesmo jeito, **cada revisor lê o artefato inteiro sob
um papel diferente**:

| Perspectiva | Pergunta que guia a leitura |
|---|---|
| Cliente / requisito | "cada regra especificada está aqui?" |
| Testador | "que caso quebraria isso?" |
| Atacante | "por onde eu invadiria?" |
| Mantenedor | "vou mexer nisso em 8 meses. O que me atrapalha?" |
| Operação | "isso vai para produção no pico. O que quebra?" |

**Por que funciona:** reduz a sobreposição entre revisores e amplia a cobertura de
tipos de defeito com o mesmo número de pessoas.

---

## Slide 27 — Os números que a prática consolidou

| Limite | Valor de referência | Por quê |
|---|---|---|
| **Tamanho do lote** | ≤ **200–400 linhas** por sessão | acima disso a taxa de detecção despenca |
| **Ritmo de leitura** | ≤ **~500 linhas/hora** | ler mais rápido é ler menos |
| **Duração da sessão** | ≤ **60 minutos** | fadiga derruba a detecção |
| **Preparação** | obrigatória e individual | ver slide 24 |

*(Faixas consolidadas a partir de estudos empíricos de larga escala em revisão de código;
trate como ordem de grandeza, não como precisão.)*

> 🎤 Aponte a ironia: o PR #142 adiciona ~150 linhas e os grupos terão **20 minutos**.
> Está dentro dos limites. Ainda assim ninguém vai achar tudo.

---

## Slide 28 — Anatomia de um bom comentário de revisão

| ❌ Ruim | ✅ Bom |
|---|---|
| "Isso está errado." | "Linha 37: `vagas_ocupadas <= vagas_total` aceita matrícula com a turma cheia. RN-03 exige `<`." |
| "Não gostei desse método." | "O método retorna `bool` em 3 caminhos e `dict` em 1; o chamador não consegue distinguir os casos." |
| "Você poderia ter usado um dicionário aqui." | "Sugestão (não bloqueante): um dicionário evitaria o laço." |

**Um bom comentário tem: localização · o que está errado · por que é um problema.**
E marca explicitamente o que é **bloqueante** e o que é **sugestão**.

---

## Slide 29 — Anti-padrões

| Anti-padrão | O que é | Por que mata a revisão |
|---|---|---|
| **LGTM automático** | aprovar sem ler | dá selo de qualidade a artefato não revisado — pior que não revisar |
| **Nitpicking** | só comentários de estilo | consome o crédito de atenção com o que menos importa |
| **Bikeshedding** | debater o trivial, ignorar o difícil | a discussão vai para onde todos têm opinião |
| **Revisão-emboscada** | usar a revisão para expor alguém | destrói a segurança psicológica; ninguém mais submete cedo |
| **PR gigante** | 3.000 linhas de uma vez | garante aprovação sem leitura |

> 🎤 Pergunte: *"quantos aqui já deram LGTM sem ler?"* Levante a mão você também.

---

# BLOCO 6 — IA em revisão + gancho (A6) · slides 30–33 · 4 min

## Slide 30 — Onde a IA entra

A revisão assistida por LLM ocupa hoje um lugar novo no espectro do slide 11:
**custo quase zero, disponibilidade imediata, cobertura ampla, confiabilidade variável.**

Ela **não** é um tipo de revisão à parte — é um **revisor a mais**, com um perfil de
acerto muito específico.

**A pergunta certa não é "IA substitui revisor?", e sim: _que classe de defeito ela
detecta bem, e quem valida o resultado dela?_**

---

## Slide 31 — O perfil de acerto

| A IA tende a ir bem em | A IA tende a falhar em |
|---|---|
| Padrões conhecidos (SQL injection, exceção silenciada) | **Conformidade com o requisito** — se você não der o requisito, ela não tem como saber |
| Convenções, legibilidade, nomes | **Defeitos de omissão** — o que deveria existir e não existe |
| Cobertura ampla e instantânea do arquivo | **Comportamento sob concorrência e carga** |
| Sugerir a correção junto do achado | **Priorizar**: trata estilo e falha crítica com o mesmo peso |
| Nunca cansar, nunca pular trecho | **Intenção** — por que este teste foi escrito assim |

> 🎤 Não faça juízo de valor. Descreva o perfil. A atividade vai produzir a evidência.

---

## Slide 32 — Os três riscos

### 1. Falso positivo
Ela aponta problema onde não há. Custo: tempo do revisor humano.

### 2. Alucinação
Ela afirma que o código faz algo que ele **não faz**. Custo: correção de bug inexistente
— e perda de confiança na ferramenta.

### 3. Viés de automação
Você aceita a lista porque veio formatada, confiante e completa.
**É o risco mais perigoso, porque é invisível.**

> **Quem valida a IA precisa saber revisar.** Uma equipe que nunca aprendeu a revisar
> não tem como usar bem um revisor automático — ela não sabe quando ele está errado.

---

## Slide 33 — ⭐ Onde estamos, e onde a próxima aula entra

```
  Revisão      Pair       Walkthrough   Revisão     Inspeção      Auditoria
  informal     review                   técnica     formal
  ─────────────────────────────────────────────────────────────────────▶
      ▲          ▲            ▲            ▲            ▲
      │          │            │            │            │
    G1, G4     G8           G2         G3, G5, G6, G7   PRÓXIMA AULA
                                                        (Fagan)
```

**Hoje:** o mapa inteiro — conceitos, tipos, papéis, e a experiência de aplicar cinco
pontos diferentes deste espectro.
**Próxima aula:** o extremo direito, levado a sério.

---

# ATIVIDADE · slides 34–35

## Slide 34 — A atividade: Campeonato de Revisão

**O mesmo PR #142. Oito grupos. Métodos diferentes.**

1. Cada grupo recebe um **cartão de modo** — não mostre para os outros grupos
2. **2 min** para distribuir os papéis que o cartão define
3. **20 min** de revisão, seguindo o cartão à risca
4. **5 min** para fechar a **ata de revisão** — que é entregue à professora

**No repositório:** PR #142 (aba *Files changed*) · `docs/RF-014.md` · `CONTRIBUTING.md`
**Em papel:** cartão do modo · ata de revisão

**Sem conta no GitHub, sem comentar no PR, sem linter e sem IA** — exceto os grupos que receberam o cartão de revisão assistida.

> 🔲 **QR CODE GRANDE AQUI** — apontando direto para a aba *Files changed* do PR:
> `https://github.com/<org>/<repo>/pull/<n>/files`
> Escreva a URL curta por extenso embaixo do QR, para quem for digitar.

> 🎤 **Este slide fica no ar durante toda a atividade.** É o único jeito de um grupo
> que perdeu o link voltar a ele sem interromper a squad.

---

## Slide 35 — Regras e pontuação

**Regras**

- Revisa-se o artefato, **não o autor**
- **Registrar** o defeito, não debater a correção
- Achado **sem localização** não conta
- **Falso positivo custa** — metralhar não vence

**No quadro, cada grupo reporta**

| Defeitos reais | Falsos positivos | Críticos (de 5) | Achado exclusivo |
|---|---|---|---|

> 🎤 Última frase antes de soltar os grupos: *"vocês têm 20 minutos e um diff de 150 linhas.
> Está dentro dos limites do slide 27. Boa sorte."*

---

# COMPARAÇÃO · slides 36–38

## Slide 36 — ⭐ Matriz de cobertura

*(slide preenchido AO VIVO — projetar a tabela em branco de `A9_quadro_comparativo.md`)*

| Defeito | G1 | G2 | G3 | G4 | G5 | G6 | G7 | G8 |
|---|---|---|---|---|---|---|---|---|
| D01 … D12 | | | | | | | | |

> 🎤 **Não revele o gabarito antes de preencher.** A tabela cheia de buracos é o
> argumento visual da aula.

---

## Slide 37 — Os 12 defeitos

| ID | Defeito | Tipo | Sev. |
|---|---|---|---|
| D01 | Limite de créditos 24, requisito v1.2 diz 28 | REQ | 🔴 |
| D02 | RN-05 (choque de horário) não implementada | REQ | 🔴 |
| D03 | RN-04 tratada pela metade (falta INADIMPLENTE) | REQ | 🟠 |
| D04 | Pré-requisito sem checar aprovação | LOG | 🔴 |
| D05 | `<=` aceita matrícula com turma cheia | LOG | 🟠 |
| D06 | Condição de corrida entre verificar e ocupar a vaga | LOG | 🟠 |
| D07 | SQL injection por concatenação | SEG | 🔴 |
| D08 | CPF e token de sessão gravados em log | SEG | 🔴 |
| D09 | Teste que não verifica nada + teste que congela o bug | TST | 🟠 |
| D10 | 8 regras de negócio, 2 testes, nenhum caminho de recusa | TST | 🟠 |
| D11 | Limite duplicado com valores divergentes (24 e 28) | MAN | 🟡 |
| D12 | Retorno inconsistente + `except Exception: pass` | MAN | 🟡 |

---

## Slide 38 — As quatro leituras

### 1. Nenhum grupo achou os 12. A **união** de vocês achou quase todos.
→ Revisão é atividade **coletiva**. Revisor único é ponto cego único.

### 2. D01, D02, D03 só foram achados por quem tinha o **requisito** na mão.
→ Sem artefato de referência não se detecta defeito de **conformidade** — o mais caro de todos.

### 3. G3 e G6 usaram o **mesmo cartão** e acharam conjuntos diferentes.
→ Variabilidade entre revisores é real. Processo formal reduz — não elimina.

### 4. G4 e G7 usaram a **mesma IA** com prompts diferentes.
→ A diferença não estava no modelo. Estava no **contexto** que foi dado a ele.

> 🎤 Se ninguém achou o D06, essa é a quinta leitura e a mais importante:
> **revisão estática tem um limite.** Existem defeitos que só teste, carga ou produção
> revelam. Revisão e teste são complementares — nunca substitutos.

---

# FECHO · slides 39–40

## Slide 39 — O que levar desta aula

### **1.** Revisão detecta o que o teste não alcança — e o mais cedo possível.

### **2.** Não existe "a" revisão. Existe um espectro, e escolher o ponto certo é decisão de engenharia: **criticidade do artefato versus custo do processo.**

### **3.** Papel definido é o que transforma "várias pessoas olhando" em detecção.

**E a pergunta da abertura:** *mergeia?*

> 🎤 Feche com o gancho: *"vocês fizeram revisão técnica em 20 minutos e acharam de 2 a
> 12 defeitos. Na próxima aula vocês vão ver o extremo do espectro — a inspeção formal de
> Fagan — e por que uma empresa aceita gastar 6 horas de 4 pessoas em 200 linhas de código."*
> Recolher as atas.

---

## Slide 40 — Referências

- **IEEE Std 1028** — *IEEE Standard for Software Reviews and Audits*
- **ISO/IEC/IEEE 12207** — processos de ciclo de vida de software
- **ISO/IEC/IEEE 29119** — teste de software (para situar V&V)
- **FAGAN, M. E.** — *Design and code inspections to reduce errors in program development*, IBM Systems Journal, 1976
- **BOEHM, B.** — *Software Engineering Economics*, 1981 (curva de custo do defeito)
- **JONES, C.** — dados de eficácia de remoção de defeitos
- **BASILI, V. et al.** — *The Empirical Investigation of Perspective-Based Reading*
- **SOMMERVILLE, I.** — *Engenharia de Software*, cap. de V&V
- **PRESSMAN, R.** — *Engenharia de Software: uma abordagem profissional*, cap. de revisões

> 🎤 Deixe este slide projetado enquanto recolhe as atas.
