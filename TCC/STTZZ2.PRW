#INCLUDE "PROTHEUS.CH"

/*
======================================================================
Autor: Pedro
Data: 07/08/2026
Objetivo: Apontamento de Ocorrencias e Nao Conformidades (ZZ2)
======================================================================
*/

User Function STTZZ2()
    Local cAlias := "ZZ2"
    Local cTitulo := "Ocorrencias e Desvios"
    Local aCores := {}

    AAdd(aCores, {"U_Z2CalcTol(ZZ2->ZZ2_QTDNOK, ZZ2->ZZ2_QTDOK, Posicione('ZZ1', 1, xFilial('ZZ1')+ZZ2->ZZ2_CONFOR, 'ZZ1_TOLERA')) == 'VERDE'", "BR_VERDE"})
    AAdd(aCores, {"U_Z2CalcTol(ZZ2->ZZ2_QTDNOK, ZZ2->ZZ2_QTDOK, Posicione('ZZ1', 1, xFilial('ZZ1')+ZZ2->ZZ2_CONFOR, 'ZZ1_TOLERA')) == 'VERMELHO'", "BR_VERMELHO"})

    Private cCadastro := cTitulo
    Private aRotina   := {}

    AAdd(aRotina, {"Pesquisar",  "AxPesqui", 0, 1})
    AAdd(aRotina, {"Visualizar", "AxVisual", 0, 2})
    AAdd(aRotina, {"Incluir",    "AxInclui", 0, 3})
    AAdd(aRotina, {"Alterar",    "AxAltera", 0, 4})
    AAdd(aRotina, {"Excluir",    "AxDeleta", 0, 5})

    dbSelectArea(cAlias)
    dbSetOrder(1)

    mBrowse(6, 1, 22, 75, cAlias, , , , , , , , , , , aCores)

Return NIL
