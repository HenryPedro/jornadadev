#INCLUDE "PROTHEUS.CH"

/*
======================================================================
Autor: Pedro
Data: 07/08/2026
Objetivo: Biblioteca central de funcoes e Classes ADVPL (POO)
======================================================================
*/

CLASS TCertifRules
    DATA cFilialZ1
    DATA cCodigoZ1
    METHOD New(cFil, cCod)
    METHOD PossuiOcorrencia()
ENDCLASS

METHOD New(cFil, cCod) CLASS TCertifRules
    ::cFilialZ1 := cFil
    ::cCodigoZ1 := cCod
RETURN Self

METHOD PossuiOcorrencia() CLASS TCertifRules
    Local lEncontrou := .F.
    DbSelectArea("ZZ2")
    ZZ2->(DbSetOrder(1)) 
    If ZZ2->(DbSeek(::cFilialZ1 + ::cCodigoZ1))
        lEncontrou := .T.
    EndIf
RETURN lEncontrou

// FUNCAO DE TRAVA DE EXCLUSAO
User Function Z1VldExc()
    Local oCertif 
    Local lPermite := .T.

    oCertif := TCertifRules():New(xFilial("ZZ1"), ZZ1->ZZ1_CODIGO)
    If oCertif:PossuiOcorrencia()
        MsgStop("Exclusao Bloqueada: Existem ocorrencias vinculadas a este certificado.")
        lPermite := .F.
    EndIf

Return lPermite


// Calculo de Tolerancia
User Function Z2CalcTol(nQtdNOK, nQtdOK, nTolerancia)
    Local nTotal := nQtdNOK + nQtdOK
    Local nPercNOK := 0
    Local cCorRet := "VERDE"

    If nTotal > 0
        nPercNOK := (nQtdNOK / nTotal) * 100
    EndIf

    If nPercNOK > nTolerancia
        cCorRet := "VERMELHO"
    EndIf

Return cCorRet

User Function STTLog(cMensagem, cNomeArq)
    Local cArquivo := If(Empty(cNomeArq), "erro_padrao.log", cNomeArq)
    Local nHandle

    If !File(cArquivo)
        nHandle := FCreate(cArquivo)
    Else
        nHandle := FOpen(cArquivo, 1)
        FSeek(nHandle, 0, 2) // Vai para o final do arquivo
    EndIf

    FWrite(nHandle, DToC(Date()) + " " + Time() + " - " + cMensagem + CRLF)
    FClose(nHandle)
Return NIL
