#include "protheus.ch"

USER FUNCTION STTZZ1()
    LOCAL cAlias   := "ZZ1"
    LOCAL aColors  := {}
    PRIVATE cCadastro := "Controle de Fornecimento (ISO 9001)"
    PRIVATE aRotina   := {}

    // Acoes do Menu
    AAdd(aRotina, {"Pesquisar",   "AxPesqui",     0, 1})
    AAdd(aRotina, {"Visualizar",  "AxVisual",     0, 2})
    AAdd(aRotina, {"Incluir NC",  "U_STTZZ1INC",  0, 3})
    AAdd(aRotina, {"Alterar",     "AxAltera",     0, 4})
    AAdd(aRotina, {"Excluir",     "U_STTZZ1EXC",  0, 5})
    AAdd(aRotina, {"Ocorrencias", "U_STTZZ2FLT",  0, 6}) // Chama filtro da ZZ2

    // Legendas conforme edital (TCC)
    AAdd(aColors, {"ZZ1->ZZ1_VALCER < dDataBase",      "BR_VERMELHO"}) // Vencido
    AAdd(aColors, {"ZZ1->ZZ1_VALCER <= dDataBase + 30","BR_AMARELO"})  // Vence em 30 dias
    AAdd(aColors, {".T.",                              "BR_VERDE"})    // Demais (OK)

    ChkFile(cAlias)
    dbSelectArea(cAlias)
    dbSetOrder(1) // ZZ1_FILIAL + ZZ1_CODIGO

    mBrowse(6, 1, 22, 75, cAlias, , , , , , aColors)
RETURN NIL

USER FUNCTION STTZZ1INC(cAlias, nReg, nOpc)
    AxInclui(cAlias, nReg, nOpc, , , , "U_STTZZ1SALVAR()")
RETURN NIL

USER FUNCTION STTZZ1SALVAR()
    LOCAL lSucesso := .T.

    IF Empty(M->ZZ1_FORNEC)
        MsgAlert("O fornecedor eh obrigatorio.", "Atencao")
        RETURN .F.
    ENDIF

    BeginTran()
    BEGIN SEQUENCE
        IF RecLock("ZZ1", INCLUI)
            ZZ1->ZZ1_FILIAL := xFilial("ZZ1")
            ZZ1->ZZ1_CODIGO := M->ZZ1_CODIGO
            ZZ1->ZZ1_FORNEC := M->ZZ1_FORNEC
            ZZ1->ZZ1_LOJAFO := M->ZZ1_LOJAFO
            ZZ1->ZZ1_DATA   := M->ZZ1_DATA
            ZZ1->ZZ1_VALCER := M->ZZ1_VALCER
            ZZ1->ZZ1_TOLERA := M->ZZ1_TOLERA
            // Demais campos...
            MsUnLock()
        ELSE
            Break
        ENDIF
        CommitTran()
        MsgInfo("Controle registrado com sucesso!", "Sucesso")

    RECOVER
        RollBackTran()
        MsgStop("Erro ao gravar. Operacao cancelada.", "Erro")
        U_GravarLogTCC("STTZZ1SALVAR", NIL)
        lSucesso := .F.
    END SEQUENCE
RETURN lSucesso

USER FUNCTION STTZZ1EXC(cAlias, nReg, nOpc)
    // Regra Extra: Impedir exclusao se houver ZZ2 vinculada
    IF ExistCpo("ZZ2", xFilial("ZZ2") + ZZ1->ZZ1_CODIGO, 1)
        MsgStop("Exclusao bloqueada: Existem acoes (ZZ2) vinculadas a este registro.", "Bloqueio")
        RETURN .F.
    ENDIF
    AxDeleta(cAlias, nReg, nOpc)
RETURN NIL