# Roteiro da Aula — Revisão de Software: conceitos, tipos e papéis

**Duração:** 90 minutos · **Condução:** squad de 6 · **Turma:** 8 grupos (2 com 5 integrantes)
**Divisão macro:** 40 min teoria · 30 min prática · 15 min comparação · 5 min fecho

> Substitua "A1…A6" pelos nomes da squad antes de enviar à professora.

---

## Divisão de responsabilidades da squad

| Posição | Bloco teórico | Papel na atividade | Grupos que facilita |
|---|---|---|---|
| **A1** | Abertura e ancoragem | Distribui artefatos | G1, G2 |
| **A2** | Por que revisar | Distribui cartões de modo | G3 |
| **A3** | Tipos de revisão | Apoia os grupos de IA (internet/prompt) | G4 |
| **A4** | Papéis na revisão | Confere se todo grupo distribuiu papéis | G5, G6 |
| **A5** | Como se revisa bem | Recolhe as atas | G7 |
| **A6** | IA em revisão + gancho Fagan | **Cronômetro e quadro comparativo** | G8 |

**Regra da squad durante a atividade:** facilitador **não revisa e não entrega defeito**.
Se um grupo travar, a única intervenção permitida é uma pergunta: *"o cartão de vocês
manda fazer o quê agora?"* ou *"vocês abriram o documento de requisitos?"*.

---

## Linha do tempo

### 🕐 00:00 – 00:05 · Abertura (A1) — 5 min

- Slides 1–4.
- **Abrir com o caso, não com a definição.** Projete a descrição do PR #142:
  *"testes passando localmente (2/2 verdes), acho que dá pra fazer merge hoje"*.
  Pergunte à turma: **"mergeia?"** Deixe alguém dizer que sim.
- Anuncie: "esse PR tem 12 defeitos. Vocês vão achá-los daqui a 40 minutos —
  e nenhum grupo vai achar os 12."
- Situar: revisão é **verificação estática**; ninguém executa o código.
  Conecta com a aula de conceitos de V&V que a turma já teve.
- ⚠️ **Não** distribuir os artefatos ainda.

### 🕐 00:05 – 00:12 · Por que revisar (A2) — 7 min

- Slides 5–9.
- Custo do defeito ao longo do ciclo; eficácia de remoção de defeitos; o que revisão
  pega que teste **não** pega.
- Fechar com a pergunta retórica: *"o pipeline estava verde. O que o verde prova?"*

### 🕐 00:12 – 00:21 · Tipos de revisão (A3) — 9 min

- Slides 10–17.
- O espectro por formalidade, a tabela comparativa, os eixos ortogonais
  (síncrono/assíncrono, com/sem ferramenta, quem conduz).
- **Slide 17 é o gancho:** inspeção formal aparece como o extremo do espectro e a
  frase é: *"a próxima squad vai passar uma aula inteira só nesse último quadradinho —
  e vocês vão entender por quê."*

### 🕐 00:21 – 00:29 · Papéis (A4) — 8 min

- Slides 18–23.
- Os papéis da IEEE 1028, o que cada um faz e **o que cada um não faz**.
- As três regras de ouro (revisa-se o artefato; detectar ≠ corrigir; gerência fora da sala).
- 💡 **Momento de participação:** slide 22 — "quem é o papel mais difícil?"
  Deixe a turma responder; a resposta que interessa é **moderador**, e o motivo é que
  ele é o único que não produz achado nenhum.

### 🕐 00:29 – 00:36 · Como se revisa bem (A5) — 7 min

- Slides 24–29.
- Checklists e leitura por perspectiva; os números que a prática consolidou
  (lote < 400 linhas, ritmo < 500 LOC/h, sessão < 60 min); anatomia de um bom comentário;
  os anti-padrões (nitpicking, bikeshedding, LGTM automático).

### 🕐 00:36 – 00:40 · IA em revisão + gancho Fagan (A6) — 4 min

- Slides 30–33.
- O que LLM pega bem, o que não pega; falso positivo e viés de automação;
  "quem revisa o revisor".
- Encerrar a teoria com o slide do espectro de novo, marcando onde a próxima aula entra.

---

### 🕐 00:40 – 00:43 · Setup da atividade (A6 explica, A1/A2 distribuem) — 3 min

- A6 explica em 90 segundos: **mesmo PR, 8 grupos, modos diferentes, quadro no final.**
- **Projete o slide 34 com o QR code do repositório** e deixe-o no ar durante toda a
  atividade. A turma abre o PR direto no notebook — não precisa de conta no GitHub.
- A1 distribui o que é papel: `A0_ENUNCIADO` e `A6_ata` para todos; `A5_checklist`
  só para G3 e G6.
- A2 distribui os **cartões de modo** — um por grupo, **virados para baixo**, para que
  ninguém veja o do vizinho.
- A6 escreve no quadro: **"20:00"** e a estrutura do quadro comparativo.
- 🗣️ **Diga em voz alta as duas regras que protegem o exercício:**
  *"ninguém comenta no GitHub — os achados vão para a ata"* e
  *"nada de linter, análise estática ou IA, exceto quem recebeu o cartão de IA."*

### 🕐 00:43 – 00:45 · Distribuição de papéis dentro dos grupos — 2 min

- A4 circula garantindo que **todo integrante tem um papel escrito na ata**.
- Grupos com 5 integrantes (G1 e G8) já receberam modos que funcionam com 5.

### 🕐 00:45 – 01:05 · Revisão cronometrada — 20 min

- A6 marca o tempo em voz alta em **10 min**, **5 min** e **1 min**.
- Facilitadores circulam pelos seus grupos. **Não entregar defeito.**
- Pontos de atenção por grupo:
  - **G2 (walkthrough):** o autor tende a virar réu. Lembre: perguntas, não acusações.
  - **G4/G7 (IA):** o risco é copiar a saída para a ata sem verificar. Cobre a triagem.
  - **G5 (perspectiva):** vão querer sair da perspectiva. Segure.
  - **G8 (pair):** garanta que os que estão fora da vez **não** estão lendo o código.
  - **G1 (informal):** vão pedir checklist. Negue — é o grupo de controle.

### 🕐 01:05 – 01:10 · Consolidação da ata e dos números — 5 min

- Cada grupo fecha a ata, conta achados e falsos positivos, e um representante
  leva os números ao quadro.
- A5 começa a recolher as atas dos grupos que terminarem.

---

### 🕐 01:10 – 01:18 · Rodada de reporte — 8 min (1 min por grupo)

Cada grupo responde, **em pé, em 60 segundos**, exatamente estas quatro coisas:

1. Qual foi o nosso modo
2. Quantos defeitos e quantos falsos positivos
3. **O defeito mais interessante que achamos**
4. O que sentimos que o nosso método atrapalhou

- A6 preenche a **matriz de cobertura** (`A9_quadro_comparativo.md`) ao vivo.
- ⏱ **Corte impiedosamente em 60s.** É o bloco com maior risco de estourar o tempo.

### 🕐 01:18 – 01:25 · Revelação e análise (A3 + A6) — 7 min

Seguir o roteiro da seção 6 do gabarito, nesta ordem:

1. Projetar o gabarito e somar a coluna **união de todos os grupos**.
2. **"Quem achou o D06?"** — a condição de corrida. Segure o silêncio.
   *Nem a revisão mais rigorosa acha tudo. Revisão não substitui teste.*
3. **"Olhem D01, D02, D03."** Só os grupos que tinham o requisito na mão acharam.
   *Revisão sem artefato de referência não detecta defeito de conformidade.*
4. **Revelar que G3 e G6 tinham o mesmo cartão.** Comparar os conjuntos.
   *Variabilidade entre revisores — é por isso que se revisa em grupo.*
5. **Revelar que G4 e G7 tinham prompts diferentes.** Mostrar a Saída B ao G4.
   *A diferença não estava no modelo. Estava no contexto.*

### 🕐 01:25 – 01:30 · Fecho (A1 e A6) — 5 min

- Slide 34: as três frases que a turma leva.
- Retomar a pergunta da abertura: **"mergeia?"**
- A6: gancho explícito para a próxima aula — *"vocês acabaram de fazer revisão técnica
  em 20 minutos. Inspeção formal de Fagan é o mesmo problema levado a sério: fases
  definidas, critérios de entrada e saída, métricas e retrabalho. Na próxima aula
  vocês vão ver por que uma empresa aceita gastar 6 horas de 4 pessoas em 200 linhas."*
- A5 recolhe as atas restantes e entrega à professora.

---

## Checklist de preparação

### Uma semana antes — repositório

- [ ] Instalar o necessário: `winget install --id Git.Git`, `winget install --id GitHub.cli`,
      depois `gh auth login`
- [ ] Publicar, no PowerShell, dentro de `04_repositorio/`:

      .\publicar2.ps1 -Repo <sua-conta>/siga-matricula

      O script cria o repositório público, empurra as duas branches, abre o PR **e já
      corrige o número do PR em todos os materiais**. É seguro rodar de novo se falhar
      no meio. (Linux/macOS: `./publicar_repositorio.sh`. Detalhes e modo manual em
      `04_repositorio/INSTRUCOES_REPOSITORIO.md`.)
- [ ] ⚠️ Conferir que o **número do PR** foi trocado nos materiais — o PR **não** vai ser
      o #142, o GitHub numera a partir de 1. Se o script não conseguiu identificar o
      número, rode `.\ajustar_numero_do_pr.ps1 -Numero <n> -Repo <conta>/<repo>`.
      **Antes de imprimir qualquer coisa.**
- [ ] Abrir o repositório em **janela anônima**, sem login: repo, PR e aba *Files changed*
- [ ] Rodar a verificação anti-spoiler do `git log` e do `git grep`
- [ ] Gerar o QR code do PR e colar no **slide 34** e no `A0_ENUNCIADO`
- [ ] **Não fazer merge do PR**

### Na véspera — impressões

- [ ] 8 × `A0_ENUNCIADO.md` (já com o link e o QR code)
- [ ] 8 × `A6_ata_de_revisao.md`
- [ ] 1 cartão por grupo, recortado de `A4_cartoes_modos_de_revisao.md`
- [ ] 2 × `A5_checklist.md` (só para G3 e G6)
- [ ] 2 × prompts de `A7_prompts_IA.md` (G4 recebe o PROMPT A, G7 o PROMPT B — **não trocar**)
- [ ] 2 × `A8_saida_IA_planoB.md` — **Saída A para G4, Saída B para G7**, envelopes separados
- [ ] 1 × `A9_quadro_comparativo.md` para o A6
- [ ] **Backup impresso**, 2 ou 3 jogos, da pasta `02_atividade/copia_impressa/`
      (`RF-014.md`, `CONTRIBUTING.md`, `matricula_NUMERADO.txt`, `test_matricula_NUMERADO.txt`)
      — só para o caso de a rede da sala cair

**Digital**

- [ ] Slides testados no projetor da sala
- [ ] Cronômetro grande visível (celular no projetor ou no quadro)

**Ensaio**

- [ ] Cada apresentador cronometrou o próprio bloco **sozinho** e cabe no tempo
- [ ] A squad rodou uma vez a rodada de reporte simulando 8 grupos em 8 minutos
- [ ] A6 sabe preencher a matriz do quadro **sem consultar o gabarito**

---

## Planos de contingência

| Se acontecer | O que fazer |
|---|---|
| **Internet cai** | Duas coisas: entregar `A8_saida_IA_planoB.md` aos grupos de IA (Saída A ao G4, Saída B ao G7) **e** distribuir o backup impresso de `copia_impressa/`. A atividade não muda em nada — só perde o diff colorido. |
| **A rede da sala é lenta / GitHub bloqueado** | Abra o PR no seu notebook, projete, e distribua o backup impresso. Os grupos revisam no papel numerado. |
| **Um grupo começa a comentar no PR** | Peça para apagar. Se já estiver visível, avise a turma em voz alta que aqueles comentários não valem e ninguém deve lê-los. |
| **Alguém rodou um linter mesmo assim** | Não brigue: peça que marquem na ata quais achados vieram da ferramenta. Na comparação, esse grupo vira um dado a mais. |
| **A teoria estourou o tempo** | Cortar o **bloco A5 pela metade** (mantendo só checklist e os números de lote/ritmo). Nunca cortar da atividade — ela é o núcleo avaliado. |
| **A turma tem menos grupos** | Prioridade dos modos: **M3, M4-A, M4-B, M5, M1**, e só então M2 e M6. Os quatro primeiros são os que sustentam a discussão final. |
| **Grupo terminou cedo** | Pergunta: *"seu método deixaria passar que tipo de defeito? Procure exatamente esse tipo nos 5 minutos que sobraram."* |
| **A rodada de reporte atrasa** | Cortar o item 4 do reporte (o que atrapalhou) e ir direto à revelação — os dados do quadro valem mais que os comentários. |
| **Alguém diz "a IA acha tudo"** | Aponte para o item 9 da Saída A (`_adicionar_lista_espera` sem commit) e peça que abra a linha 81 do código. |
