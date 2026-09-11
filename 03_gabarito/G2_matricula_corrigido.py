"""
SIGA - Modulo matricula  |  VERSAO CORRIGIDA (gabarito)

Resolucao esperada do PR #142 apos a revisao. Cada correcao esta marcada
com o ID do defeito correspondente no gabarito (G1_GABARITO.md).

Observacao para a squad: NAO e obrigatorio que os alunos cheguem a este
codigo. A entrega deles e a ATA (deteccao), nao a correcao. Este arquivo
serve para fechar a discussao mostrando como cada defeito se resolve.
"""

import logging
from dataclasses import dataclass
from enum import Enum

logging.basicConfig(filename="matricula.log", level=logging.INFO)

# [D01] valor conforme RF-014 v1.2 (28, nao 24)
# [D11] fonte unica da verdade: a constante nao e mais duplicada
LIMITE_CREDITOS_SEMESTRE = 28

SITUACOES_BLOQUEADAS = ("TRANCADO", "INADIMPLENTE")  # [D03]


# [D12] contrato de retorno unico e explicito
class StatusMatricula(Enum):
    EFETIVADA = "EFETIVADA"
    LISTA_DE_ESPERA = "LISTA_DE_ESPERA"
    RECUSADA = "RECUSADA"


@dataclass(frozen=True)
class ResultadoMatricula:
    status: StatusMatricula
    motivo: str = ""

    @property
    def efetivada(self):
        return self.status is StatusMatricula.EFETIVADA


class MatriculaService:
    def __init__(self, conexao):
        self.conexao = conexao

    def matricular(self, aluno, turma):
        resultado = self._avaliar(aluno, turma)
        # [D08-bonus / RN-06] log de TODA tentativa, com ou sem sucesso
        self._registrar_log(aluno, turma, resultado.status.value)
        return resultado

    def _avaliar(self, aluno, turma):
        if aluno.situacao in SITUACOES_BLOQUEADAS:  # [D03]
            return ResultadoMatricula(
                StatusMatricula.RECUSADA, f"situacao do aluno: {aluno.situacao}"
            )

        if not self._prerequisitos_aprovados(aluno, turma.disciplina):
            return ResultadoMatricula(
                StatusMatricula.RECUSADA, "pre-requisito nao aprovado"
            )

        creditos = self._creditos_no_semestre(aluno) + turma.disciplina.creditos
        if creditos > LIMITE_CREDITOS_SEMESTRE:  # [D01][D11]
            return ResultadoMatricula(
                StatusMatricula.RECUSADA, "limite de creditos excedido"
            )

        if self._ha_choque_de_horario(aluno, turma):  # [D02]
            return ResultadoMatricula(
                StatusMatricula.RECUSADA, "choque de horario"
            )

        return self._ocupar_vaga_ou_enfileirar(aluno, turma)

    # -----------------------------------------------------------------
    # [D05] fronteira correta: turma cheia quando ocupadas == total
    # [D06] check-then-act eliminado: a decisao de vaga e feita pelo banco,
    #       em uma unica transacao com bloqueio da linha da turma.
    # -----------------------------------------------------------------
    def _ocupar_vaga_ou_enfileirar(self, aluno, turma):
        cursor = self.conexao.cursor()
        try:
            cursor.execute("BEGIN IMMEDIATE")
            cursor.execute(
                "UPDATE turma SET vagas_ocupadas = vagas_ocupadas + 1 "
                "WHERE id = ? AND vagas_ocupadas < vagas_total",
                (turma.id,),
            )
            if cursor.rowcount == 1:
                cursor.execute(
                    "INSERT INTO matricula (aluno_id, turma_id) VALUES (?, ?)",
                    (aluno.id, turma.id),
                )
                self.conexao.commit()
                return ResultadoMatricula(StatusMatricula.EFETIVADA)

            cursor.execute(
                "INSERT INTO lista_espera (aluno_id, turma_id) VALUES (?, ?)",
                (aluno.id, turma.id),
            )
            self.conexao.commit()
            return ResultadoMatricula(
                StatusMatricula.LISTA_DE_ESPERA, "turma sem vaga"
            )
        except Exception:
            self.conexao.rollback()
            raise  # [D12] falha nao e mais silenciada

    # [D04] exige situacao APROVADO  |  [D07] consulta parametrizada
    def _prerequisitos_aprovados(self, aluno, disciplina):
        cursor = self.conexao.cursor()
        for codigo in disciplina.prerequisitos:
            cursor.execute(
                "SELECT 1 FROM historico "
                "WHERE aluno_id = ? AND codigo = ? AND situacao = 'APROVADO'",
                (aluno.id, codigo),
            )
            if cursor.fetchone() is None:
                return False
        return True

    def _creditos_no_semestre(self, aluno):
        return sum(m.disciplina.creditos for m in aluno.matriculas_ativas)

    # [D02] RN-05 implementada
    def _ha_choque_de_horario(self, aluno, turma_nova):
        for matricula in aluno.matriculas_ativas:
            atual = matricula.turma
            if atual.dia_semana != turma_nova.dia_semana:
                continue
            if (atual.hora_inicio < turma_nova.hora_fim
                    and turma_nova.hora_inicio < atual.hora_fim):
                return True
        return False

    # [D08] sem CPF, sem token  |  [RN-06] toda tentativa
    def _registrar_log(self, aluno, turma, resultado):
        logging.info(
            "matricula aluno_id=%s turma_id=%s resultado=%s",
            aluno.id, turma.id, resultado,
        )

    # [B-04] so decrementa se algo foi realmente removido
    def cancelar_matricula(self, aluno, turma):
        cursor = self.conexao.cursor()
        cursor.execute(
            "DELETE FROM matricula WHERE aluno_id = ? AND turma_id = ?",
            (aluno.id, turma.id),
        )
        if cursor.rowcount == 0:
            self.conexao.rollback()
            return False
        cursor.execute(
            "UPDATE turma SET vagas_ocupadas = vagas_ocupadas - 1 "
            "WHERE id = ? AND vagas_ocupadas > 0",
            (turma.id,),
        )
        self.conexao.commit()
        return True
