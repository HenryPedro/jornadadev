# Exercício 3 — Gatilhos, Campos Virtuais e Validações Cruzadas

> **Nota de Contexto:** Mapeamento conceitual e prático dos mecanismos automatizados da tabela SZ2.

---

### 1. Campos Virtuais no SX3 (SZ2)

- **`Z2_NOMCLI` (Nome do Cliente):**
  - **Fórmula (`X3_RELACAO`):**  
    `POSICIONE("SA1", 1, xFilial("SA1") + POSICIONE("SZ1", 1, xFilial("SZ1") + M->Z2_CONTAT, "Z1_CLIENTE") + POSICIONE("SZ1", 1, xFilial("SZ1") + M->Z2_CONTAT, "Z1_LOJA"), "A1_NOME")`

---

### 2. Gatilhos Automáticos no SX7 (Tabela SZ2)

| Campo Origem | Sequência | Campo Destino | Regra / Expressão ADVPL            | Momento          |
| :----------- | :-------- | :------------ | :--------------------------------- | :--------------- |
| `Z2_CONTAT`  | 001       | `Z2_DATA`     | `dDataBase`                        | Ao Perder o Foco |
| `Z2_CONTAT`  | 002       | `Z2_HORA`     | `IF(INCLUI, Time(), SZ2->Z2_HORA)` | Ao Perder o Foco |
| `Z2_CONTAT`  | 003       | `Z2_USUAR`    | `cNomUsr`                          | Ao Perder o Foco |

---

### 3. Validação Cruzada (X3_VALID)

- **Campo:** `Z2_CONTAT`
- **Regra (`X3_VALID`):**  
  `ExistCpo("SZ1", xFilial("SZ1") + M->Z2_CONTAT, 1)`

- **Efeito Operacional:** Impede a digitação ou gravação de um código de contato inexistente na tabela pai `SZ1`, emitindo alerta nativo do Protheus e mantendo o foco no campo.
