#include "totvs.ch"

/*/{Protheus.doc} STTIP004
    Rotina de Interacoes (SZ2) filtrada pelo Contato selecionado no browse da SZ1.
    @type  Function
    @author Pedro Almeida
    @since 2026-08-04
/*/
USER FUNCTION STTIP004()
	LOCAL cAlias  := "SZ2"
	LOCAL cFiltro := ""
	PRIVATE cCadastro := "Interacoes do Contato: " + ALLTRIM(SZ1->Z1_NOME)
	PRIVATE aRotina   := {}

	// Menu basico para a tabela de interacoes
	AAdd(aRotina, {"Pesquisar",  "AxPesqui", 0, 1})
	AAdd(aRotina, {"Visualizar", "AxVisual", 0, 2})
	AAdd(aRotina, {"Incluir",    "AxInclui", 0, 3})
	AAdd(aRotina, {"Alterar",    "AxAltera", 0, 4})
	AAdd(aRotina, {"Excluir",    "AxDeleta", 0, 5})

	// Filtro restrito ao contato posicionado na SZ1
	cFiltro := "SZ2->Z2_CONTAT == '" + SZ1->Z1_CODIGO + "'"

	dbSelectArea(cAlias)
	dbSetOrder(1)

	mBrowse(6, 1, 22, 75, cAlias, , , , , , , , , , , , , cFiltro)

RETURN NIL

/*/{Protheus.doc} STTIP004B
    Versao sem filtro de interacoes (Listagem Geral para uso no Menu do SIGACOM).
/*/
USER FUNCTION STTIP004B()
	LOCAL cAlias := "SZ2"
	PRIVATE cCadastro := "Listagem Geral de Interacoes"
	PRIVATE aRotina   := {}

	AAdd(aRotina, {"Pesquisar",  "AxPesqui", 0, 1})
	AAdd(aRotina, {"Visualizar", "AxVisual", 0, 2})
	AAdd(aRotina, {"Incluir",    "AxInclui", 0, 3})
	AAdd(aRotina, {"Alterar",    "AxAltera", 0, 4})
	AAdd(aRotina, {"Excluir",    "AxDeleta", 0, 5})

	dbSelectArea(cAlias)
	dbSetOrder(1)

	mBrowse(6, 1, 22, 75, cAlias)

RETURN NIL
