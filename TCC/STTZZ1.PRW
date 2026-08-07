#INCLUDE "PROTHEUS.CH"

// A declaracao abaixo elimina o valor chumbado e centraliza a regra de negocio
#DEFINE DIAS_ALERTA 30  

/*
======================================================================
Autor: Pedro
Data: 06/08/2026
Objetivo: Controle de Fornecimento ISO 9001 (Cadastro ZZ1)
======================================================================
*/

User Function STTZZ1()
    Local cAlias := "ZZ1"
    Local cTitulo := "Controle de Fornecimento (ISO 9001)"
    Local aCores := {}

    AAdd(aCores, {"ZZ1->ZZ1_VALCER < dDataBase", "BR_VERMELHO"})
    AAdd(aCores, {"ZZ1->ZZ1_VALCER >= dDataBase .AND. ZZ1->ZZ1_VALCER <= dDataBase + DIAS_ALERTA", "BR_AMARELO"})
    AAdd(aCores, {"ZZ1->ZZ1_VALCER > dDataBase + DIAS_ALERTA", "BR_VERDE"})
    

    Private cCadastro := cTitulo
    Private aRotina   := {}

    AAdd(aRotina, {"Pesquisar",  "AxPesqui",     0, 1})
    AAdd(aRotina, {"Visualizar", "AxVisual",     0, 2})
    AAdd(aRotina, {"Incluir",    "U_STTIncZ1",   0, 3}) // <- Alterado para rotina customizada
    AAdd(aRotina, {"Alterar",    "AxAltera",     0, 4})
    AAdd(aRotina, {"Excluir",    "U_STTAxDel",   0, 5}) // <- Aponta para trava de integridade
    AAdd(aRotina, {"Ocorrencias","U_STTZZ2",     0, 6})

    dbSelectArea(cAlias)
    dbSetOrder(1)

    mBrowse(6, 1, 22, 75, cAlias, , , , , , , , , , , aCores)

Return NIL

//Tratamento de Erros na Gravacao (BEGIN SEQUENCE)
User Function STTIncZ1(cAlias, nReg, nOpc)
    Local oError

    BEGIN SEQUENCE

        AxInclui(cAlias, nReg, nOpc)

    RECOVER USING oError

        MsgStop("Erro critico interceptado durante a gravacao: " + oError:Description)
        U_STTLog("Falha na Inclusao ZZ1: " + oError:Description, "erro_zz1.log")

    END SEQUENCE

Return NIL

User Function STTAxDel(cAlias, nReg, nOpc)
    If U_Z1VldExc()
        AxDeleta(cAlias, nReg, nOpc)
    EndIf
Return NIL
