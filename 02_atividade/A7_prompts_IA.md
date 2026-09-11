# Prompts para os grupos de Revisão Assistida por IA

> **Grupo 4 usa o PROMPT A. Grupo 7 usa o PROMPT B.**
> Nenhum dos dois grupos sabe que o outro recebeu um prompt diferente — a revelação
> acontece na rodada de comparação.
>
> Use qualquer assistente disponível (Claude, ChatGPT, Gemini, Copilot Chat).
> **Cole o prompt exatamente como está**, sem melhorar.

---

# PROMPT A — genérico
### (Grupo 4)

```
Revise este código Python e aponte os problemas.

<cole aqui o conteúdo completo de matricula.py, da branch do PR #1>
```

**É só isso.** Não adicione contexto, não anexe o requisito, não peça formato.
Este é o prompt que 90% das pessoas realmente escrevem.

---

# PROMPT B — estruturado
### (Grupo 7)

```
# Papel
Você é revisor de código sênior de uma equipe que segue a norma IEEE 1028.
Sua tarefa é DETECTAR defeitos, não corrigi-los.

# Contexto do sistema
Sistema acadêmico universitário, módulo de matrícula. Vai para produção no
período de matrícula, com alta concorrência de acessos simultâneos.

# Especificação que o código deve cumprir (fonte da verdade)
<cole aqui o conteúdo completo de docs/RF-014.md>

# Artefatos sob revisão
## Arquivo 1 — matricula.py
<cole aqui matricula.py>

## Arquivo 2 — test_matricula.py
<cole aqui test_matricula.py>

# Checklist a aplicar
<cole aqui o checklist recebido em papel>

# Instruções
1. Percorra o checklist seção por seção. Para CADA regra de negócio
   (RN-01 a RN-08), diga explicitamente: implementada corretamente,
   implementada parcialmente, ou ausente — e cite o trecho de código.
2. Verifique se cada critério de aceitação passaria neste código.
3. Avalie se os testes provam comportamento ou apenas execução.
4. Classifique cada defeito em severidade Alta / Média / Baixa e em tipo
   REQ / LOG / SEG / TST / MAN.
5. Ao final, liste separadamente: (a) o que você NÃO conseguiu verificar
   com o material fornecido, e (b) achados sobre os quais você tem baixa
   confiança.

# Formato de saída
Uma tabela: | ID | Arquivo/trecho | Tipo | Severidade | Descrição do defeito |
Seguida das seções (a) e (b).

# Restrição
Não invente linhas ou funções que não estão no código. Se não tiver certeza
de que algo é defeito, diga que não tem certeza em vez de afirmar.
```

---

## Perguntas de fechamento para os dois grupos (usar na comparação)

1. Quantos achados da IA vocês **descartaram** depois de olhar o código?
2. A IA afirmou algo que simplesmente **não existe** no código? Qual?
3. Quantas regras de negócio (RN-01 a RN-08) a IA conseguiu avaliar?
   O grupo 4 conseguiu avaliar alguma? **Por quê não?**
4. Quanto tempo o grupo gastou **verificando** a IA? Esse tempo compensou?
5. Se vocês tivessem aceitado a saída da IA sem triagem, quantos defeitos
   falsos entrariam na ata — e quantos reais ficariam de fora?
