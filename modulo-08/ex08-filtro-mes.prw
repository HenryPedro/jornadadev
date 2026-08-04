#include "totvs.ch"

/*/{Protheus.doc} STTIP002
    mBrowse com Filtro de Mês Atual + Botão de Limpeza do Filtro + Histórico.
    @type  Function
    @author Pedro Almeida
    @since 2026-08-04
/*/
USER FUNCTION STTIP002()
	LOCAL cAlias  := "ZA1"
	LOCAL cFiltro := ""
	PRIVATE cCadastro := "Pets do Mes Atual"
	PRIVATE aRotina := {}

	// Construcao do Filtro do Mes e Ano Corrente
	cFiltro := "Month(ZA1->ZA1_DTNASC) == Month(dDataBase) .AND. Year(ZA1->ZA1_DTNASC) == Year(dDataBase)"

	// Montagem das acoes
	AAdd(aRotina, {"Pesquisar",     "AxPesqui",    0, 1})
	AAdd(aRotina, {"Visualizar",    "AxVisual",    0, 2})
	AAdd(aRotina, {"Incluir",       "AxInclui",    0, 3})
	AAdd(aRotina, {"Alterar",       "AxAltera",    0, 4})
	AAdd(aRotina, {"Excluir",       "AxDeleta",    0, 5})
	AAdd(aRotina, {"Remover Filtro","U_STLimpaFlt", 0, 6}) // Acao Customizada
	AAdd(aRotina, {"Historico",     "U_STHistPet",  0, 6}) // Acao Customizada

	dbSelectArea(cAlias)
	dbSetOrder(1)

	// Executa a mBrowse aplicando o filtro inicial
	mBrowse(6, 1, 22, 75, cAlias, , , , , , , , , , , , , cFiltro)

RETURN NIL

/*/{Protheus.doc} STLimpaFlt
    Funcao chamada pelo botao do aRotina para reabrir a Browse sem filtro.
/*/
USER FUNCTION STLimpaFlt()
	LOCAL cAlias := "ZA1"

	// Reabre o browse sem a restricao do filtro cFiltro
	mBrowse(6, 1, 22, 75, cAlias)
RETURN NIL

/*/{Protheus.doc} STHistPet
    Funcao de historico que exibe dados detalhados do pet selecionado.
/*/
USER FUNCTION STHistPet()
	LOCAL cMensagem := ""

	cMensagem := "Codigo: " + ZA1->ZA1_COD + CRLF
	cMensagem += "Nome: "   + ZA1->ZA1_NOME + CRLF
	cMensagem += "Raca: "   + ZA1->ZA1_RACA + CRLF
	cMensagem += "Data Nascimento: " + DToC(ZA1->ZA1_DTNASC)

	MsgInfo(cMensagem, "Historico do Registro Atual")
RETURN NIL
