#include "totvs.ch"

/*/{Protheus.doc} VALEXCSZ1
    Desafio 7a: Valida integridade referencial antes da exclusao de um Contato.
    @type  Function
    @author Pedro Almeida
    @since 2026-08-04
    @return Logical, .T. se pode excluir, .F. se houver interacoes vinculadas
/*/
USER FUNCTION VALEXCSZ1()
	LOCAL lPodeExcluir := .T.

	// Verifica se existem interacoes associadas na tabela SZ2
	IF ExistCpo("SZ2", xFilial("SZ2") + SZ1->Z1_CODIGO, 1)
		MsgStop("Nao e possivel excluir este contato pois existem Interacoes (SZ2) vinculadas a ele!", "Integridade Referencial")
		lPodeExcluir := .F.
	ENDIF

RETURN lPodeExcluir

/*/{Protheus.doc} EXECUTARSEGURO
    Desafio 7b: Executor seguro generico que roda blocos de codigo em BEGIN SEQUENCE.
    @type  Function
    @author Pedro Almeida
    @since 2026-08-04
    @param bBloco, CodeBlock, Bloco de codigo a ser executado
    @param cMsgErro, Character, Mensagem amigavel ao usuario em caso de falha
    @return Logical, .T. se executou com sucesso, .F. caso contrario
/*/
USER FUNCTION EXECUTARSEGURO(bBloco, cMsgErro)
	LOCAL lSucesso := .T.

	Default bBloco   := {|| NIL}
	Default cMsgErro := "Falha na execucao da operacao."

	BEGIN SEQUENCE
		// Executa o bloco passado por parametro
		Eval(bBloco)

		RECOVER WITH oErro
		lSucesso := .F.

		// Notifica o usuario com a mensagem amigavel
		MsgStop(cMsgErro + CRLF + "Detalhes: " + IF(ValType(oErro) == "O", oErro:Description, "Erro desconhecido"), "Execucao Segura")

		// Registra o erro no log
		U_GRAVARLOG("EXECUTARSEGURO", oErro)

	END SEQUENCE

RETURN lSucesso
