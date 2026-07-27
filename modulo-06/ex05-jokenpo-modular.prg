Function Main()
    Local cJogadaUser, cJogadaCPU, cResultado
    Local cContinuar := "S"

    Cls
    Do While Upper(cContinuar) == "S"
        Cls
        QOut("==========================================")
        QOut("            JOKENPÔ MODULAR               ")
        QOut("==========================================")
        QOut("Opções: [P]edra | P[A]pel | [T]esoura")
        
        Accept "Sua jogada: " To cJogadaUser
        cJogadaUser := Upper(AllTrim(cJogadaUser))

        If .NOT. ValidarJogada(cJogadaUser)
            QOut("Jogada inválida! Tente P, A ou T.")
            Inkey(2)
            Loop
        EndIf

        cJogadaCPU := SortearJogadaCPU()
        cResultado := DefinirVencedor(cJogadaUser, cJogadaCPU)

        QOut("")
        QOut("Você jogou : " + ExibirNomeJogada(cJogadaUser))
        QOut("CPU jogou  : " + ExibirNomeJogada(cJogadaCPU))
        QOut("Resultado  : " + cResultado)
        QOut("==========================================")
        
        Accept "Deseja jogar novamente? (S/N): " To cContinuar
    EndDo
Return Nil

Function SortearJogadaCPU()
    Local nSorteio := hb_RandomInt(1, 3)
    Local cJogada  := ""

    Do Case
        Case nSorteio == 1 ; cJogada := "P"
        Case nSorteio == 2 ; cJogada := "A"
        Case nSorteio == 3 ; cJogada := "T"
    EndCase
Return cJogada

Function ValidarJogada(cJogada)
    // Usando "PAT" sem barras para evitar que '|' seja aceito como jogada
Return (cJogada $ "PAT") .AND. Len(cJogada) == 1

Function DefinirVencedor(cJ1, cJ2)
    If cJ1 == cJ2
        Return "EMPATE!"
    EndIf

    If (cJ1 == "P" .AND. cJ2 == "T") .OR. ;
       (cJ1 == "A" .AND. cJ2 == "P") .OR. ;
       (cJ1 == "T" .AND. cJ2 == "A")
        Return "VOCÊ VENCEU!"
    EndIf
Return "CPU VENCEU!"

Function ExibirNomeJogada(cSigla)
    Do Case
        Case cSigla == "P" ; Return "Pedra"
        Case cSigla == "A" ; Return "Papel"
        Case cSigla == "T" ; Return "Tesoura"
    EndCase
Return ""