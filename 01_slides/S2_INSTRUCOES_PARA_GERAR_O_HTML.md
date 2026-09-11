# Instruções para gerar o deck HTML depois

> Cole este arquivo junto com `S1_CONTEUDO_DOS_SLIDES.md` no Claude Code (ou em qualquer
> assistente) para gerar o deck. O prompt pronto está no final.

## Requisitos do deck

**Estrutura**

- 40 slides, na ordem do `S1`
- Arquivo **único e autocontido**: HTML + CSS + JS inline, sem CDN e sem assets externos
  (o projetor da sala pode não ter internet)
- Navegação: `←` `→`, `Espaço`, clique, e swipe no celular
- Contador de slide no rodapé (`12 / 40`)

**Modo apresentador (importante)**

- Tecla `N` alterna a exibição das **notas do apresentador** (os blocos `> 🎤`)
- Tecla `T` liga/desliga um **cronômetro** da aula, com marcações visuais nos minutos
  **40** (fim da teoria), **70** (fim da revisão) e **85** (início do fecho)
- Tecla `G` abre uma **grade** com todos os slides, para pular direto (útil se o tempo apertar)

**Visual**

- Uma ideia por slide; texto grande (mínimo 24px no corpo, 40px+ nos títulos)
- Fundo claro, alto contraste — sala de aula tem luz acesa
- Paleta sóbria de 3 cores + vermelho/laranja/amarelo apenas para as severidades
  🔴 Alta · 🟠 Média · 🟡 Baixa
- Os **slides-âncora** (11, 17, 33, 36) devem ter um tratamento visual distinto —
  a turma volta a eles
- Blocos ```ascii``` (espectro, curva de custo, árvore de V&V) devem virar **SVG inline**
  ou HTML estilizado, não texto em `<pre>` — ficam ilegíveis no projetor
- Tabelas: cabeçalho fixo, zebra, e nunca mais de 7 linhas por slide (quebre em dois)

**O slide 34 é especial — o QR code do PR**

- É o slide que fica projetado durante os 30 min de atividade, então precisa ser legível
  do fundo da sala e funcionar como cartaz, não como slide de leitura
- O QR code precisa ocupar **pelo menos 40% da altura do slide**
- Aponte para a aba *Files changed*: `https://github.com/<org>/<repo>/pull/<n>/files`
- Escreva a URL por extenso embaixo do QR, em fonte grande, para quem for digitar
- Gere o QR **embutido como data URI** (PNG ou SVG inline). Nada de `<img src="https://...">`
  de gerador online: se a rede da sala cair, some justamente o slide que a turma precisa
- Só dá para gerar isso **depois** de publicar o repositório e saber a URL real do PR

**Não fazer**

- Sem animação de entrada por item (atrasa a aula)
- Sem tema escuro como padrão
- Sem `localStorage` — o deck é stateless
- Sem nenhuma dependência de rede em tempo de apresentação

---

## Prompt pronto

```
Gere um deck de apresentação em HTML, arquivo único e autocontido (CSS e JS inline,
sem nenhuma dependência externa), a partir do conteúdo em anexo.

Conteúdo: <cole S1_CONTEUDO_DOS_SLIDES.md>
Requisitos: <cole a seção "Requisitos do deck" acima>

Regras:
- Cada bloco "## Slide N" vira um slide. O texto após "> 🎤" são notas do apresentador:
  não aparecem na tela, só no modo apresentador (tecla N).
- Converta os diagramas em bloco de código ASCII (slides 4, 6, 11, 33) para SVG inline
  ou HTML estilizado — precisam ser legíveis a 5 metros de distância.
- Preserve todas as tabelas, mas quebre em dois slides qualquer tabela com mais de
  7 linhas de dados, repetindo o título com "(cont.)".
- Não invente conteúdo, não resuma e não corte nada do texto dos slides.
- No slide 34, onde está o marcador "🔲 QR CODE GRANDE AQUI", gere o QR code da URL
  <URL DA ABA "FILES CHANGED" DO PR> embutido como data URI (nada de imagem externa),
  ocupando pelo menos 40% da altura do slide, com a URL escrita por extenso embaixo.
```

> Substitua `<URL DA ABA "FILES CHANGED" DO PR>` pela URL real antes de rodar o prompt.
> Se ainda não publicou o repositório, veja `04_repositorio/INSTRUCOES_REPOSITORIO.md`.

## Depois de gerar — checklist de teste

- [ ] Abrir no **navegador do notebook que vai para a sala**, em tela cheia (F11)
- [ ] Testar no **projetor real**, com a luz da sala acesa
- [ ] Verificar que os slides 4, 6, 11 e 33 estão legíveis do fundo da sala
- [ ] Testar a tecla `N` (notas) e confirmar que as notas **não** aparecem na projeção
- [ ] Salvar também um **PDF de backup** (imprimir → salvar como PDF) para o caso de o
      navegador falhar
