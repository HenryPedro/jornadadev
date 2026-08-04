# Exercício 4 — Campo customizado na SA1 (A1_XAPELID)

## Passos

1. **Abrir o Configurador (SIGACFG)** no ambiente de desenvolvimento.
2. **Acessar o dicionário de campos** — *Dicionário de Dados → Campos (SX3)*.
3. **Incluir um novo campo** associado à tabela **SA1**:
   - Nome: **A1_XAPELID** (prefixo **X** = campo customizado adicionado em tabela padrão de fábrica)
   - Tipo: **C (caractere)** — armazena texto
   - Tamanho: **30** (espaço suficiente para um apelido, respeitando o bom senso do campo)
   - Título: **"Apelido"** — título curto, respeitando o limite de caracteres exibido no Browse
4. **Salvar** o campo — ele passa a constar no SX3.
5. **Forçar o reconhecimento** pela rotina de fórmulas, se necessário, para o framework enxergar o campo novo.
6. **Voltar ao SmartClient** — reabrir o cadastro de clientes (SA1): o campo **A1_XAPELID** deve aparecer na tela **sem escrever nenhuma linha de código**. Isso acontece porque o framework monta o formulário/Browse automaticamente a partir da estrutura do dicionário.
