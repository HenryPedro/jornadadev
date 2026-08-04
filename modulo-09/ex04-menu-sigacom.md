# Exercício 4 — Configuração do Menu no SIGACOM

---

### Passo a Passo no Configurador (SIGACFG)

1. Acesse **SIGACFG → Ambiente → Cadastros → Menus**.
2. Selecione o menu do módulo de Compras (`SIGACOM.XNU`).
3. Navegue até a pasta **Atualizações → Cadastros**.
4. Adicione os novos itens de menu:

#### Item 1: Contatos

- **Título:** Contatos
- **Programa / Executável:** `U_STTIP003`
- **Status:** Habilitado
- **Tipo:** Submenu / Função de Usuário

#### Item 2: Interações (todas)

- **Título:** Interações (Geral)
- **Programa / Executável:** `U_STTIP004B`
- **Status:** Habilitado
- **Tipo:** Submenu / Função de Usuário

5. Salve as alterações e gere o novo arquivo `.xnu`.
