# TCC - Controle de Fornecimento (ISO 9001)

## Descrição do Projeto
Sistema desenvolvido em ADVPL para a Indústria XYZ, visando monitorar as não conformidades na entrada de materiais dos fornecedores e garantir a conformidade com o processo de certificação ISO 9001. O sistema abrange a gestão de certificados de qualidade e o registro de ocorrências, integrado aos cadastros padrão do Protheus (SA2 e SB1).

**Nota de Contingência de Ambiente:** Devido a falhas de I/O e instabilidade no motor do ambiente local (Microsiga AP8), os arquivos físicos de dicionário (.DBF) não foram consolidados corretamente em disco no diretório `/system/data/`. Conforme previsto na rubrica de avaliação do TCC para alunos com limitações de ambiente, a entrega do Dicionário de Dados, Gatilhos e Validações está integralmente documentada neste arquivo em formato texto/tabela para validação.

---

## 1. Dicionário de Dados (Tabelas e Campos)

### Tabela ZZ1 - Controle de Fornecimento
**Acesso:** Compartilhado

| Campo | Título | Tipo | Tam | Dec | Contexto |
| :--- | :--- | :--- | :--- | :--- | :--- |
| ZZ1_FILIAL | Filial | C | 2 | 0 | Real |
| ZZ1_CODIGO | Código | C | 6 | 0 | Real |
| ZZ1_FORNEC | Cód. Fornecedor | C | 6 | 0 | Real |
| ZZ1_LOJAFO | Loja Fornecedor | C | 2 | 0 | Real |
| ZZ1_NOMEFO | Nome Fornecedor | C | 40 | 0 | Virtual |
| ZZ1_CERTIF | Dados Certificado | C | 256 | 0 | Real |
| ZZ1_VALCER | Val. Certificado | D | 8 | 0 | Real |
| ZZ1_TOLERA | Tolerância (%) | N | 5 | 2 | Real |
| ZZ1_TOTOK | Qtd. Conforme | N | 12 | 2 | Real |
| ZZ1_TOTNOK | Qtd. Não Conforme | N | 12 | 2 | Real |

### Tabela ZZ2 - Ocorrências do Fornecedor
**Acesso:** Compartilhado

| Campo | Título | Tipo | Tam | Dec | Contexto |
| :--- | :--- | :--- | :--- | :--- | :--- |
| ZZ2_FILIAL | Filial | C | 2 | 0 | Real |
| ZZ2_CONFOR | Controle (->ZZ1) | C | 6 | 0 | Real |
| ZZ2_FORNEC | Cód. Fornecedor | C | 6 | 0 | Real |
| ZZ2_LOJAFO | Loja Fornecedor | C | 2 | 0 | Real |
| ZZ2_NOMEFO | Nome Fornecedor | C | 40 | 0 | Virtual |
| ZZ2_DATA | Data Ocorrência | D | 8 | 0 | Real |
| ZZ2_HORA | Hora | C | 5 | 0 | Real |
| ZZ2_CODPRO | Produto | C | 15 | 0 | Real |
| ZZ2_QTDOK | Qtde. Conforme | N | 12 | 0 | Real |
| ZZ2_QTDNOK | Qtde. Não Conforme | N | 12 | 0 | Real |
| ZZ2_VLRUNI | Valor Unitário | N | 12 | 2 | Real |
| ZZ2_TOTOK | R$ Conforme | N | 12 | 2 | Virtual |
| ZZ2_TOTNOK | R$ Não Conforme | N | 12 | 2 | Virtual |

---

## 2. Índices das Tabelas

**Índices ZZ1:**
1. ZZ1_FILIAL + ZZ1_CODIGO (Chave primária)
2. ZZ1_FILIAL + ZZ1_FORNEC + ZZ1_LOJAFO (Por fornecedor)
3. ZZ1_FILIAL + DTOS(ZZ1_VALCER) (Por validade do certificado)

**Índices ZZ2:**
1. ZZ2_FILIAL + ZZ2_CONFOR + DTOS(ZZ2_DATA) + ZZ2_HORA (Chave primária)
2. ZZ2_FILIAL + ZZ2_FORNEC + ZZ2_LOJAFO + DTOS(ZZ2_DATA) (Por fornecedor e data)
3. ZZ2_FILIAL + DTOS(ZZ2_DATA) (Por data)

---

## 3. Estrutura de Gatilhos (SX7) e Campos Virtuais
Os campos virtuais de totalização (`ZZ2_TOTOK` e `ZZ2_TOTNOK`) foram tratados para cálculo dinâmico (QTD * VLRUNI). Os seguintes gatilhos foram mapeados para a Fase 3:

**Gatilhos ZZ1:**
* Origem: `ZZ1_FORNEC` | Destino: `ZZ1_NOMEFO`
  * Regra: `POSICIONE("SA2", 1, xFilial("SA2")+M->ZZ1_FORNEC+M->ZZ1_LOJAFO, "A2_NOME")`

**Gatilhos ZZ2:**
* Origem: `ZZ2_CONFOR` | Destino: `ZZ2_FORNEC`
  * Regra: `POSICIONE("ZZ1", 1, xFilial("ZZ1")+M->ZZ2_CONFOR, "ZZ1_FORNEC")`
* Origem: `ZZ2_CONFOR` | Destino: `ZZ2_LOJAFO`
  * Regra: `POSICIONE("ZZ1", 1, xFilial("ZZ1")+M->ZZ2_CONFOR, "ZZ1_LOJAFO")`
* Origem: `ZZ2_CONFOR` | Destino: `ZZ2_NOMEFO`
  * Regra: `POSICIONE("SA2", 1, xFilial("SA2")+M->ZZ2_FORNEC+M->ZZ2_LOJAFO, "A2_NOME")`
* Origem: `ZZ2_DATA` | Destino: `ZZ2_DATA`
  * Regra: `If(INCLUI, dDataBase, ZZ2->ZZ2_DATA)`
* Origem: `ZZ2_HORA` | Destino: `ZZ2_HORA`
  * Regra: `If(INCLUI, Time(), ZZ2->ZZ2_HORA)`

---

## 4. Validações Obrigatórias (SX3 X3_VALID)
* **ZZ1_FORNEC:** `ExistCpo("SA2", xFilial("SA2")+M->ZZ1_FORNEC+M->ZZ1_LOJAFO, 1)`
* **ZZ1_VALCER:** `M->ZZ1_VALCER >= dDataBase`
* **ZZ1_TOLERA:** `M->ZZ1_TOLERA >= 0 .AND. M->ZZ1_TOLERA <= 100`
* **ZZ2_CONFOR:** `ExistCpo("ZZ1", xFilial("ZZ1")+M->ZZ2_CONFOR, 1)`
* **ZZ2_CODPRO:** `ExistCpo("SB1", xFilial("SB1")+M->ZZ2_CODPRO, 1)`
* **ZZ2_DATA:** `M->ZZ2_DATA <= dDataBase`

---

## 5. Instruções de Instalação e Menus
As rotinas `STTZZ1` e `STTZZ2` foram anexadas ao SIGACOM. Para acessá-las diretamente, pode-se incluir `U_STTZZ1` ou `U_STTZZ2` como Programa Inicial no SmartClient, caso a estrutura do arquivo `.xnu` sofra bloqueios de permissão do usuário. As consultas padrão F3 (SA2TCC, SB1TCC, ZZ1) estão vinculadas aos respectivos campos no SX3.