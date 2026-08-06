# 🚀 TOTVS-JornadaDEV (Start+)

<p align="center">
  <img src="https://img.shields.io/badge/Status-Em%20Desenvolvimento-blue?style=for-the-badge" alt="Status">
  <img src="https://img.shields.io/badge/Stack-Back--end-8E44AD?style=for-the-badge" alt="Stack">
  <img src="https://img.shields.io/badge/Ecossistema-TOTVS-009494?style=for-the-badge" alt="Ecossistema">
  <img src="https://img.shields.io/badge/Paradigma-Harbour%20%7C%20ADVPL%20%7C%20TL%2B%2B-orange?style=for-the-badge" alt="Paradigma">
  <img src="https://img.shields.io/badge/Projeto%20Final-ISO%209001%20(SIGACOM)-green?style=for-the-badge" alt="Projeto Final">
</p>

Repositório central de códigos, laboratórios de lógica e projetos práticos desenvolvidos durante a minha formação na **JornadaDEV do programa Start+ da TOTVS**. 

A filosofia desta jornada descarta avaliações teóricas tradicionais e foca exclusivamente em **Prova de Trabalho (Proof of Work)**, culminando no desenvolvimento de uma solução corporativa real, integrada e aderente às regras de negócio do maior ERP da América Latina.

---

## ⏳ Uma Tradição Sólida: A Evolução da Stack (xBase)

O ecossistema que estou dominando nesta jornada possui uma árvore genealógica de 4 décadas focada puramente em resolver problemas complexos de negócio e manipulação massiva de dados:

* **1980 (dBASE):** Origem da família xBase, focada na produtividade de bancos de dados.
* **1985 (Clipper):** O padrão de mercado no Brasil que consolidou uma geração inteira de sistemas comerciais.
* **Anos 2000 (A Evolução):** O legado evoluiu em duas frentes com mais de 90% de compatibilidade:
  * **Harbour:** Compilador xBase moderno, open-source e multiplataforma utilizado aqui para a fundação e consolidação de lógica, variáveis, estruturas de decisão, loops e funções.
  * **ADVPL & TL++:** Extensões diretas desse tronco xBase com superpoderes voltados para o ERP Protheus, adicionando suporte a dicionários de dados, POO (Orientação a Objetos) e arquitetura de microsserviços.

---

## 🏗️ O Projeto Final (TCC) — Gestão ISO 9001 no SIGACOM

O projeto de conclusão de curso simula um cenário real de engenharia de software para a **Indústria XYZ**, cobrindo o controle e rastreabilidade de **Não Conformidades na Entrada de Materiais** para manutenção da certificação **ISO 9001**.

### 📌 Arquitetura do Sistema
O sistema estende os módulos nativos de **Compras (SIGACOM)**, conectando o cadastro de Fornecedores (`SA2`) e Produtos (`SB1`) às novas rotinas customizadas:

1. **`ZZ1` — Controle de Fornecimento:** Tabela responsável pelo cadastro de certificados de qualidade dos fornecedores, controle de validade e definição de percentual de tolerância.
2. **`ZZ2` — Ocorrências do Fornecedor:** Tabela vinculada à `ZZ1` para registro detalhado das entregas com divergências ou problemas de qualidade por produto e item.

### 🛠️ Componentes & Regras Desenvolvidas
* **Dicionário de Dados & Tabelas (`SX2`, `SX3`, `SIX`):** Estruturação completa das tabelas `ZZ1` e `ZZ2` com chaves primárias e relacionamentos.
* **Rotinas de Manutenção (`mBrowse` / `AxCadastro`):**
  * `STTZZ1.PRW`: Gestão do cadastro de fornecimentos, contendo botões de atalho para ocorrências e legendas visuais dinâmicas (ex: certificado vencido, vencendo em 30 dias ou regular).
  * `STTZZ2.PRW`: Gestão de ocorrências com filtro dinâmico por fornecimento (`STTZZ2FLT`) e indicador de ultrapassagem do limite de tolerância em não conformidades.
* **Biblioteca Reutilizável (`STTZZLIB.PRW`):** Funções utilitárias como cálculo de `%` de não conformidade, busca otimizada via `POSICIONE`, tratamento centralizado de logs (`GravarLogTCC`) e validações de regras[cite: 2].
* **Automações & Validações (`SX7` e `SXB`):** Gatilhos automáticos de preenchimento de dados de parceiros, validação de integridade referencial (`ExistCpo`) e Consultas Padrão para interface com o usuário[cite: 2].
* **Resiliência & Transações:** Estrutura resiliente utilizando blocos `BEGIN SEQUENCE` com tratativa de erros amigável, registro de logs técnicos e *rollback* de transações[cite: 2].

---

## 📂 Estrutura de Aprendizado Progressivo

```text
├── 📂 modulo-01/                   # Primeiros Passos e Sintaxe Fundamental (Harbour)
│   ├── 📜 ex01-hello.prg
│   ├── 📜 ex02-saudacao.prg
│   ├── 📜 ex03-apresentacao.prg
│   └── 📜 ex04-data-hora.prg
│
├── 📂 modulo-02/                   # Lógica de Programação, Algoritmos e Fluxogramas
│   ├── 📜 ex01-algoritmo-valido.md
│   ├── 📜 ex02-pseudocodigo.md
│   ├── 📜 ex03-fluxograma-desconto.md
│   ├── 📜 ex04-refinamento.md
│   └── 📜 ex05-reflexao.md
│
├── 📂 modulo-03/                   # Variáveis, Expressões, Operadores e Fórmulas
│   ├── 📜 ex01-declaracoes.prg
│   ├── 📜 ex02-formulas.prg
│   ├── 📜 ex03-desconto-idoso.prg
│   ├── 📜 ex04-igualdade.prg
│   └── 📜 ex05-media-ponderada.prg
│
├── 📂 modulo-04/                   # Estruturas Condicionais (Decisões de Negócio)
│   ├── 📜 ex01-maior-menor.prg
│   ├── 📜 ex02-reajuste-salarial.prg
│   ├── 📜 ex03-calculadora.prg
│   ├── 📜 ex04-nome-mes.prg
│   └── 📜 ex05-plano-saude.prg
│
├── 📂 modulo-05/                   # Estruturas de Repetição (Loops e Validações)
│   ├── 📜 ex01-sequencias-for.prg
│   ├── 📜 ex02-dobro-while.prg
│   ├── 📜 ex03-maquina-soma.prg
│   ├── 📜 ex04-validacao-aluno.prg
│   ├── 📜 ex05-loop-programa.prg
│   └── 📜 ex06-adivinhe-numero.prg
│
├── 📂 modulo-06/                   # Modularização, Funções, Procedures e Algoritmos Avançados
│   ├── 📂 ex04-biblioteca-matematica/
│   │   ├── 📜 matematica.prg
│   │   └── 📜 principal.prg
│   ├── 📂 ex11-controle-estoque/
│   │   ├── 📜 estoque-main.prg
│   │   └── 📜 estoque_lib.prg
│   ├── 📜 ex01-funcao-ou-procedimento.prg
│   ├── 📜 ex02-relogio-modular.prg
│   ├── 📜 ex03-calculadora-refatorada.prg
│   ├── 📜 ex05-jokenpo-modular.prg
│   ├── 📜 ex06-dias-da-semana.prg
│   ├── 📜 ex07-estatisticas-numeros.prg
│   ├── 📜 ex08-sistema-notas.prg
│   ├── 📜 ex09-carrinho-compras.prg
│   └── 📜 ex10-bubble-sort.prg
│
├── 📂 modulo-07/                   # Introdução ao Dicionário do Protheus e Tabelas Customizadas
│   ├── 📜 ex01-conceitos-fundamentais.md
│   ├── 📜 ex02-estrutura-za1-pets.md
│   ├── 📜 ex03-recriar-za1.md
│   ├── 📜 ex04-campo-customizado-sa1.md
│   └── 📜 ex05-filial-xfilial.md
│
├── 📂 modulo-08/                   # Interface ADVPL, Telas, Validações e Gatilhos
│   ├── 📜 ex01-axcadastro-vs-mbrowse.md
│   ├── 📜 ex02-tabela-za1.md
│   ├── 📜 ex03-axcadastro-za1.prw
│   ├── 📜 ex04-validacao-existcpo.prw
│   ├── 📜 ex05-mbrowse-za1.prw
│   ├── 📜 ex06-legendas-coloridas.prw
│   ├── 📜 ex07-gatilho-cep.md
│   └── 📜 ex08-filtro-mes.prw
│
├── 📂 modulo-09/                   # Resiliência, Dicionários Avançados e Bibliotecas
│   ├── 📂 ex02-biblioteca-rotinas/
│   │   ├── 📜 STTIP003.prw
│   │   ├── 📜 STTIP004.prw
│   │   └── 📜 STTIPLIB.prw
│   ├── 📜 ex01-dicionario-dados.md
│   ├── 📜 ex03-gatilhos-validacoes.md
│   ├── 📜 ex04-menu-sigacom.md
│   ├── 📜 ex05-tratamento-erros.prg
│   ├── 📜 ex06-gravacao-segura.prw
│   └── 📜 ex07-executor-seguro.prw
│
└── 📂 TCC/                         # Projeto Final de Conclusão de Curso (ISO 9001)
    ├── 📂 Dados-e-Dicionario/       # Dicionários (SX2, SX3, SX7, SIX, SXB), massa de dados (.dbf) e menus (.xnu)
    ├── 📜 STTZZ1.PRW               # Rotina mBrowse da tabela ZZ1 (Controle de Fornecimento)
    ├── 📜 STTZZ2.PRW               # Rotina mBrowse e Filtros da tabela ZZ2 (Ocorrências)
    ├── 📜 STTZZLIB.PRW             # Biblioteca de funções comuns, cálculos e logs
    ├── 📜 TCC.PRJ                  # Projeto de compilação no TOTVS Developer Studio
    └── 📜 TCC-Documentacao.docx    # Documentação técnica e operacional do projeto
