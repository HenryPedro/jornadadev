#include "protheus.ch"

USER FUNCTION STTZZ2()
    LOCAL cAlias   := "ZZ2"
    LOCAL aColors  := {}
    PRIVATE cCadastro := "Ocorrencias de Fornecedores (ZZ2)"
    PRIVATE aRotina   := {}

    AAdd(aRotina, {"Pesquisar",  "AxPesqui", 0, 1})
    AAdd(aRotina, {"Visualizar", "AxVisual", 0, 2})
    AAdd(aRotina, {"Incluir",    "AxInclui", 0, 3})
    AAdd(aRotina, {"Alterar",    "AxAltera", 0, 4})
    AAdd(aRotina, {"Excluir",    "AxDeleta", 0, 5})

    // Legenda calculando a tolerancia exigida no TCC
    AAdd(aColors, {"U_EvalTolera(ZZ2->ZZ2_CONFOR, ZZ2->ZZ2_QTDOK, ZZ2->ZZ2_QTDNOK) == 'R'", "BR_VERMELHO"}) // Acima da Tolerancia
    AAdd(aColors, {".T.", "BR_VERDE"}) // Dentro da Tolerancia

    ChkFile(cAlias)
    dbSelectArea(cAlias)
    dbSetOrder(1)

    mBrowse(6, 1, 22, 75, cAlias, , , , , , aColors)
RETURN NIL

/*/{Protheus.doc} STTZZ2FLT
    Rotina filtrada chamada pelo botao 'Ocorrencias' da ZZ1.
/*/
USER FUNCTION STTZZ2FLT()
    LOCAL cAlias     := "ZZ2"
    LOCAL aColors    := {}
    LOCAL cCodigoZZ1 := ZZ1->ZZ1_CODIGO
    LOCAL cFiltro    := "ZZ2_CONFOR == '" + cCodigoZZ1 + "'"
    LOCAL aIndexZZ2  := {}
    
    PRIVATE cCadastro := "Ocorrencias - NC: " + cCodigoZZ1
    PRIVATE aRotina   := {}

    AAdd(aRotina, {"Pesquisar",  "AxPesqui", 0, 1})
    AAdd(aRotina, {"Visualizar", "AxVisual", 0, 2})
    AAdd(aRotina, {"Incluir",    "AxInclui", 0, 3})
    AAdd(aRotina, {"Alterar",    "AxAltera", 0, 4})
    AAdd(aRotina, {"Excluir",    "AxDeleta", 0, 5})

    AAdd(aColors, {"U_EvalTolera(ZZ2->ZZ2_CONFOR, ZZ2->ZZ2_QTDOK, ZZ2->ZZ2_QTDNOK) == 'R'", "BR_VERMELHO"})
    AAdd(aColors, {".T.", "BR_VERDE"})

    ChkFile(cAlias)
    dbSelectArea(cAlias)
    dbSetOrder(1)

    // Estrutura exigida para ativar o filtro corretamente
    FilBrowse(cAlias, @aIndexZZ2, @cFiltro)
    mBrowse(6, 1, 22, 75, cAlias, , , , , , aColors)
    EndFilBrw(cAlias, aIndexZZ2)

RETURN NIL