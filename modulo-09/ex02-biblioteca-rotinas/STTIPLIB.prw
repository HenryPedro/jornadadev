#include "totvs.ch"

/*/{Protheus.doc} STTIPLIB
    Biblioteca de funcoes utilitarias do Projeto CRUD Contatos/Interacoes.
    @type  Function
    @author Pedro Almeida
    @since 2026-08-04
/*/

/*/{Protheus.doc} NomeCliente
    Retorna o nome do cliente a partir do Codigo e Loja.
/*/
USER FUNCTION NomeCliente(cCliente, cLoja)
	LOCAL cNome := ""

	Default cCliente := ""
	Default cLoja    := ""

	IF !Empty(cCliente) .AND. !Empty(cLoja)
		cNome := POSICIONE("SA1", 1, xFilial("SA1") + cCliente + cLoja, "A1_NOME")
	ENDIF
RETURN cNome

/*/{Protheus.doc} ProxCodigoSZ1
    Gera o proximo codigo sequencial disponivel para a tabela SZ1.
/*/
USER FUNCTION ProxCodigoSZ1()
	LOCAL cProxCod := GETSXENUM("SZ1", "Z1_CODIGO")
	CONFIRMSX8()
RETURN cProxCod

/*/{Protheus.doc} ProxSequenSZ2
    Gera a proxima sequencia numerica de interacao para um determinado contato.
/*/
USER FUNCTION ProxSequenSZ2(cContato)
	LOCAL cQuery   := ""
	LOCAL cAliasTrb:= GetNextAlias()
	LOCAL cProxSeq := "0001"

	Default cContato := ""

	IF !Empty(cContato)
		cQuery := "SELECT MAX(Z2_SEQUEN) AS MAXSEQ FROM " + RetSqlName("SZ2") + " "
		cQuery += "WHERE Z2_FILIAL = '" + xFilial("SZ2") + "' "
		cQuery += "  AND Z2_CONTAT = '" + cContato + "' "
		cQuery += "  AND D_E_L_E_T_ = ' '"

		dbUseArea(.T., "TOPCONN", TcGenQry(,,cQuery), cAliasTrb, .F., .T.)

		IF !(cAliasTrb)->(Eof()) .AND. !Empty((cAliasTrb)->MAXSEQ)
			cProxSeq := Soma1((cAliasTrb)->MAXSEQ)
		ENDIF

		(cAliasTrb)->(dbCloseArea())
	ENDIF
RETURN cProxSeq

/*/{Protheus.doc} DescTipoInteracao
    Retorna a descricao legivel do tipo de interacao gravado na SX5 (Tabela Z2).
/*/
USER FUNCTION DescTipoInteracao(cTipo)
	LOCAL cDesc := "Nao Identificado"

	Default cTipo := ""

	DO CASE
	CASE cTipo == "E" ; cDesc := "E-mail"
	CASE cTipo == "L" ; cDesc := "Ligacao Telefônica"
	CASE cTipo == "R" ; cDesc := "Reuniao"
	CASE cTipo == "V" ; cDesc := "Visita Comercial"
	CASE cTipo == "W" ; cDesc := "WhatsApp"
	ENDCASE
RETURN cDesc

/*/{Protheus.doc} GRAVARLOG
    Grava o log de erro no disco em arquivo texto local.
/*/
USER FUNCTION GRAVARLOG(cFuncao, oErro)
	LOCAL cFileHand := "sttip_error.log"
	LOCAL nHandle   := 0
	LOCAL cLogMsg   := ""

	Default cFuncao := "DESCONHECIDA"

	cLogMsg := "[" + DToC(dDataBase) + " " + Time() + "] "
	cLogMsg += "Funcao: " + cFuncao + " | "
	IF ValType(oErro) == "O"
		cLogMsg += "Erro: " + oErro:Description + " (Linha: " + cValToChar(oErro:SubLine) + ")"
	ELSE
		cLogMsg += "Erro de Validacao/Regra de Negocio."
	ENDIF
	cLogMsg += CRLF

	IF !File(cFileHand)
		nHandle := fCreate(cFileHand)
	ELSE
		nHandle := fOpen(cFileHand, 2) // Leitura e Escrita
		fSeek(nHandle, 0, 2)           // Vai para o final do arquivo
	ENDIF

	IF nHandle != -1
		fWrite(nHandle, cLogMsg)
		fClose(nHandle)
	ENDIF
RETURN NIL
