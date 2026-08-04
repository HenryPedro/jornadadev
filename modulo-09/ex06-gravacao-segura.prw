#include "totvs.ch"

/*/{Protheus.doc} STTIP003SALVAR
    Funcao de gravacao transacionada e segura para a tabela SZ1.
    @type  Function
    @author Pedro Almeida 
    @since 2026-08-04
    @return Logical, .T. se gravou com sucesso, .F. caso contrario
/*/
USER FUNCTION STTIP003SALVAR()
	LOCAL lRet := .T.

	// 1. Validacao de Campos Mandatorios
	IF Empty(M->Z1_CLIENTE)
		MsgAlert("O campo Cliente (Z1_CLIENTE) eh de preenchimento obrigatorio!", "Validacao")
		RETURN .F.
	ENDIF

	IF Empty(M->Z1_NOME)
		MsgAlert("O campo Nome do Contato (Z1_NOME) eh de preenchimento obrigatorio!", "Validacao")
		RETURN .F.
	ENDIF

	// 2. Bloco Transacionado Protegido
	BeginTran()

	BEGIN SEQUENCE
		// Bloqueia e grava o registro na SZ1
		IF RecLock("SZ1", INCLUI)
			SZ1->Z1_FILIAL  := xFilial("SZ1")
			SZ1->Z1_CODIGO  := M->Z1_CODIGO
			SZ1->Z1_CLIENTE := M->Z1_CLIENTE
			SZ1->Z1_LOJA    := M->Z1_LOJA
			SZ1->Z1_NOME    := M->Z1_NOME
			SZ1->Z1_CARGO   := M->Z1_CARGO
			SZ1->Z1_EMAIL   := M->Z1_EMAIL
			SZ1->Z1_FONE    := M->Z1_FONE

			MsUnLock()
		ELSE
			// Forca desvio para o RECOVER
			Break()
		ENDIF

		// Confirma a transacao no banco de dados se chegou ate aqui sem falhas
		CommitTran()
		MsgInfo("Contato salvo com sucesso!", "Sucesso")

		RECOVER WITH oErro
		// Em caso de falha, desfaz qualquer alteracao pendente no banco
		RollBackTran()

		MsgStop("Ocorreu uma falha ao salvar o contato. Nenhuma alteracao foi efetuada.", "Erro de Gravação")

		// Grava o arquivo de log local via biblioteca
		U_GRAVARLOG("STTIP003SALVAR", oErro)
		lRet := .F.

	END SEQUENCE

RETURN lRet
