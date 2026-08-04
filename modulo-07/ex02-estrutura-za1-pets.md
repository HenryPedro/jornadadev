# Exercício 2 — A tabela ZA1 (Pets)

## a. Campos da ZA1

| Campo | Tipo | Tamanho | Descrição |
|-------|------|---------|-----------|
| ZA1_FILIAL | C (Caractere) | 2 | Código da Filial (gerenciado via `xFilial`). OBRIGATÓRIO em tabelas compartilhadas ou exclusivas no Protheus. |
| ZA1_COD | C (Caractere) | 6 | Código identificador do pet (Chave Primária / Sequencial). |
| ZA1_NOME | C (Caractere) | 50 | Nome do pet. |
| ZA1_RACA | C (Caractere) | 30 | Raça do pet. |
| ZA1_NASC | D (Data) | 8 | Data de nascimento do pet. |

## b. Índice que faria sentido para a ZA1

* **Ordem 1 (Chave Primária):** `ZA1_FILIAL + ZA1_COD`
* **Ordem 2 (Chave de Pesquisa):** `ZA1_FILIAL + ZA1_NOME + ZA1_COD`

**Justificativa:** 
O índice cria uma estrutura em árvore (B-Tree) ordenada no banco de dados. Em vez de realizar um *Full Table Scan* (percorrer a tabela registro a registro), a busca via ADVPL (`DbSeek`) ou em queries SQL utiliza a chave indexada para ir direto ao endereço físico do registro. 

A inclusão do `ZA1_FILIAL` no início é indispensável no Protheus para respeitar o isolamento de dados por filial. A Ordem 1 garante a unicidade do cadastro por código, enquanto a Ordem 2 otimiza as consultas mais frequentes por nome de pet, evitando duplicidade aparente na busca ordenando também pelo código.

## c. Por que o prefixo da tabela é Z

O prefixo iniciado com a letra **Z** (`ZA1`, `ZB1`, `ZZ1`...) é a convenção reservada pelo ERP Protheus para **tabelas customizadas do cliente ou parceiro**. 

Tabelas com prefixos iniciados de **A a Y** pertencem ao dicionário padrão de fábrica da TOTVS. A utilização do **Z** assegura o isolamento de escopo: garante que scripts de atualização da TOTVS (como o `UPDDISTR` em atualizações de *release*) não sobrescrevam, alterem ou entrem em conflito com as estruturas criadas pelo desenvolvedor.

## d. Por que os campos começam com ZA1_ e não com o nome solto

Os campos do Protheus adotam rigorosamente o padrão `<PREFIXO_TABELA>_<NOME_CAMPO>` no Dicionário SX3 pelos seguintes motivos técnicos:

1. **Prevenção de colisão em SQL (`JOIN`s):** Ao cruzar a tabela `ZA1` (Pets) com a `SA1` (Clientes), ambas possuem o campo `NOME`. Se fossem nomeados de forma solta, haveria ambiguidade nas queries SQL e no dicionário. Com a convenção, `ZA1_NOME` e `A1_NOME` são perfeitamente distintos.
2. **Qualificação de escopo e memória:** A sintaxe do ADVPL utiliza o prefixo para manipular os buffers de memória e tabela, como a diferença entre a variável de memória em tela (`M->ZA1_NOME`) e o campo gravado no disco (`ZA1->ZA1_NOME`).
3. **Mapeamento no Framework e MVC:** O motor da aplicação (framework) e as classes de MVC (`FWFormModel`, `FWFormView`) dependem dessa padronização para realizar o *binding* automático entre os dicionários de dados, componentes visuais e operações de persistência.