#include "totvs.ch"

/*/{Protheus.doc} STTIP003
    Rotina principal de Gestao de Contatos (SZ1).
    @type  Function
    @author Pedro Almeida
    @since 2026-08-04
/*/
USER FUNCTION STTIP003()
	LOCAL cAlias   := "SZ1"
	LOCAL aColors  := {}
	PRIVATE cCadastro := "Gestao de Contatos"
	PRIVATE aRotina   := {}

	// Montagem do Menu de Acoes (aRotina)
	AAdd(aRotina, {"Pesquisar",  "AxPesqui",    0, 1})
	AAdd(aRotina, {"Visualizar", "AxVisual",    0, 2})
	AAdd(aRotina, {"Incluir",    "U_STTIP003INC", 0, 3})
	AAdd(aRotina, {"Alterar",    "AxAltera",    0, 4})
	AAdd(aRotina, {"Excluir",    "U_STTIP003EXC", 0, 5})
	AAdd(aRotina, {"Interacoes", "U_STTIP004",    0, 6}) // Relacionamento com SZ2

	// Legendas em Portugues (Errata)
	AAdd(aColors, {"Empty(SZ1->Z1_EMAIL)", "BR_AMARELO"})  // Atencao: Contato sem email
	AAdd(aColors, {".T.",                   "BR_VERDE"})    // Contato completo

	dbSelectArea(cAlias)
	dbSetOrder(1) // Z1_FILIAL + Z1_CODIGO

	mBrowse(6, 1, 22, 75, cAlias, , , , , , aColors)

RETURN NIL

/*/{Protheus.doc} STTIP003INC
    Chamada customizada de inclusao.
/*/
USER FUNCTION STTIP003INC(cAlias, nReg, nOpc)
	AxInclui(cAlias, nReg, nOpc, , , , "U_STTIP003SALVAR()")
RETURN NIL

/*/{Protheus.doc} STTIP003EXC
    Chamada customizada de exclusao com validacao de integridade (Ex 7a).
/*/
USER FUNCTION STTIP003EXC(cAlias, nReg, nOpc)
	IF U_VALEXCSZ1()
		AxDeleta(cAlias, nReg, nOpc)
	ENDIF
RETURN NIL
