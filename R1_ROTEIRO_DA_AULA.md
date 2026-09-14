# Roteiro da Aula — Revisão de Software: conceitos, tipos e papéis

**Data:** terça-feira, **15/09/2026** · **Duração:** 90 minutos
**Condução:** squad de 5 · **Turma:** 7 grupos · 40 alunos (G1 e G2 com 5 integrantes)
**Divisão macro:** 40 min teoria · 30 min prática · 15 min comparação · 5 min fecho

---

## Divisão de responsabilidades da squad

| Pos. | Nome | Bloco teórico | Slides | Tempo | Papel na atividade | Facilita |
|---|---|---|---|---|---|---|
| **A1** | **Pietro Mendes Prauchner** | Abertura + Por que revisar | 1–9 | 9 min | Distribui enunciado e ata | G1, G2 |
| **A2** | **Lorenzo Ponsi Ficher** | Tipos de revisão | 10–17 | 8 min | Distribui os cartões de modo | **G4, G7** |
| **A3** | **Inaurrara Flores Rozado** | Papéis na revisão | 18–23 | 8 min | Entrega o checklist e confere os papéis | **G3, G6** |
| **A4** | **Andreus Dean Ferreira Almeida Rodrigues Vargas** | Como se revisa bem | 24–29 | 7 min | Recolhe as atas | G5 |
| **A5** | **Bruno da Silva Rocha** | IA em revisão + gancho Fagan | 30–36 | 8 min | **Cronômetro e quadro comparativo** | — |

**Por que cada par controlado tem um único facilitador.** G3/G6 (mesmo checklist) e
G4/G7 (mesma IA, prompts diferentes) são comparados lado a lado na revelação final.
Se cada um for acompanhado por uma pessoa diferente, a diferença de tolerância entre
facilitadores vira variável de confusão. Por isso **A3 cobre G3 e G6**, e **A2 cobre
G4 e G7** — e A2 é justamente quem apresentou os tipos de revisão.

**Por que o A5 não facilita grupo nenhum.** Ele marca o tempo em voz alta e preenche a
matriz de cobertura ao vivo enquanto sete grupos reportam em sete minutos. É a tarefa
mais propensa a falhar sob pressão e a única sem redundância possível.

**Regra da squad durante a atividade:** facilitador **não revisa e não entrega defeito**.
Se um grupo travar, a única intervenção permitida é uma pergunta: *"o cartão de vocês
manda fazer o quê agora?"* ou *"vocês abriram o documento de requisitos?"*.

---

## Linha do tempo

### 🕐 00:00 – 00:09 · Abertura + Por que revisar (A1 · Pietro) — 9 min

**Abertura — slides 1–4 · 4 min**

- **Abrir com o caso, não com a definição.** Projete a descrição do PR #1:
  *"testes passando localmente (2/2 verdes), acho que dá pra fazer merge hoje"*.
  Pergunte à turma: **"mergeia?"** Deixe alguém dizer que sim.
- Anuncie: "esse PR tem 12 defeitos. Vocês vão achá-los daqui a 40 minutos —
  e nenhum grupo vai achar os 12."
- Situar: revisão é **verificação estática**; ninguém executa o código.
  Conecta com a aula de conceitos de V&V que a turma já teve.
- ⚠️ **Não** distribuir os artefatos ainda.

**Por que revisar — slides 5–9 · 5 min**

- Emenda direta no "mergeia?": custo do defeito ao longo do ciclo; eficácia de
  remoção de defeitos; o que revisão pega que teste **não** pega.
- ⏱ Este é o trecho comprimido do plano antigo (era 7 min). A **eficácia de remoção
  de defeitos** é o slide a falar mais rápido — os números importam, a digressão não.
- Fechar com a pergunta retórica: *"o pipeline estava verde. O que o verde prova?"*

### 🕐 00:09 – 00:17 · Tipos de revisão (A2 · Lorenzo) — 8 min

- Slides 10–17.
- O espectro por formalidade, a tabela comparativa, os eixos ortogonais
  (síncrono/assíncrono, com/sem ferramenta, quem conduz).
- ℹ️ **Pair review saiu da atividade** (a turma tem 7 grupos), mas **continua no slide**
  como eixo ortogonal. Diga isso em voz alta: *"esse aqui vocês não vão praticar hoje —
  é o que mais acontece no mercado e é o menos formal de todos."*
- **Slide 17 é o gancho:** inspeção formal aparece como o extremo do espectro e a
  frase é: *"a próxima squad vai passar uma aula inteira só nesse último quadradinho —
  e vocês vão entender por quê."*

### 🕐 00:17 – 00:25 · Papéis (A3 · Inaurrara) — 8 min

- Slides 18–23.
- Os papéis da IEEE 1028, o que cada um faz e **o que cada um não faz**.
- As três regras de ouro (revisa-se o artefato; detectar ≠ corrigir; gerência fora da sala).
- 💡 **Momento de participação:** slide 22 — "quem é o papel mais difícil?"
  Deixe a turma responder; a resposta que interessa é **moderador**, e o motivo é que
  ele é o único que não produz achado nenhum.
- 🔗 Este bloco é a base do cartão M3 (G3 e G6), que a A3 vai facilitar.

### 🕐 00:25 – 00:32 · Como se revisa bem (A4 · Andreus) — 7 min

- Slides 24–29.
- Checklists e leitura por perspectiva; os números que a prática consolidou
  (lote < 400 linhas, ritmo < 500 LOC/h, sessão < 60 min); anatomia de um bom comentário;
  os anti-padrões (nitpicking, bikeshedding, LGTM automático).
- ⚠️ **É este o bloco que se corta pela metade se a teoria estourar** — mantendo só
  checklist e os números de lote/ritmo. O A4 precisa saber disso **antes** de subir.

### 🕐 00:32 – 00:40 · IA em revisão + gancho Fagan (A5 · Bruno) — 8 min

- Slides 30–36, incluindo os três slides novos **33, 34 e 35**.
- O que LLM pega bem, o que não pega; falso positivo e viés de automação.
- **Slide 33 — a alucinação, ao vivo.** Projete o item 9 da Saída A (`_adicionar_lista_espera`
  "sem commit") ao lado da linha 81 do código. A turma vê a IA errar **antes** de ir
  para a atividade — não depois, na forma de reclamação.
- **Slide 34 — momento de participação:** *"a IA pode ser o moderador de uma revisão?"*
  Deixe responderem. A resposta que interessa é **não**: o moderador é o papel que não
  produz achado e **responde pelo processo** — é exatamente o que um modelo não assume.
  Amarra de volta no slide 22 do A3.
- **Slide 35 — quem revisa o revisor.** O custo da revisão assistida é o tempo de triagem.
  Avise que G4 e G7 vão sentir isso na pele em vinte minutos.
- Encerrar a teoria com o slide do espectro de novo, marcando onde a próxima aula entra.

### 🕐 00:40 – 00:43 · Setup da atividade (A5 explica, A1/A2/A3 distribuem) — 3 min

- A5 explica em 90 segundos: **mesmo PR, 7 grupos, modos diferentes, quadro no final.**
- **Projete o slide 37 com o QR code do repositório** e deixe-o no ar durante toda a
  atividade. A turma abre o PR direto no notebook — não precisa de conta no GitHub.
- A1 distribui o `A0_ENUNCIADO` impresso — um por grupo.
- A2 distribui as **etiquetas de QR**, uma por grupo, com o número do grupo impresso nela.
  Cada QR abre o **portal da atividade** já no material daquele grupo:
  cartão de modo, e o checklist (G3, G6) ou o prompt (G4, G7) embutidos na página.
  **Confira o número da etiqueta contra o grupo antes de entregar.**
- A3 acompanha G3 e G6 abrindo a página: os dois ao mesmo tempo, para que
  ninguém comece antes do outro.
- 🔴 **O erro mais caro continua sendo o mesmo, só mudou de suporte:** a etiqueta do G4
  leva ao PROMPT A e a do G7 ao PROMPT B. Trocar inverte o experimento e ninguém percebe
  até o quadro comparativo. Duas pessoas conferem as sete etiquetas antes de sair da sala.
- **A ata é preenchida na própria página** e entregue pelo formulário — ninguém escreve
  ata à mão. Um notebook por grupo preenche; o rascunho fica guardado no navegador dele.
- A5 escreve no quadro: **"20:00"** e a estrutura do quadro comparativo, já com o
  número de grupos que de fato existe hoje (ver contingência de faltas).
- 🗣️ **Diga em voz alta as três regras que protegem o exercício:**
  *"ninguém comenta no GitHub — os achados vão para a ata"*,
  *"nada de linter, análise estática ou IA, exceto quem recebeu o cartão de IA"* e
  *"cada grupo abre só o próprio QR — trocar o número no endereço estraga a comparação
  para os dois grupos"*.

### 🕐 00:43 – 00:45 · Distribuição de papéis dentro dos grupos — 2 min

- A3 circula garantindo que **todo integrante tem um papel escrito na ata** — os papéis
  do modo já vêm preenchidos na página; falta só o nome ao lado de cada um.
- **G1 e G2 são os grupos de 5.** Ambos os modos absorvem isso sem perda: o M1 não tem
  papéis fixos, e o M2 roda com autor + 3 participantes + escriba.
- Se algum grupo travado ficar com 5, o rodapé do próprio cartão diz qual papel acumula.

### 🕐 00:45 – 01:05 · Revisão cronometrada — 20 min

- A5 marca o tempo em voz alta em **10 min**, **5 min** e **1 min**.
- Facilitadores circulam pelos seus grupos. **Não entregar defeito.**
- Pontos de atenção por grupo:
  - **G1 (informal):** vão pedir checklist. Negue — é o grupo de controle.
  - **G2 (walkthrough):** o autor tende a virar réu. Lembre: perguntas, não acusações.
  - **G3/G6 (checklist):** A3 acompanha os dois **com a mesma tolerância**. Não ajude
    um mais que o outro — a comparação entre eles é o dado.
  - **G4/G7 (IA):** o risco é copiar a saída para a ata sem verificar. Cobre a triagem.
    A2 acompanha os dois e **não comenta a diferença entre os prompts**.
  - **G5 (perspectiva):** vão querer sair da perspectiva. Segure.

### 🕐 01:05 – 01:10 · Consolidação da ata e dos números — 5 min

- Cada grupo fecha a ata, conta achados e falsos positivos, e um representante
  leva os números ao quadro.
- A4 começa a recolher as atas dos grupos que terminarem.

---

### 🕐 01:10 – 01:17 · Rodada de reporte — 7 min (1 min por grupo)

Cada grupo responde, **em pé, em 60 segundos**, exatamente estas quatro coisas:

1. Qual foi o nosso modo
2. Quantos defeitos e quantos falsos positivos
3. **O defeito mais interessante que achamos**
4. O que sentimos que o nosso método atrapalhou

- A5 preenche a **matriz de cobertura** (`A9_quadro_comparativo.md`) ao vivo.
- ⏱ **Corte impiedosamente em 60s.** É o bloco com maior risco de estourar o tempo.

### 🕐 01:17 – 01:25 · Revelação e análise (A2 + A5) — 8 min

Seguir o roteiro da seção 6 do gabarito, nesta ordem:

1. Projetar o gabarito e somar a coluna **união de todos os grupos**.
2. **"Quem achou o D06?"** — a condição de corrida. Segure o silêncio.
   *Nem a revisão mais rigorosa acha tudo. Revisão não substitui teste.*
3. **"Olhem D01, D02, D03."** Só os grupos que tinham o requisito na mão acharam.
   *Revisão sem artefato de referência não detecta defeito de conformidade.*
4. **Revelar que G3 e G6 tinham o mesmo cartão.** Comparar os conjuntos.
   *Variabilidade entre revisores — é por isso que se revisa em grupo.*
5. **Revelar que G4 e G7 tinham prompts diferentes.** Mostrar a Saída B ao G4.
   *A diferença não estava no modelo. Estava no contexto.* Retomar o slide 33:
   a IA que alucinou na teoria é a mesma que os dois grupos acabaram de usar.

> ⏱ Este bloco ganhou 1 minuto (eram 7) porque a turma tem 7 grupos em vez de 8.
> Use o minuto extra no passo 2 — o silêncio do D06 é o que faz a aula.

### 🕐 01:25 – 01:30 · Fecho (A1 + A5) — 5 min

- Slide 43: as três frases que a turma leva.
- A1 retoma a pergunta da abertura: **"mergeia?"**
- A5: gancho explícito para a próxima aula — *"vocês acabaram de fazer revisão técnica
  em 20 minutos. Inspeção formal de Fagan é o mesmo problema levado a sério: fases
  definidas, critérios de entrada e saída, métricas e retrabalho. Na próxima aula
  vocês vão ver por que uma empresa aceita gastar 6 horas de 4 pessoas em 200 linhas."*
- A4 recolhe as atas restantes e entrega à professora.

---

## Checklist de preparação

### Repositório — já feito, só conferir

- [x] Repositório publicado: **github.com/PPrauchner/siga-matricula** · **PR #1 aberto**
- [x] Número do PR corrigido em todo o material e no README público (era `#142`;
      o GitHub numera a partir de 1)
- [x] Branch `feature/rf-014-matricula` rebaseada sobre a `main` corrigida — o diff do
      PR continua com **2 arquivos** (`matricula.py` e `test_matricula.py`) e nada mais
- [ ] Abrir o repositório em **janela anônima**, sem login: repo, PR e aba *Files changed*
- [ ] Rodar a verificação anti-spoiler do `git log` e do `git grep`
- [x] QR code gerado e embutido no **slide 37** (deck HTML) e no `A0_ENUNCIADO` (`02_atividade/qr_pr1.png`) —
      `https://github.com/PPrauchner/siga-matricula/pull/1/files`
- [ ] ⚠️ **Não fazer merge do PR**

> Se por algum motivo for preciso republicar do zero, o procedimento
> (`publicar2.ps1`, `ajustar_numero_do_pr.ps1` e o modo manual) está em
> `04_repositorio/INSTRUCOES_REPOSITORIO.md`.

### Na véspera — impressões

> Cartões, checklist, prompts e ata **saíram do papel**: vivem no portal
> `https://pprauchner.github.io/siga-matricula/`. Detalhe e conferência em
> `R2_ORDEM_DE_IMPRESSAO.md`.

- [ ] **7** × `A0_ENUNCIADO.md` (já com o link e o QR code)
- [ ] **1** folha de QRs — gerada em `?painel=squad`, botão *Imprimir a folha de QRs*,
      recortada em **7 etiquetas** com o número do grupo visível em cada uma
- [ ] 1 × `A9_quadro_comparativo.md` para o A5 (Bruno)
- [ ] **Backup impresso** da pasta `02_atividade/copia_impressa/`
      (`RF-014.md`, `CONTRIBUTING.md`, `matricula_NUMERADO.txt`, `test_matricula_NUMERADO.txt`)
      — quantos jogos você quiser, entre 0 e 3. Rede caída agora custa **o artefato e
      o material da atividade**, porque os dois estão na rede.
- [ ] Se optar por não imprimir o backup: **salve os PDFs no notebook** —
      `copia_impressa/`, `A4_cartoes_modos_de_revisao.pdf`, `A5_checklist.pdf` e
      `A7_prompts_IA.pdf`

### Na véspera — teste do portal

- [ ] `?g=4` mostra **PROMPT A** e `?g=7` mostra **PROMPT B**
- [ ] `?g=3` e `?g=6` mostram o checklist; nenhum outro grupo mostra
- [ ] **Enviar a ata** abre o formulário com o grupo já marcado
- [ ] **Gerar a ata em PDF** sai só com a ata
- [ ] A página abre em **janela anônima** e no **celular**
- [ ] Um QR recortado, escaneado com o celular, abre o cartão do grupo certo

**Digital**

- [ ] Slides testados no projetor da sala
- [ ] Cronômetro grande visível (celular no projetor ou no quadro)

**Ensaio**

- [ ] Cada apresentador cronometrou o próprio bloco **sozinho** e cabe no tempo
- [ ] A squad rodou uma vez a rodada de reporte simulando **7 grupos em 7 minutos**
- [ ] **Bruno (A5)** sabe preencher a matriz do quadro **sem consultar o gabarito**
- [ ] **Bruno (A5)** ensaiou os slides novos **33, 34 e 35** — são material inédito,
      e é o apresentador que não pode estourar o tempo
- [ ] **Andreus (A4)** sabe que o bloco dele é o que se corta pela metade se a teoria atrasar
- [ ] **Pietro (A1)** cronometrou a emenda abertura → por que revisar (são 9 min corridos,
      não dois blocos separados)

---

## Planos de contingência

| Se acontecer | O que fazer |
|---|---|
| **Internet cai** | Agora cai o portal junto. Projete `A4_cartoes_modos_de_revisao.pdf` só **na página do modo de cada grupo** (ou passe o notebook de mesa em mesa), entregue `A5_checklist.pdf` a G3/G6 e `A8_saida_IA_planoB.md` aos grupos de IA (**Saída A ao G4, Saída B ao G7**), e distribua o backup de `copia_impressa/`. **A ata volta a ser manuscrita:** papel pautado serve, com os campos do `A6_ata_de_revisao.md` ditados em voz alta pelo A5. |
| **A rede da sala é lenta / GitHub bloqueado** | Abra o PR no seu notebook, projete, e distribua o backup impresso. Os grupos revisam no papel numerado. |
| **Um grupo começa a comentar no PR** | Peça para apagar. Se já estiver visível, avise a turma em voz alta que aqueles comentários não valem e ninguém deve lê-los. |
| **Alguém rodou um linter mesmo assim** | Não brigue: peça que marquem na ata quais achados vieram da ferramenta. Na comparação, esse grupo vira um dado a mais. |
| **A teoria estourou o tempo** | Cortar o **bloco do A4 (Andreus) pela metade** (mantendo só checklist e os números de lote/ritmo). Nunca cortar da atividade — ela é o núcleo avaliado. |
| **Faltaram alunos** | Ver a seção **Plano de faltas** logo abaixo. Regra curta: as faltas são absorvidas por **G1 e G2**; G3, G4, G6 e G7 têm tamanho travado em 6. |
| **Um grupo pareado ficou com 5** | Encolha **o par inteiro**: G3 com 5 obriga G6 com 5. Tire alguém do outro e mande para o G1. Simetria vale mais que tamanho — o rodapé de cada cartão diz qual papel acumula. |
| **Grupo terminou cedo** | Pergunta: *"seu método deixaria passar que tipo de defeito? Procure exatamente esse tipo nos 5 minutos que sobraram."* |
| **A rodada de reporte atrasa** | Cortar o item 4 do reporte (o que atrapalhou) e ir direto à revelação — os dados do quadro valem mais que os comentários. |
| **Alguém diz "a IA acha tudo"** | Já foi respondido no slide 33. Volte nele: item 9 da Saída A (`_adicionar_lista_espera` sem commit) contra a linha 81 do código. |

---

## Plano de faltas

O plano nominal é **40 alunos em 7 grupos**. Faltas são certas; o que não pode variar é
o tamanho dos **pares controlados**. G3/G6 (mesmo checklist) e G4/G7 (mesma IA, prompts
diferentes) são comparados lado a lado na revelação — se um encolher, a turma vai
concluir, com razão, que a diferença veio de ter um revisor a menos, e não do método.

### Regra de formação, executada na porta (A1 e A3, antes de distribuir cartão)

Monte os grupos **nesta ordem**, travando 6 em cada, e só depois distribua o que sobrar:

1. **G3 e G6** — 6 cada (12)
2. **G4 e G7** — 6 cada (24)
3. **G5** — 6 (30)
4. **G1 e G2** — dividem os restantes, o mais equilibrado possível

### Tabela de degradação

| Presentes | G3 G6 G4 G7 | G5 | G1 | G2 | O que muda na aula |
|---|---|---|---|---|---|
| **40** | 6 6 6 6 | 6 | 5 | 5 | nada — plano nominal |
| 38–39 | 6 6 6 6 | 6 | 4–5 | 4 | nada |
| 36–37 | 6 6 6 6 | 6 | 3–4 | 3 | nada; walkthrough no piso |
| 33–35 | 6 6 6 6 | 6 | 3–5 | **cortado** | 6 grupos; reporte cai para 6 min |
| 31–32 | 6 6 6 6 | 5 | **cortado** | **cortado** | 5 grupos; M5 perde a perspectiva de Mantenedor |
| ≤30 | 6 6 6 6 | **cortado** | — | — | 4 grupos; as duas revelações pareadas sobrevivem |

**Piso do walkthrough: 3** (autor + 1 participante + escriba). Abaixo disso o modo não
existe — corte o grupo em vez de rodá-lo capenga.

**Ordem de corte dos modos** (a mesma prioridade do plano original, agora sem o M6):
corta-se **M2** primeiro, depois **M1**, depois **M5**. M3 e M4 nunca são cortados —
são os dois pares que sustentam a discussão final.

### Fusão de papéis, se um grupo rodar com 5

Já está impressa no rodapé de cada cartão:

| Modo | O que acumula | Por quê |
|---|---|---|
| **M2** walkthrough | tira dos **Participantes** | Autor e Escriba são o modo; participante é plateia |
| **M3** checklist | **Leitor** acumula o Revisor C | Moderador e Escriba nunca acumulam — são os papéis que a aula mostra como não-produtores de achado |
| **M4-A / M4-B** IA | 3 Triadores viram **2** | Operador, Caçador de omissões e Escriba permanecem; o Caçador sustenta "o que a IA **não** disse" |
| **M5** perspectiva | **Mantenedor** acumula Escriba/Moderador | É a lente com menos achado exclusivo; Cliente/Requisito e Operação carregam D01–D03 e D06 |

### Consequências operacionais

- **Imprima para 7 grupos**, sempre. Material sobrando não custa nada.
- **O A5 (Bruno) só desenha as linhas do quadro comparativo depois da chamada** — o
  número de colunas depende de quantos grupos existirem de fato.
- **A rodada de reporte é 1 min por grupo**, então ela encolhe sozinha com o número de
  grupos. O minuto que sobrar vai para a revelação, não para o reporte.
