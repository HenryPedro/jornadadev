#include "totvs.ch"

/*/{Protheus.doc} VALCLI001
    Funcao de validacao executada no campo ZA1_CLIENT (X3_VALID).
    Garante a integridade referencial com a tabela de Clientes (SA1).
    @type  Function
    @author Pedro Almeida
    @since 2026-08-04
    @return Logical, .T. se o cliente existe, .F. caso contrario
/*/
USER FUNCTION VALCLI001()
	LOCAL lRet := .T.

	// Se o campo estiver preenchido, valida a existencia na SA1
	IF !Empty(M->ZA1_CLIENT)
		IF !ExistCpo("SA1", xFilial("SA1") + M->ZA1_CLIENT + M->ZA1_LOJA, 1)
			MsgAlert("Cliente nao cadastrado na tabela SA1!", "Atencao - Validacao")
			lRet := .F.
		ENDIF
	ENDIF

RETURN lRet
