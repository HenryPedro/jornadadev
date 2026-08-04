#include "totvs.ch"

/*/{Protheus.doc} STTIP002
    Rotina mBrowse com aplicacao de regras de legendas coloridas (aColors).
    @type  Function
    @author Aluno
    @since 2026-08-04
/*/
USER FUNCTION STTIP002()
	LOCAL cAlias  := "ZA1"
	LOCAL aColors := {}
	PRIVATE cCadastro := "Gestao de Pets (Com Legendas)"
	PRIVATE aRotina := {}

	// Estrutura de acoes
	AAdd(aRotina, {"Pesquisar",  "AxPesqui",  0, 1})
	AAdd(aRotina, {"Visualizar", "AxVisual",  0, 2})
	AAdd(aRotina, {"Incluir",    "AxInclui",  0, 3})
	AAdd(aRotina, {"Alterar",    "AxAltera",  0, 4})
	AAdd(aRotina, {"Excluir",    "AxDeleta",  0, 5})

	// Regras de cores (avaliadas do topo para a base)
	// Cores padronizadas em Portugues conforme errata do modulo
	AAdd(aColors, {"ZA1->ZA1_DTNASC < (dDataBase - 3650)", "BR_VERMELHO"}) // Idosos (+10 anos)
	AAdd(aColors, {"ZA1->ZA1_DTNASC == dDataBase",        "BR_AMARELO"})  // Cadastrados/Nascidos Hoje
	AAdd(aColors, {".T.",                                 "BR_VERDE"})    // Demais registros

	dbSelectArea(cAlias)
	dbSetOrder(1)

	mBrowse(6, 1, 22, 75, cAlias, , , , , , aColors)

RETURN NIL
