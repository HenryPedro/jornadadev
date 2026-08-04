# Exercício 7 — Mecanismo de Gatilhos (SX7) e Automação de CEP

> **Nota de Contexto:** Resposta teórica e estrutural sobre o funcionamento dos gatilhos do Protheus.

---

### a. Qual a diferença entre campo, contra-domínio e regra num gatilho?

- **Campo:** É o campo de origem (disparador) que escuta a interação do usuário. Quando ele perde o foco (`Valid`), o gatilho é acionado (ex.: `A1_CEP`).
- **Contra-domínio:** É o campo de destino que receberá o valor devolvido pela função do gatilho (ex.: `A1_BAIRRO`, `A1_MUN`, `A1_EST`).
- **Regra:** É a instrução em linguagem ADVPL responsável por calcular e retornar o valor correspondente para preencher o contra-domínio (ex.: `U_STCEP(M->A1_CEP, "BAIRRO")`).

---

### b. Por que a regra usa M->A1_CEP e não SA1->A1_CEP?

A notação `M->A1_CEP` refere-se à **variável de memória** em edição no formulário, contendo o valor exato recém-digitado pelo usuário antes da gravação[cite: 1].

A notação `SA1->A1_CEP` faz referência ao campo físico gravado no disco/banco de dados relacional. Como o gatilho é disparado durante a digitação e antes da confirmação da tela, o banco ainda contém o dado antigo (ou nulo, caso seja inclusão). Usar `SA1->` faria o gatilho ler dados desatualizados.

---

### c. Os CEPs estão dentro do fonte. Cite dois problemas disso em produção e como você resolveria.

1. **Manutenção Engessada e Dependência de Compilação:** Qualquer inclusão, alteração ou exclusão de CEP exige alteração de código-fonte e recompilação (`.RPO`), gerando risco operacional em produção.
   - _Solução:_ Migrar a base de CEPs para uma tabela física de dicionário (ex.: `SYD` ou tabela customizada `ZCP`) com interface de manutenção pelo próprio usuário final.
2. **Obsolescência Rápida dos Dados:** CEPs e logradouros mudam constantemente no território nacional, tornando o banco local rapidamente ultrapassado.
   - _Solução:_ Integrar a rotina ADVPL a uma API REST externa em tempo real (ex.: ViaCEP ou serviço dos Correios) utilizando as classes `FWRest` / `HTTPGet` do Protheus.

---

### d. Se pedissem para preencher também o código do município (A1_COD_MUN), o que você faria?

Cadastraria uma nova sequência no dicionário de gatilhos (`SX7`) para o campo `A1_CEP`:

- **Campo:** `A1_CEP`
- **Sequência:** `004`
- **Contra-domínio:** `A1_COD_MUN`
- **Regra:** `U_STCEP(M->A1_CEP, "CODMUN")`

E estenderia a função `U_STCEP` para tratar o parâmetro `"CODMUN"`, retornando o código IBGE do município correspondente ao CEP informado.
