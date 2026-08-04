# Exercício 3 — Recriando a ZA1 no Configurador

> Sem ambiente Protheus disponível, segue a descrição dos passos que eu executaria, na ordem, com base no que foi mostrado em aula (criar a tabela customizada ZA1 do zero, com nome do pet, raça, data de nascimento e filial).

## Passos

1. **Abrir o Configurador (SIGACFG)** no ambiente de desenvolvimento, com acesso ao dicionário de dados.
2. **Cadastrar a tabela no SX2** — acessar *Dicionário de Dados → Tabelas (SX2)* e incluir uma nova tabela:
   - Nome: **ZA1**
   - Descrição: "Cadastro de Pets"
   - Definir o **arquivo físico** (nome/caminho do DBF), verificando se o diretório existe e se o nome é compatível com o limite de caracteres do arquivo.
3. **Cadastrar os campos no SX3** — em *Dicionário de Dados → Campos (SX3)*, incluir cada campo da tabela:
   - **ZA1_FILIAL** — tipo C, tamanho 2, **obrigatório** (filial é exigida em toda tabela)
   - **ZA1_NOME** — tipo C, tamanho 50, com **título** preenchido
   - **ZA1_RACA** — tipo C, tamanho 30
   - **ZA1_NASC** — tipo D, tamanho 8
   - Atenção ao **limite de caracteres do título** na exibição do Browse — o título curto é o que aparece na grade.
4. **Definir o índice** no cadastro da tabela: expressão `ZA1_FILIAL + ZA1_NOME` como chave principal.
5. **Forçar o reconhecimento da tabela** pelo framework — rodar a **rotina de fórmulas** no Configurador, como foi feito em aula, para o sistema gerar/reconhecer a estrutura nova.
6. **Conferir no MPSDU** — abrir o MPSDU (inspeção de arquivos, **somente em desenvolvimento**), localizar a ZA1 e validar se os campos, tipos, tamanhos e o índice aparecem corretamente.

## Dificuldades esperadas

- **Caminho do arquivo**: o DBF físico deve ficar no local/configuração corretos, senão a tabela não é encontrada pelo framework.
- **Campos obrigatórios**: sem o campo de filial, a tabela não é aceita.
- **Restrição de tamanho do título no Browse**: títulos muito longos são truncados na exibição — é preciso escolher um título curto.
- **Reconhecimento**: se a rotina de fórmulas não for executada, o framework não enxerga a estrutura nova.
