#include "protheus.ch"

/*/{Protheus.doc} NomeFornecedor
    Busca o nome do fornecedor via POSICIONE na SA2.
/*/
USER FUNCTION NomeFornecedor(cFornec, cLoja)
    LOCAL cNome := ""
    cNome := Posicione("SA2", 1, xFilial("SA2") + cFornec + cLoja, "A2_NOME")
RETURN cNome

/*/{Protheus.doc} NomeProduto
    Busca a descricao do produto via POSICIONE na SB1.
/*/
USER FUNCTION NomeProduto(cCodPro)
    LOCAL cDesc := ""
    cDesc := Posicione("SB1", 1, xFilial("SB1") + cCodPro, "B1_DESC")
RETURN cDesc

/*/{Protheus.doc} PercNaoConforme
    Calcula o percentual de nao conformidade.
/*/
USER FUNCTION PercNaoConforme(nOk, nNok)
    LOCAL nPerc := 0
    LOCAL nTotal := nOk + nNok

    IF nTotal > 0
        nPerc := (nNok / nTotal) * 100
    ENDIF
RETURN nPerc

/*/{Protheus.doc} CertificadoVencendo
    Retorna .T. se o certificado vence em ate 30 dias.
/*/
USER FUNCTION CertificadoVencendo(dValCer)
    LOCAL lVencendo := .F.
    IF dValCer >= dDataBase .AND. dValCer <= (dDataBase + 30)
        lVencendo := .T.
    ENDIF
RETURN lVencendo

/*/{Protheus.doc} GravarLogTCC
    Grava log de erro em arquivo texto (Substitui a antiga ZZ1LogErro).
/*/
USER FUNCTION GravarLogTCC(cFuncao, oErro)
    LOCAL cFileHand := "tcc_iso9001.log"
    LOCAL nHandle   := 0
    LOCAL cLogMsg   := ""
    LOCAL cUser     := IF(Type("cUserName") != "U", cUserName, "ADMIN")

    cLogMsg := "--------------------------------------------------------" + CRLF
    cLogMsg += "DATA/HORA : " + DToC(dDataBase) + " - " + Time() + CRLF
    cLogMsg += "FUNCAO    : " + cFuncao + CRLF
    cLogMsg += "USUARIO   : " + cUser + CRLF

    IF ValType(oErro) == "O"
        cLogMsg += "ERRO DET. : " + oErro:Description + CRLF
        cLogMsg += "LINHA ERRO: " + AllTrim(Str(oErro:SubLine)) + CRLF
    ELSE
        cLogMsg += "ERRO DET. : Falha operacional de transacao/banco." + CRLF
    ENDIF
    cLogMsg += "--------------------------------------------------------" + CRLF + CRLF

    IF !File(cFileHand)
        nHandle := fCreate(cFileHand)
    ELSE
        nHandle := fOpen(cFileHand, 2)
        fSeek(nHandle, 0, 2)
    ENDIF

    IF nHandle != -1
        fWrite(nHandle, cLogMsg)
        fClose(nHandle)
    ENDIF
RETURN NIL

/*/{Protheus.doc} EvalTolera
    Funcao auxiliar para avaliar se a linha da ZZ2 ultrapassa a tolerancia da ZZ1.
/*/
USER FUNCTION EvalTolera(cConfor, nQtdOk, nQtdNok)
    LOCAL nTolera := Posicione("ZZ1", 1, xFilial("ZZ1") + cConfor, "ZZ1_TOLERA")
    LOCAL nPercNC := U_PercNaoConforme(nQtdOk, nQtdNok)
    LOCAL cRet    := "V" // Verde (Dentro da tolerancia)

    IF nPercNC > nTolera
        cRet := "R" // Vermelho (Acima da tolerancia)
    ENDIF
RETURN cRet