# Exercício 1 — AxCadastro vs. mBrowse

> **Nota de Contexto:** Respostas conceituais desenvolvidas considerando a arquitetura do Protheus e a lógica entendida durante as aulas.

---

### a. Quando usaria AxCadastro e quando usaria mBrowse? Dê um exemplo de cada.

- **AxCadastro:** Indicado para cadastros simples, tabelas acessórias ou mantenedores rápidos de registros onde não há necessidade de regras de negócio complexas na interface[cite: 1].
  - _Exemplo:_ Cadastro de Raças de Pets ou Cadastro de Tipos de Atendimento.
- **mBrowse:** Indicado para rotinas operacionais complexas, tabelas principais de processos do ERP e interfaces que exigem personalização de cores, filtros e ações customizadas no menu[cite: 1].
  - _Exemplo:_ Cadastro Principal de Pets (com vínculo de cliente, legendas por idade e histórico) ou Cadastro de Clientes (`MATA030`).

---

### b. Cite três coisas que o mBrowse faz e o AxCadastro não faz.

1. **Aplicação de Legendas Coloridas (`aColors`):** Permite renderizar as linhas do browse em cores dinâmicas com base em condições de campos do registro[cite: 1].
2. **Filtros Dinâmicos de Abertura (`cFiltro`):** Permite restringir quais registros serão carregados na tela via expressão ADVPL em tempo de execução[cite: 1].
3. **Construção de Menu Customizado (`aRotina`):** Permite criar botões com ações personalizadas (tipo 6) associadas a User Functions exclusivas da aplicação[cite: 1].

---

### c. Na configuração de legendas (aColors), por que a regra ".T." deve ficar por último?

O Protheus avalia a matriz de legendas sequencialmente, de cima para baixo. A primeira expressão que retornar verdadeira (`.T.`) define a cor da linha e encerra a avaliação para aquele registro. Como a expressão `".T."` é incondicionalmente verdadeira, se for posicionada no início ou no meio da matriz, ela "atropelará" todas as regras subsequentes, tornando-as inalcançáveis. Portanto, a regra `".T."` atua como um tratamento padrão (_default/else_) e deve obrigatoriamente ocupar a última posição[cite: 1].

---

### d. Qual a diferença entre um campo Virtual (X3_RELACAO) e um gatilho (SX7) para preencher o nome do cliente?

- **Campo Virtual (`X3_RELACAO`):** O dado não é gravado na tabela física do banco de dados relacional. Ele é recalculado e exibido dinamicamente em tempo de execução na interface via expressão de consulta (ex.: `POSICIONE`)[cite: 1].
- **Gatilho (`SX7`):** É um evento disparado ao validar a saída de um campo (perda de foco/Tab)[cite: 1]. Ele calcula um valor e preenche ativamente a variável de memória de outro campo (`M->CAMPO`), persistindo esse valor no banco de dados caso o campo de destino seja Real[cite: 1].
