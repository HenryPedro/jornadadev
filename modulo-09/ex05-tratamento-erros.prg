/*
    Exercício 5 - Primeiro contato com erros em Harbour Puro (.prg)
    Demostracao de controle de fluxo de excecao utilizando BEGIN SEQUENCE / RECOVER.
*/

FUNCTION Main()
	LOCAL nA   := 10
	LOCAL nB   := 0
	LOCAL nRes := 0

	QOut("--- INICIO DO PROGRAMA HARBOUR ---")

	BEGIN SEQUENCE
		QOut("Tentando realizar a divisao: " + Str(nA) + " / " + Str(nB))
		nRes := nA / nB

		// Esta linha nao sera executada devido ao erro
		QOut("Resultado da Operacao: " + Str(nRes))

		RECOVER WITH oErro
		// Captura do objeto de erro instanciado pelo Harbour
		QOut("-> SUCESSO NO TRATAMENTO DE ERRO <-")
		QOut("Erro capturado: " + oErro:Description)
	END SEQUENCE

	QOut("O programa continua de pe e executando normalmente!")
	QOut("--- FIM DO PROGRAMA ---")

RETURN NIL
