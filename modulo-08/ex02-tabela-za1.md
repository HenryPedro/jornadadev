# Exercício 2 — Estrutura e Dicionário da Tabela ZA1 (Pets)

> **Nota de Contexto:** Como o ambiente SIGACFG não está disponível no momento para geração de prints, a estrutura completa do Dicionário de Dados (SX2, SX3 e SIX) está mapeada e documentada abaixo[cite: 1].

---

## 1. Dicionário de Tabelas (SX2)

- **Chave:** `ZA1`
- **Descrição:** Pets
- **Modo de Compartilhamento:** Compartilhado (`C`) ou Exclusivo (`E`)

---

## 2. Dicionário de Campos (SX3)

| Campo        | Tipo | Tamanho | Decimal | Descrição         | Contexto | Propriedades / X3_RELACAO / X3_VALID                                                            |
| :----------- | :--- | :------ | :------ | :---------------- | :------- | :---------------------------------------------------------------------------------------------- |
| `ZA1_FILIAL` | C    | 2       | 0       | Filial do Sistema | Real     | Inicializador Padrão: `xFilial("ZA1")`[cite: 1]                                                 |
| `ZA1_COD`    | C    | 6       | 0       | Código do Pet     | Real     | Chave Primária Sequencial (`GetSXENum`)[cite: 1]                                                |
| `ZA1_NOME`   | C    | 50      | 0       | Nome do Pet       | Real     | Obrigatório[cite: 1]                                                                            |
| `ZA1_CLIENT` | C    | 6       | 0       | Código do Cliente | Real     | Consultas F3 (`SA1`) / Valid: `ExistCpo("SA1")`[cite: 1]                                        |
| `ZA1_LOJA`   | C    | 2       | 0       | Loja do Cliente   | Real     | Validação Padrão de Loja[cite: 1]                                                               |
| `ZA1_NOMCLI` | C    | 40      | 0       | Nome do Cliente   | Virtual  | `X3_RELACAO` = `POSICIONE("SA1",1,xFilial("SA1")+M->ZA1_CLIENT+M->ZA1_LOJA,"A1_NOME")`[cite: 1] |
| `ZA1_RACA`   | C    | 30      | 0       | Raça do Pet       | Real     | -[cite: 1]                                                                                      |
| `ZA1_DTNASC` | D    | 8       | 0       | Data Nascimento   | Real     | Campo do tipo Date[cite: 1]                                                                     |

---

## 3. Dicionário de Índices (SIX)

- **Ordem 1:** `ZA1_FILIAL + ZA1_COD` _(Chave Primária)_[cite: 1]
- **Ordem 2:** `ZA1_FILIAL + ZA1_CLIENT + ZA1_LOJA` _(Busca por Dono/Cliente)_[cite: 1]
