# Exercício 5 — A1_FILIAL e xFilial()

## a. Por que existe o campo A1_FILIAL na SA1 (e em toda tabela do Protheus)?

O Protheus utiliza uma arquitetura **multi-empresa e multi-filial** baseada na consolidação física de dados em um mesmo banco de dados relacional. O campo `A1_FILIAL` atua como a chave técnica de segregação de registros, permitindo que múltiplos estabelecimentos armazenem suas informações na mesma tabela física sem misturar ou vazar dados entre unidades de negócio.

Além do isolamento lógico, o `A1_FILIAL` compõe obrigatoriamente o início da **Ordem 1 (Chave Primária/Índice 1)** de praticamente todas as tabelas (no caso da `SA1`: `A1_FILIAL + A1_COD + A1_LOJA`). Essa modelagem garante que as operações de busca (`DbSeek`), filtros de contexto e consultas de banco de dados (`WHERE`) restrinjam o escopo das rotinas estritamente à filial ativa da sessão.

## b. O que a função xFilial() tem a ver com isso?

A função `xFilial("ALIAS")` é o mecanismo nativo do framework ADVPL responsável por resolver dinamicamente qual o código de filial correto deve ser atribuído ou consultado para uma tabela específica. Ela não retorna simplesmente a filial logada, mas sim a combinação da filial atual (`cFilial`) com o **Modo de Compartilhamento** da tabela definido no Dicionário de Dados (tabela `SX2`, campos `X2_MODO` / `X2_MODOEMP`).

* **Tabela Exclusiva (Modo 'E'):** A informação pertence apenas à filial corrente. `xFilial("SA1")` retorna o código da filial logada (ex.: `"0101"`).
* **Tabela Compartilhada (Modo 'C'):** A informação é visível por todas as filiais. `xFilial("SA1")` retorna uma string vazia (`""`).

### Impactos técnicos de atritar/fixar a filial manualmente (Hardcode)

1. **Inconsistência com o Dicionário SX2 e Registros "Invisíveis":** Se a tabela `SA1` for compartilhada (`'C'`), o Protheus espera gravar e buscar registros com a filial em branco (`""`). Se o programa gravar manualmente `A1_FILIAL := cFilial` (ex.: `"01"`), o registro será persistido com `"01"`. Contudo, quando qualquer rotina padrão tentar buscar o cliente usando `DbSeek(xFilial("SA1") + cCodigo)`, ela procurará por `"" + cCodigo` e **não encontrará o registro**, tornando o dado "invisível" no sistema.
2. **Perda de Flexibilidade Arquitetural:** Caso o cliente decida alterar o compartilhamento de uma tabela no Configurador (`SIGACFG`) de Exclusivo para Compartilhado (ou vice-versa), qualquer código com filial fixada manualmente quebrará a lógica de negócios e causará erros de chave duplicada ou violação de índice.
3. **Quebra do Contexto Multi-Filial em Threads:** Em processos em lote, rotinas de integração (APIs/REST) ou *Jobs* de segundo plano que alternam o contexto de filial em memória, a atribuição manual impede que o sistema adapte a gravação ao contexto vigente, gerando contaminação de dados cruzados entre filiais.