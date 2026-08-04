#include "totvs.ch"

/*/{Protheus.doc} STTIP001
    Rotina de CRUD simples utilizando AxCadastro para a tabela ZA1 (Pets).
    @type  Function
    @author Pedro Almeida
    @since 2026-08-04
/*/
USER FUNCTION STTIP001()
	PRIVATE cCadastro := "Cadastro de Pets"

	// Seleciona a tabela no contexto de dados
	dbSelectArea("ZA1")
	dbSetOrder(1) // ZA1_FILIAL + ZA1_COD

	// Chamada do cadastro automatico simplificado
	AxCadastro("ZA1", cCadastro, "1", .F.)

RETURN NIL
