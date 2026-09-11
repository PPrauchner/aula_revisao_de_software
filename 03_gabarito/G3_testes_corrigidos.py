"""
Testes derivados dos CRITERIOS DE ACEITACAO do RF-014 - nao do codigo.
Resolve [D09] (testes que nao verificam comportamento e teste que congelava
o limite errado) e [D10] (regras de negocio sem cobertura).

Regra de ouro demonstrada aqui: um teste por criterio de aceitacao, cada um
verificando o STATUS retornado - nunca "is not None".
"""

from G2_matricula_corrigido import (
    MatriculaService, StatusMatricula, LIMITE_CREDITOS_SEMESTRE,
)


# --- Criterio 1: pre-requisito reprovado recusa a matricula ---------------
def test_prerequisito_reprovado_recusa():
    ...
    # historico contem ES101 com situacao REPROVADO
    # esperado: resultado.status is StatusMatricula.RECUSADA


# --- Criterio 2: 25 + 4 creditos ultrapassa 28 e recusa -------------------
def test_acima_do_limite_de_creditos_recusa():
    ...
    # aluno com 25 creditos, disciplina de 4  -> 29 > 28
    # esperado: RECUSADA, motivo "limite de creditos excedido"


# --- Criterio 3: 24 + 4 creditos cabe em 28 e EFETIVA --------------------
def test_dentro_do_limite_de_creditos_efetiva():
    ...
    # aluno com 24 creditos, disciplina de 4 -> 28 <= 28
    # esperado: EFETIVADA
    # ESTE e o teste que o PR #142 nao tinha e que teria pego o D01.
    assert LIMITE_CREDITOS_SEMESTRE == 28  # trava contra regressao da constante


# --- Criterio 4: turma cheia envia para lista de espera ------------------
def test_turma_cheia_vai_para_lista_de_espera():
    ...
    # vagas_total = 40, vagas_ocupadas = 40
    # esperado: LISTA_DE_ESPERA (e NAO um valor indistinguivel de sucesso)


# --- Criterio 5: aluno inadimplente e recusado --------------------------
def test_aluno_inadimplente_recusa():
    ...
    # situacao = "INADIMPLENTE"
    # esperado: RECUSADA


# --- Criterio 6: choque de horario recusa -------------------------------
def test_choque_de_horario_recusa():
    ...
    # matriculado SEG 14:00-16:00, tentando SEG 15:00-17:00
    # esperado: RECUSADA, motivo "choque de horario"


# --- RN-06: toda tentativa gera log, inclusive recusa -------------------
def test_recusa_tambem_gera_log():
    ...
    # esperado: uma entrada de log com resultado=RECUSADA
    # e NENHUM cpf ou token na linha registrada  [D08]


# --- D06: capacidade respeitada sob concorrencia ------------------------
def test_concorrencia_nao_estoura_a_vaga():
    ...
    # 2 threads matriculando na ultima vaga simultaneamente
    # esperado: exatamente 1 EFETIVADA e 1 LISTA_DE_ESPERA
    # NOTA: este e o unico defeito que exige teste de concorrencia -
    # nenhuma revisao estatica garante peg -lo. Revisao e teste sao
    # complementares, nao substitutos.
