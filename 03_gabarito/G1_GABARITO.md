# GABARITO — PR #1 / RF-014

> **Material da squad e da professora. Não distribuir antes da rodada de comparação.**

## Resumo

| | |
|---|---|
| Defeitos-alvo plantados | **12** |
| Severidade Alta | **5** (D01, D02, D04, D07, D08) |
| Severidade Média | **5** (D03, D05, D06, D09, D10) |
| Severidade Baixa | **2** (D11, D12) |
| Achados legítimos além dos 12 | **5** (seção 3) |
| Tamanho do diff do PR | **150 linhas adicionadas** em 2 arquivos (`matricula.py`, 149 linhas · `test_matricula.py`, 67 linhas) |

---

## 1. Os 12 defeitos

### 🔴 D01 — Limite de créditos usa o valor revogado
**Onde:** `matricula.py`, linha 12 — `LIMITE_CREDITOS = 24`
**Tipo:** REQ · **Severidade:** Alta
**Por que é defeito:** o documento RF-014 v1.2 define **28** créditos (o histórico de
revisões registra a alteração de 24 → 28 pelo CONSUNI). O código implementa a regra
antiga. Reprova o **critério de aceitação nº 3**.
**Como se corrige:** `LIMITE_CREDITOS = 28`, definido em **um único lugar** (ver D11),
e idealmente carregado de configuração, já que é decisão de colegiado e vai mudar de novo.
**Só é detectável por quem abriu o documento de requisitos.** Ler o código não basta:
`24` é um número perfeitamente plausível.

### 🔴 D02 — RN-05 (choque de horário) não foi implementada
**Onde:** `matricula.py`, método `matricular` (linhas 24–48) — ausência
**Tipo:** REQ · **Severidade:** Alta
**Por que é defeito:** nenhuma verificação de conflito de horário existe. Reprova o
**critério de aceitação nº 6**. Pista no código: a classe `Turma` declara `dia_semana`,
`hora_inicio` e `hora_fim` (linhas 140–148) e **nenhum desses campos é lido em lugar algum**.
**Como se corrige:** antes de efetivar, iterar sobre `aluno.matriculas_ativas` e recusar
se houver sobreposição no mesmo `dia_semana`.
**Defeito de omissão** — a classe mais difícil de achar, porque não há nada errado para
apontar: há algo *faltando*. É o argumento para revisão guiada por requisito.

### 🟠 D03 — RN-04 implementada pela metade
**Onde:** `matricula.py`, linha 27 — `if aluno.situacao == "TRANCADO":`
**Tipo:** REQ · **Severidade:** Média
**Por que é defeito:** o requisito bloqueia `TRANCADO` **ou** `INADIMPLENTE`. O código
trata só o primeiro. Aluno inadimplente se matricula normalmente. Reprova o **critério nº 5**.
**Como se corrige:** `if aluno.situacao in ("TRANCADO", "INADIMPLENTE"):`
**Implementação parcial** é traiçoeira: o revisor vê a regra sendo tratada e marca ✓
mentalmente sem conferir se está *inteira*.

### 🔴 D04 — Pré-requisito considerado cumprido sem aprovação
**Onde:** `matricula.py`, linhas 53–64 — `_verificar_prerequisitos`
**Tipo:** LOG · **Severidade:** Alta
**Por que é defeito:** a query verifica apenas se a disciplina **aparece** no histórico.
RN-01 exige situação `APROVADO`. Aluno que cursou e **reprovou** cumpre o pré-requisito.
Reprova o **critério de aceitação nº 1**.
**Como se corrige:** `... AND codigo = ? AND situacao = 'APROVADO'` (parametrizado — ver D07).
**Padrão clássico:** testar um *proxy* da condição em vez da condição real.

### 🟠 D05 — Erro de fronteira permite matrícula acima da capacidade
**Onde:** `matricula.py`, linha 37 — `if turma.vagas_ocupadas <= turma.vagas_total:`
**Tipo:** LOG · **Severidade:** Média
**Por que é defeito:** com `vagas_total = 40` e `vagas_ocupadas = 40` (turma cheia), a
condição é verdadeira e a matrícula é efetivada — 41 alunos na turma. RN-03 exige
`vagas_ocupadas < vagas_total`. Reprova o **critério nº 4**.
**Como se corrige:** trocar `<=` por `<`.
**Off-by-one** é o defeito que checklist pega e leitura corrida não pega.

### 🟠 D06 — Condição de corrida entre verificar a vaga e ocupá-la
**Onde:** `matricula.py`, linhas 37–38 — verificação seguida de incremento
**Tipo:** LOG · **Severidade:** Média
**Por que é defeito:** clássico *check-then-act* sem transação nem bloqueio. Duas
solicitações simultâneas leem `vagas_ocupadas = 39` e ambas efetivam. RNF-03 declara
explicitamente alta concorrência. O incremento é feito **em memória** e nem sequer é
persistido — o `INSERT` grava a matrícula, mas o contador da turma não é atualizado no banco.
**Como se corrige:** `SELECT ... FOR UPDATE` / transação com bloqueio, ou constraint no
banco (`CHECK`/índice único de capacidade) que faça o banco recusar a 41ª matrícula.
**Este é o defeito que quase ninguém acha — nem a IA.** Ele não está *em* uma linha: está
na relação entre duas linhas ao longo do tempo, sob concorrência. Exige raciocinar sobre
o sistema em execução, não sobre o texto.

### 🔴 D07 — SQL Injection
**Onde:** `matricula.py`, linhas 56–61 — concatenação de string na query
**Tipo:** SEG · **Severidade:** Alta
**Por que é defeito:** `aluno.id` e `codigo` entram na SQL por concatenação. Viola
**RNF-02** e o padrão de codificação da equipe. Note a ironia: **todas as outras queries
do arquivo são parametrizadas** — esta é a exceção, o que é exatamente como acontece na vida real.
**Como se corrige:** `cursor.execute("SELECT ... WHERE aluno_id = ? AND codigo = ?", (aluno.id, codigo))`

### 🔴 D08 — Dados pessoais e credencial em log
**Onde:** `matricula.py`, linhas 83–94 — `logging.info(... cpf=%s token=%s ...)`
**Tipo:** SEG · **Severidade:** Alta
**Por que é defeito:** grava **CPF** e **token de sessão** em arquivo de log. Viola
**RNF-01**/LGPD. Log costuma ser replicado para ferramentas de observabilidade com
controle de acesso mais frouxo que o do banco — o token ainda válido no log é
credencial vazada.
**Como se corrige:** registrar apenas `aluno.id`, `turma.id`, resultado e timestamp,
como RN-06 pede. Nunca CPF, nunca token.
**Bônus (conta como achado extra):** `_registrar_log` só é chamado no caminho de
sucesso (linha 44) — RN-06 exige log de **toda** tentativa.

### 🟠 D09 — Testes verdes que não provam nada
**Onde:** `test_matricula.py`
**Tipo:** TST · **Severidade:** Média
**Por que é defeito:** dois problemas distintos, ambos contam como D09:
- `test_matricula_simples_funciona`: `assert resultado is not None` passa para
  `True`, `False` e para o `dict` de recusa. **O teste passaria mesmo se o método
  sempre recusasse a matrícula.**
- `test_limite_de_creditos`: monta aluno com 22 créditos + disciplina de 4 = 26 e
  **afirma que a matrícula deve ser recusada**. Pelo RF-014 (limite 28), 26 créditos
  **deve ser aceito**. O teste foi escrito a partir do código, não do requisito —
  ele **congela o defeito D01** e passará a proteger o bug contra correções futuras.
**Como se corrige:** derivar os testes dos critérios de aceitação, não do código pronto.
**"2/2 verdes" na descrição do PR é a armadilha da aula.** Pipeline verde não é revisão.

### 🟠 D10 — Regras de negócio sem nenhum teste
**Onde:** `test_matricula.py` — ausência
**Tipo:** TST · **Severidade:** Média
**Por que é defeito:** 8 regras de negócio, 2 testes, e nenhum deles cobre: lista de
espera (RN-03), aluno inadimplente (RN-04), pré-requisito reprovado (RN-01), choque de
horário (RN-05) ou registro de log (RN-06). Nenhum caminho de recusa é testado.
**Como se corrige:** um teste por critério de aceitação, no mínimo.

### 🟡 D11 — Constante duplicada com valores divergentes
**Onde:** `matricula.py`, linha 12 (`LIMITE_CREDITOS = 24`) vs linha 70 (`if total > 28:`)
**Tipo:** MAN · **Severidade:** Baixa
**Por que é defeito:** a mesma regra de negócio está codificada em dois pontos, com
**números diferentes**, e o segundo é um literal mágico dentro de um método de cálculo.
Quem corrigir D01 mudando só a constante deixa o `28` para trás.
**Como se corrige:** uma única fonte da verdade para o limite.
**Sinal forte:** dois valores discordantes no mesmo arquivo significam que **ninguém
sabe qual é a regra**. Isso é achado de revisão mesmo sem consultar o requisito.

### 🟡 D12 — Contrato de retorno inconsistente e exceção silenciada
**Onde:** `matricula.py`, linhas 28, 31, 35, 45, 48 (retornos) e 93–94 (`except Exception: pass`)
**Tipo:** MAN · **Severidade:** Baixa
**Por que é defeito:**
- `matricular` devolve `False`, `dict`, `True` (matriculado) e `True` (lista de espera).
  O chamador **não consegue distinguir matrícula efetivada de lista de espera**, o que
  RN-03 exige explicitamente. Um `if service.matricular(...)` mostra "matrícula confirmada"
  para quem entrou na fila.
- `except Exception: pass` engole qualquer falha do log, inclusive `AttributeError` por
  campo inexistente — e, junto com D08, faz o requisito de auditoria (RN-06) falhar em silêncio.
**Como se corrige:** um tipo de retorno único (enum ou objeto `ResultadoMatricula` com
status explícito) e tratamento de exceção que registre em vez de descartar.
**Classificado como Baixa por convenção de severidade (não causa dano direto), mas
observe que ele carrega uma violação de requisito (RN-03) dentro de si** — bom ponto de
discussão: severidade é julgamento, não fórmula.

---

## 2. Matriz de detecção esperada

> ✅ = espera-se que o modo encontre · 🔸 = pode encontrar, depende do grupo ·
> ❌ = dificilmente encontra

| Defeito | M1 Informal | M2 Walkthrough | M3 Checklist | M4-A IA genérica | M4-B IA estruturada | M5 Perspectiva | M6 Pair |
|---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| D01 limite 24≠28 | ❌ | 🔸 | ✅ | ❌ | ✅ | ✅ | ❌ |
| D02 horário ausente | ❌ | 🔸 | ✅ | ❌ | ✅ | ✅ | ❌ |
| D03 INADIMPLENTE | ❌ | 🔸 | ✅ | ❌ | ✅ | ✅ | 🔸 |
| D04 pré-req sem aprovação | 🔸 | ✅ | ✅ | 🔸 | ✅ | ✅ | 🔸 |
| D05 `<=` vaga | 🔸 | ✅ | ✅ | ✅ | ✅ | 🔸 | ✅ |
| D06 corrida | ❌ | ❌ | 🔸 | ❌ | ❌ | 🔸 | ❌ |
| D07 SQL injection | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| D08 CPF/token em log | 🔸 | ✅ | ✅ | ✅ | ✅ | ✅ | 🔸 |
| D09 teste inútil | ❌ | ❌ | ✅ | ❌ | 🔸 | ✅ | ❌ |
| D10 sem testes | 🔸 | 🔸 | ✅ | ❌ | ✅ | ✅ | 🔸 |
| D11 constante duplicada | 🔸 | 🔸 | ✅ | ✅ | ✅ | ✅ | ✅ |
| D12 contrato/except | 🔸 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Faixa esperada** | **2–5** | **5–8** | **9–12** | **4–6** | **9–11** | **9–11** | **4–7** |

**Leituras que a squad deve extrair da matriz na hora:**

1. **A linha D07 é toda ✅.** Defeito de segurança em padrão conhecido é o que qualquer
   método pega. Não é onde a escolha do método importa.
2. **As linhas D01, D02, D03 separam a turma em dois.** Quem tinha o requisito na mão
   achou; quem não tinha, não achou — e não tinha como achar.
3. **A linha D06 é quase toda ❌ ou 🔸.** Nenhum método garante achá-lo. É o limite da
   revisão estática: existem defeitos que só teste de carga, análise de concorrência ou
   incidente em produção revelam. Revisão não substitui teste — é complementar.
4. **M3 e M5 lideram, e são os dois modos que forçam preparação individual antes da
   discussão em grupo.** É o achado empírico mais consistente da literatura de inspeção.
5. **M4-A vs M4-B com o mesmo modelo.** A diferença inteira está no contexto fornecido.

---

## 3. Achados legítimos além dos 12

> Se um grupo trouxer um destes, **não é falso positivo** — vale como achado exclusivo.

| ID | Onde | Descrição |
|---|---|---|
| **B-01** | `matricular`, linha 44 | `_registrar_log` só é chamado no sucesso. RN-06 exige log de **toda** tentativa, inclusive recusas. |
| **B-02** | `Aluno.formando` (linha 122) — declarado no construtor | RN-07 (prioridade de formando) não implementada; campo declarado e nunca usado. |
| **B-03** | RF-014, RN-07 e RN-08 | **Defeitos do requisito, não do código:** "prioridade" não define critério e "rapidamente" não é mensurável. Requisito não verificável é defeito — e é o mais barato de corrigir agora. |
| **B-04** | `cancelar_matricula`, linhas 106–114 | Decrementa `vagas_ocupadas` sem verificar se a matrícula existia; `DELETE` que não apaga nada ainda decrementa. Contador pode ficar negativo. |
| **B-05** | `matricular`, linha 25 | `cursor` é criado no início mas não é usado no caminho de recusa nem no de lista de espera. Menor, mas é sinal de método com responsabilidades misturadas. |

## 4. Falsos positivos plantados (na Saída A da IA)

| Achado da IA | Veredito | Como derrubar |
|---|---|---|
| "`_adicionar_lista_espera` não faz commit" | **FALSO** | Linha 81: `self.conexao.commit()` está lá. Alucinação. |
| "`logging.warning` não será emitido com `level=INFO`" | **FALSO** | WARNING (30) > INFO (20). É emitido. A IA inverteu a hierarquia. |
| "cursor não é fechado" | **Discutível** | Depende do driver e do gerenciamento de conexão; não é verificável com o material dado. |
| "não valida `aluno`/`turma` nulos" | **Baixo valor** | Programação defensiva; nenhum requisito exige. |
| "usar `sum()` em vez do laço" | **Baixo valor** | Estilo. Apresentado com o mesmo peso do SQL injection — esse é o problema. |

---

## 5. Números esperados no quadro comparativo

| Métrica | Valor esperado |
|---|---|
| Melhor grupo individual | 9 a 12 de 12 |
| Pior grupo individual | 2 a 5 de 12 |
| **União de todos os 8 grupos** | **11 ou 12 de 12** |
| Defeito com maior chance de ninguém achar | **D06** (condição de corrida) |
| Defeito que 100% dos grupos acham | **D07** (SQL injection) |
| Falsos positivos nos grupos de IA sem triagem rigorosa | 2 a 5 |
| Diferença esperada entre G3 e G6 (mesmo método) | 1 a 3 defeitos, e **conjuntos não idênticos** |

## 6. Roteiro da revelação (usar nos 15 min de comparação)

1. Preencha a **matriz de cobertura** (`A9`) com os grupos reportando — não revele o
   gabarito antes disso.
2. Só então projete a coluna "gabarito" e some a **união**.
3. Faça a pergunta na ordem: *"quem achou o D06?"* → geralmente ninguém, ou um grupo.
   **Deixe o silêncio acontecer.** É o momento mais didático da aula.
4. Revele que **G3 e G6 tinham o mesmo cartão** e compare os conjuntos.
5. Revele que **G4 e G7 tinham prompts diferentes** e mostre a Saída B ao grupo 4.
6. Feche com a frase: *"nenhum de vocês foi um revisor ruim. Vocês foram revisores
   com métodos diferentes — e é o método que decide o que você consegue ver."*

## 7. Perguntas prováveis da turma (e respostas)

**"Então revisão só serve se eu tiver o requisito?"**
Não, mas o tipo de defeito que você acha muda. Sem o requisito você acha defeito de
construção (segurança, lógica, legibilidade). Só com o requisito você acha defeito de
**conformidade** — que é justamente o mais caro, porque foi introduzido mais cedo e
atravessou todas as fases seguintes.

**"Por que não deixar a IA revisar tudo, já que o G7 foi bem?"**
Três razões visíveis na aula: (1) ela alucinou dois defeitos inexistentes; (2) apresentou
`sum()` com o mesmo peso de SQL injection — severidade sem julgamento; (3) não achou o
D06. E há uma quarta: **quem valida a IA precisa saber revisar.** Sem isso, o
*automation bias* faz você aceitar a lista inteira.

**"Não é mais rápido só rodar teste?"**
Teste executa o código. Ele não olha o requisito, não lê nome de variável, não vê o que
está faltando. Os testes deste PR estavam **verdes** e havia 12 defeitos, sendo que
um dos próprios testes protegia um deles.

**"Qual tipo de revisão é o melhor?"**
A pergunta certa é "melhor para quê, a que custo". Revisão informal custa 10 minutos e
pega defeito óbvio. Inspeção formal custa horas de várias pessoas e pega quase tudo.
Você escolhe por criticidade do artefato — e é exatamente por isso que a próxima aula
detalha a inspeção formal de Fagan, o extremo mais caro e mais eficaz do espectro.
