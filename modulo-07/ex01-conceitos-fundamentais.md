# Exercício 1 — Conceitos Fundamentais

### a. Qual é a função do AppServer?
O AppServer é o servidor de aplicação do Protheus responsável por interpretar e executar o código compilado em ADVPL/TL++. Ele gerencia as conexões e threads de usuários, controla a memória de execução das rotinas e intermediar a comunicação entre a interface (SmartClient, APIs, Web) e o banco de dados via DBAccess.

### b. O que é o RPO?
O RPO (Repository of Objects) é o repositório binário que armazena os códigos-fonte compilados (bytecodes) do sistema. Ele unifica em um único arquivo de dados tanto o dicionário/rotinas padrão fornecidas pela TOTVS quanto as customizações desenvolvidas pelo cliente para rápida leitura do AppServer.

### c. Para que serve o Configurador (SIGACFG)?
O SIGACFG é o módulo administrativo central utilizado para realizar a gestão e manutenção do ecossistema Protheus. Ele permite administrar usuários, perfis, restrições e menus, alterar os dicionários de dados e tabelas (SXs) e gerenciar os parâmetros globais da aplicação (SX6).

### d. Qual a diferença entre campo Real e campo Virtual no SX3?
O campo Real possui uma coluna equivalente criada fisicamente na tabela do banco de dados relacional, onde a informação é gravada e mantida de forma persistente. O campo Virtual existe apenas na camada de aplicação e no dicionário SX3, sendo utilizado para cálculos em memória, validações ou exibição em tela sem alterar a estrutura do banco.