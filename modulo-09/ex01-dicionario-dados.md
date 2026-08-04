# Exercício 1 — Dicionário de Dados do Projeto (SZ1 e SZ2)

> **Nota de Contexto:** Devido à ausência temporária do ambiente SIGACFG para captura de telas, a especificação técnica completa das tabelas `SZ1` (Contatos) e `SZ2` (Interações) está estruturada abaixo.

---

## 1. Dicionário de Tabelas (SX2)

| Tabela  | Descrição               | Modo de Compartilhamento |
| :------ | :---------------------- | :----------------------- |
| **SZ1** | Cadastro de Contatos    | Compartilhado (`C`)      |
| **SZ2** | Histórico de Interações | Compartilhado (`C`)      |

---

## 2. Dicionário de Campos (SX3)

### Tabela SZ1 — Contatos

| Campo        | Tipo | Tamanho | Decimal | Descrição         | Contexto | Propriedades / Regras                                                           |
| :----------- | :--- | :------ | :------ | :---------------- | :------- | :------------------------------------------------------------------------------ |
| `Z1_FILIAL`  | C    | 2       | 0       | Filial            | Real     | Inicializador: `xFilial("SZ1")`                                                 |
| `Z1_CODIGO`  | C    | 6       | 0       | Código do Contato | Real     | Sequencial automático (`U_ProxCodigoSZ1()`)                                     |
| `Z1_CLIENTE` | C    | 6       | 0       | Código do Cliente | Real     | Validação: `ExistCpo("SA1")` / Consulta F3: `SA1`                               |
| `Z1_LOJA`    | C    | 2       | 0       | Loja do Cliente   | Real     | Validação Padrão                                                                |
| `Z1_NOMCLI`  | C    | 40      | 0       | Nome do Cliente   | Virtual  | Relacao: `POSICIONE("SA1",1,xFilial("SA1")+M->Z1_CLIENTE+M->Z1_LOJA,"A1_NOME")` |
| `Z1_NOME`    | C    | 40      | 0       | Nome do Contato   | Real     | Campo Obrigatório                                                               |
| `Z1_CARGO`   | C    | 25      | 0       | Cargo             | Real     | -                                                                               |
| `Z1_EMAIL`   | C    | 50      | 0       | E-mail            | Real     | -                                                                               |
| `Z1_FONE`    | C    | 15      | 0       | Telefone          | Real     | -                                                                               |

### Tabela SZ2 — Interações

| Campo        | Tipo | Tamanho | Decimal | Descrição         | Contexto | Propriedades / Regras                                          |
| :----------- | :--- | :------ | :------ | :---------------- | :------- | :------------------------------------------------------------- |
| `Z2_FILIAL`  | C    | 2       | 0       | Filial            | Real     | Inicializador: `xFilial("SZ2")`                                |
| `Z2_CONTAT`  | C    | 6       | 0       | Código do Contato | Real     | Validação: `ExistCpo("SZ1", xFilial("SZ1") + M->Z2_CONTAT, 1)` |
| `Z2_SEQUEN`  | C    | 4       | 0       | Sequência         | Real     | Sequencial por Contato (`U_ProxSequenSZ2()`)                   |
| `Z2_DATA`    | D    | 8       | 0       | Data Interação    | Real     | Inicializador/Gatilho: `dDataBase`                             |
| `Z2_HORA`    | C    | 8       | 0       | Hora Interação    | Real     | Inicializador/Gatilho: `Time()`                                |
| `Z2_TIPO`    | C    | 1       | 0       | Tipo de Interação | Real     | Tabela Generica SX5 (Chave: `Z2`)                              |
| `Z2_USUAR`   | C    | 15      | 0       | Usuário Sistema   | Real     | Inicializador/Gatilho: `cNomUsr`                               |
| `Z2_ASSUNTO` | C    | 60      | 0       | Assunto           | Real     | -                                                              |

---

## 3. Dicionário de Índices (SIX)

| Tabela  | Ordem | Chave de Indexação                  | Descrição / Uso                         |
| :------ | :---- | :---------------------------------- | :-------------------------------------- |
| **SZ1** | 1     | `Z1_FILIAL + Z1_CODIGO`             | Chave Primária                          |
| **SZ1** | 2     | `Z1_FILIAL + Z1_CLIENTE + Z1_LOJA`  | Busca por Cliente                       |
| **SZ2** | 1     | `Z2_FILIAL + Z2_CONTAT + Z2_SEQUEN` | Chave Primária (Relacionamento com SZ1) |

---

## 4. Tabela Genérica de Domínio (SX5)

- **Tabela:** `Z2` (Tipos de Interação)

| Chave (X5_CHAVE) | Descrição (X5_DESCRIC)      |
| :--------------- | :-------------------------- |
| **E**            | E-mail enviado/recebido     |
| **L**            | Ligação telefônica          |
| **R**            | Reunião presencial / remota |
| **V**            | Visita comercial            |
| **W**            | WhatsApp / Mensagem         |
