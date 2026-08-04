#include "totvs.ch"

/*/{Protheus.doc} STTIP002
    Rotina de navegação e exibição em mBrowse para a tabela ZA1.
    @type  Function
    @author Aluno
    @since 2026-08-04
/*/
USER FUNCTION STTIP002()
	LOCAL cAlias := "ZA1"
	PRIVATE cCadastro := "Gestao de Pets"
	PRIVATE aRotina := {}

	// Definicao do menu de operacoes (aRotina)
	AAdd(aRotina, {"Pesquisar",  "AxPesqui",  0, 1})
	AAdd(aRotina, {"Visualizar", "AxVisual",  0, 2})
	AAdd(aRotina, {"Incluir",    "AxInclui",  0, 3})
	AAdd(aRotina, {"Alterar",    "AxAltera",  0, 4})
	AAdd(aRotina, {"Excluir",    "AxDeleta",  0, 5})

	dbSelectArea(cAlias)
	dbSetOrder(1)

	// Execucao da mBrowse padrao
	mBrowse(6, 1, 22, 75, cAlias)

RETURN NIL
