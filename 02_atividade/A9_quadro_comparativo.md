# Quadro Comparativo — projetar / desenhar no quadro branco

> O **A5 (Bruno)** preenche ao vivo enquanto cada grupo reporta (1 min por grupo).
> São **7 grupos** — desenhe as linhas só depois da chamada, porque faltas podem
> reduzir o número de grupos (ver a tabela de degradação no roteiro).
> Este quadro **é** a aula: é aqui que "tipos de revisão" deixa de ser lista de
> definições e vira evidência.

## Parte 1 — Números por grupo

| Grupo | Modo | Defeitos reais | Falsos positivos | Críticos (de 5) | Achado exclusivo |
|---|---|---|---|---|---|
| G1 | Informal (ad hoc) | | | | |
| G2 | Walkthrough | | | | |
| G3 | Revisão técnica c/ checklist | | | | |
| G4 | IA — prompt genérico | | | | |
| G5 | Leitura por perspectiva | | | | |
| G6 | Revisão técnica c/ checklist | | | | |
| G7 | IA — prompt estruturado | | | | |
| — | **UNIÃO de todos os grupos** | | | | |

## Parte 2 — Matriz de cobertura (marcar ✓ quem achou cada defeito)

| Defeito | Categoria | G1 | G2 | G3 | G4 | G5 | G6 | G7 |
|---|---|---|---|---|---|---|---|---|
| D01 — limite 24 ≠ 28 | REQ | | | | | | | |
| D02 — choque de horário ausente | REQ | | | | | | | |
| D03 — INADIMPLENTE ignorado | REQ | | | | | | | |
| D04 — pré-requisito sem aprovação | LOG | | | | | | | |
| D05 — `<=` na vaga | LOG | | | | | | | |
| D06 — condição de corrida | LOG | | | | | | | |
| D07 — SQL injection | SEG | | | | | | | |
| D08 — CPF/token em log | SEG | | | | | | | |
| D09 — teste que não testa | TST | | | | | | | |
| D10 — regras sem teste | TST | | | | | | | |
| D11 — constante duplicada | MAN | | | | | | | |
| D12 — contrato inconsistente | MAN | | | | | | | |

## Parte 3 — As quatro perguntas de fechamento

Escrever no quadro e responder **com os dados da matriz acima**:

1. **Nenhum grupo achou os 12.** Quantos a união de todos achou?
   *→ Por que revisão é atividade coletiva, e por que um único revisor é insuficiente.*

2. **Olhe as linhas D01, D02, D03.** Quais modos as pegaram?
   *→ Só quem leu o requisito. Revisão sem o artefato de referência não detecta
   defeito de conformidade — e é o tipo mais caro de defeito.*

3. **Compare G3 com G6** (mesmo checklist, mesmo tempo, times diferentes).
   *→ Quanta variação? Isso é a variabilidade humana que o processo formal tenta reduzir
   — e não elimina.*

4. **Compare G4 com G7** (mesma IA, prompts diferentes).
   *→ A diferença não está no modelo. Está no contexto que foi dado a ele. Dar contexto
   é trabalho de engenharia — e é exatamente o mesmo trabalho que faz um humano revisar bem.*
