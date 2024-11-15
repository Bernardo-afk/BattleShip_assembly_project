.MODEL SMALL 
.STACK 100h
; macro de pulara 1 linha
clearScreen MACRO
    ; macro para "limpar" a tela 
    PUSH AX
    PUSH DX
    MOV AH,9
    LEA DX,clearScreenString
    INT 21h
    POP DX
    POP AX
ENDM
pulaLinha MACRO
    ; macro para pular uma linha
    PUSH AX
    PUSH DX
        MOV AH,2h
        MOV DL,10
        INT 21h

        MOV DL,13
        INT 21h
    POP DX
    POP AX
ENDM

imprimeString MACRO string
    PUSH AX
    PUSH DX
    MOV AH,9
    LEA DX,string
    INT 21H

    POP DX
    POP AX
ENDM

.DATA
    playerBoard DW 10 DUP( 10 DUP('~'),'$')                          ; tabuleiro do jogador
    cpuBoard DW 10 DUP( 10 DUP('~'),'$')                             ; tabuleiro da CPU que é exibido na tela
    cpuSecret DW 10 DUP( 10 DUP('~'),'$')                            ; tabuleiro da CPU
    boardSpace DB 32,32,32,32,32,32,32,'$'                           ; string de spaços para o reloadScreen
    seed DW 24653                                                    ; Initial seed value (can be changed for different sequences)
    multiplier DW 13849                                              ; Multiplier constant for LCG
    randomNum DB 0                                                   ; Storage for random number between 0 and 9
    playerMap DW ?                                                   ; endereço de memória do mapa selecionado para o player
    cpuMap DW ?                                                      ; endereço de memória do mapa selecionado para a CPU
    maps DW OFFSET map0, OFFSET map1, OFFSET map2, OFFSET map3, OFFSET map4, OFFSET map5, OFFSET map6, OFFSET map7, OFFSET map8, OFFSET map9                                                ; vetor de endereços dos mapas

    missBoatMsg DB 10,13,'ACERTOU AGUA$'
    hitBoatMsg DB 10,13,'ACERTOU UM NAVIO$'
    boatSunken DB 10,13,'UM NAVIO FOI NAUFRAGADO$'
    coordenadaInvalidaMsg DB 10,13,'COORDENADA INVALIDA$'
    playerTurnMsg DB 10,13,'VEZ DO JOGADOR$'
    playerInputMsg DB 10,13,'DIGITE AS COORDENADAS DO SEU ALVO (NUMERO/LETRA): $'
    cpuTurnMsg DB 10,13,'VEZ DA CPU$'
    cpuInputMsg DB 10,13,'COORDENADAS ALVO DA CPU: $'

    delayMsg DB 10,13,'PRESS ENTER TO CONTINUE OR ESC TO EXIT THE GAME$'

    clearScreenString DB 20 DUP(10),13,'$'

    playerBoats DB 4,3,2,2,4,4
    playerBoatsSunken DB 0
    hitBoat DB 1
    cpuBoats DB 4,3,2,2,4,4
    cpuBoatsSunken DB 0
    cpuTarget DB ?,?
    sunkShips DB 0

    victoryString1 DB 10,13, 60 DUP ('~'),'$'
    victoryString2 DB 10,13, 60 DUP ('-'),'$'
    victoryText1 DB 10,13,11 DUP ('.'),' __   _____ ___ _____ ___  _____   __',11 DUP ('.'),'$'
    victoryText2 DB 10,13,11 DUP ('.'),' \ \ / /_ _/ __|_   _/ _ \| _ \ \ / /',11 DUP ('.'),'$'
    victoryText3 DB 10,13,11 DUP ('.'),'  \ V / | | (__  | || (_) |   /\ V / ',11 DUP ('.'),'$'
    victoryText4 DB 10,13,11 DUP ('.'),'   \_/ |___\___| |_| \___/|_|_\ |_|  ',11 DUP ('.'),'$'
    defeatText1 DB 10,13,15 DUP ('.'),'   ___  ___ ___ ___   _ _____ ',15 DUP ('.'),'$'
    defeatText2 DB 10,13,15 DUP ('.'),'  |   \| __| __| __| /_\_   _|',15 DUP ('.'),'$'
    defeatText3 DB 10,13,15 DUP ('.'),'  | |) | _|| _|| _| / _ \| |  ',15 DUP ('.'),'$'
    defeatText4 DB 10,13,15 DUP ('.'),'  |___/|___|_| |___/_/ \_\_|  ',15 DUP ('.'),'$'

    MENU_SCREEN1 DB 10 DUP(10),13,10 DUP(' '),' ___   _ _____ _   _    _  _   _     _  _   ___   ___   _    $'
    MENU_SCREEN2 DB 10,13,10 DUP(' '),'| _ ) /_\_   _/_\ | |  | || | /_\   | \| | /_\ \ / /_\ | |   $'
    MENU_SCREEN3 DB 10,13,10 DUP(' '),'| _ \/ _ \| |/ _ \| |__| __ |/ _ \  | .` |/ _ \ V / _ \| |__ $'
    MENU_SCREEN4 DB 10,13,10 DUP(' '),'|___/_/ \_\_/_/ \_\____|_||_/_/ \_\ |_|\_/_/ \_\_/_/ \_\____|',10 DUP(10),13,'$'
                                                              


    eixoX DW '  ','0','1','2','3','4','5','6','7','8','9','$'
    eixoY DB 'A','B','C','D','E','F','G','H','I','J'

    map0 DW '~','~','~','~','~','~','H','~','~','~'
         DW '~','~','s','~','~','H','H','H','~','~'
         DW '~','~','s','~','~','~','~','~','~','~'
         DW 'h','~','~','~','~','~','~','~','~','~'
         DW 'h','h','~','~','~','F','~','~','~','~'
         DW 'h','~','~','~','~','F','~','~','~','~'
         DW '~','~','~','~','~','F','~','~','~','~'
         DW '~','~','~','~','~','~','~','~','~','~'
         DW '~','~','~','~','~','~','~','~','S','~'
         DW '~','~','E','E','E','E','~','~','S','~' 

    map1 DW '~','~','~','~','~','~','~','~','~','~'
         DW '~','E','E','E','E','~','~','~','~','F'
         DW '~','~','~','~','~','~','~','~','~','F'
         DW '~','~','~','~','~','~','S','~','~','F'
         DW '~','~','~','~','~','~','S','~','~','~'
         DW '~','~','s','s','~','~','~','~','H','~'
         DW '~','~','~','~','~','h','~','H','H','H'
         DW '~','~','~','~','h','h','~','~','~','~'
         DW '~','~','~','~','~','h','~','~','~','~'
         DW '~','~','~','~','~','~','~','~','~','~'
    
    map2 DW '~','~','~','~','~','~','~','~','~','~'
         DW '~','E','~','S','~','~','~','H','~','~'
         DW '~','E','~','S','~','~','H','H','~','~'
         DW '~','E','~','~','~','~','~','H','~','~'
         DW '~','E','~','~','~','~','~','~','~','~'
         DW '~','~','~','~','~','~','~','~','~','~'
         DW '~','~','~','~','~','~','~','~','s','s'
         DW '~','~','~','h','~','~','~','~','~','~'
         DW '~','~','h','h','h','~','~','~','~','~'
         DW '~','~','~','~','~','~','F','F','F','~'
    
    map3 DW 'H','~','~','~','~','~','~','~','~','~'
         DW 'H','H','~','~','~','~','~','~','~','~'
         DW 'H','~','~','F','F','F','~','~','S','~'
         DW '~','~','~','~','~','~','~','~','S','~'
         DW '~','s','~','~','h','~','~','~','~','~'
         DW '~','s','~','h','h','~','~','~','~','~'
         DW '~','~','~','~','h','~','~','~','~','~'
         DW '~','~','~','~','~','~','~','~','~','~'
         DW '~','~','~','E','E','E','E','~','~','~'
         DW '~','~','~','~','~','~','~','~','~','~'
    
    map4 DW '~','~','~','H','~','~','~','~','~','~'
         DW '~','~','H','H','H','~','F','~','~','~'
         DW '~','~','~','~','~','~','F','~','~','~'
         DW 'S','S','~','E','~','~','F','~','~','~'
         DW '~','~','~','E','~','~','~','~','~','~'
         DW '~','~','~','E','~','~','s','s','~','~'
         DW '~','~','~','E','~','~','~','~','~','~'
         DW '~','~','~','E','~','~','~','~','~','~'
         DW '~','~','~','~','~','h','~','~','~','~'
         DW '~','~','~','~','h','h','h','~','~','~'
    
    map5 DW '~','~','~','~','~','~','~','~','~','~'
         DW '~','H','~','~','~','E','E','E','E','~'
         DW '~','H','H','~','~','~','~','~','~','~'
         DW '~','H','~','~','~','~','~','S','~','~'
         DW '~','~','~','~','~','~','~','S','~','~'
         DW '~','~','~','F','F','F','~','~','~','~'
         DW '~','~','~','~','~','~','~','~','h','~'
         DW '~','~','~','~','s','~','~','h','h','~'
         DW '~','~','~','~','s','~','~','~','h','~'
         DW '~','~','~','~','~','~','~','~','~','~'
    
    map6 DW '~','~','~','~','~','~','~','~','~','~'
         DW 'E','~','~','~','H','H','H','~','~','~'
         DW 'E','~','~','~','~','H','~','~','~','~'
         DW 'E','~','~','~','~','~','~','~','~','~'
         DW 'E','~','~','F','~','~','s','s','~','~'
         DW '~','~','~','F','~','~','~','~','~','~'
         DW '~','~','~','F','~','~','~','~','h','~'
         DW 'S','S','~','~','~','~','~','h','h','~'
         DW '~','~','~','~','~','~','~','~','h','~'
         DW '~','~','~','~','~','~','~','~','~','~'
    
    map7 DW '~','~','~','~','~','~','~','~','~','~'
         DW '~','~','~','~','~','~','~','~','H','~'
         DW '~','~','~','~','~','~','~','~','H','~'
         DW '~','~','~','~','F','F','F','~','~','~'
         DW '~','~','E','E','E','E','~','H','H','~'
         DW '~','S','S','~','~','~','~','~','~','~'
         DW '~','~','~','~','~','~','~','~','~','~'
         DW '~','s','s','~','~','~','h','~','~','~'
         DW '~','~','~','~','~','~','h','h','~','~'
         DW '~','~','~','~','~','~','h','~','~','~'
    
    map8 DW '~','~','~','~','~','~','~','~','~','~'
         DW '~','H','H','H','~','~','F','F','F','~'
         DW '~','~','H','~','~','~','~','~','~','~'
         DW '~','~','~','~','h','~','~','~','~','~'
         DW '~','~','~','h','h','h','~','~','~','~'
         DW '~','~','~','~','~','~','~','s','s','~'
         DW '~','S','S','~','~','~','~','~','~','~'
         DW '~','~','~','~','~','~','~','~','~','~'
         DW '~','~','~','~','~','~','~','~','~','~'
         DW '~','~','~','E','E','E','E','~','~','~'
    
    map9 DW '~','~','~','~','~','~','~','~','~','~'
         DW '~','~','E','E','E','E','~','~','~','~'
         DW '~','~','~','~','~','~','~','~','~','~'
         DW 'h','~','~','~','~','~','H','H','H','~'
         DW 'h','h','~','~','~','~','~','H','~','~'
         DW 'h','~','~','~','~','F','~','~','~','~'
         DW '~','~','S','S','~','F','~','~','~','~'
         DW '~','~','~','~','~','F','~','s','s','~'
         DW '~','~','~','~','~','~','~','~','~','~'
         DW '~','~','~','~','~','~','~','~','~','~'
    
.CODE
delay PROC
    ; delay para adicionar um intervalo de espera entre , principalmente as chamadas do procedimento de gerar números aleatórios (randomNumber)
    MOV CX,60000
    DELAY_LOOP:
        MOV CX,CX
        LOOP DELAY_LOOP
    RET
delay ENDP

updateScreen PROC
    ; imprime na tela os tabuleiros (matrizes) do player e da CPU
    ; entrada: PLAYERBOARD, CPUBOARD, BOARDSPACE
    ; saida: void

    pulaLinha

    MOV CX,10
    XOR BX,BX
    XOR DI,DI
    ; o index do eixo x da matriz (numeros)
    MOV AH,9h
    LEA DX,eixoX
    INT 21h
    LEA DX,boardSpace
    INT 21h
    LEA DX,eixoX
    INT 21h
    pulaLinha
    ; for_loop
    REPEAT:
        ; imprime a letra da linha correspondente
        MOV AH,2h
        MOV DL,eixoY[DI]
        INT 21h
        MOV DL,' '
        INT 21h
        ; imprime uma linha da matriz da cpu
        MOV AH,9h
        LEA DX,playerBoard[BX]
        INT 21h
        LEA DX,boardSpace
        INT 21h
        ; imprime a letra da linha correspondente
        MOV AH,2h
        MOV DL,eixoY[DI]
        INT 21h
        MOV DL,' '
        INT 21h
        ; imprime uma linha da matriz do jogador
        MOV AH,9h
        LEA DX,cpuBoard[BX]      
        INT 21h
        pulaLinha
        ADD BX,22
        INC DI
        LOOP REPEAT
    ; end_for
    RET
updateScreen ENDP

randomNumber PROC
    ; Implementa um gerador linear congruente (LCG) para gerar números aleatórios entre 0 e 9
    ; entrada: seed,multiplier,randomNum
    ; saida: randomNum
    CALL delay       ; Chama a função delay para sincronização.
    XOR CX,CX        ; Zera o registrador CX.
    MOV AH,0         ; Configura a função para obter o tempo do sistema (INT 1Ah).
    INT 1ah          ; Obtém o tempo atual do sistema e armazena em DX.
    MOV AX,DX        ; Copia o tempo do sistema para AX.
    XOR DX,DX        ; Zera o registrador DX.
    MOV BX,10        ; Configura o divisor como 10.
    DIV BX           ; Divide AX por BX, o resto (0-9) é armazenado em DL.
    MOV CL,DL        ; Move o número gerado para CL.
    ADD seed,CX      ; Atualiza a semente com o número gerado.
    MOV randomNum,CL ; Armazena o número gerado em randomNum.
    RET              ; Retorna da função.
randomNumber ENDP

generateMaps PROC
    ; Seleciona aleatoriamente os mapas para jogador e CPU a partir de um array de mapas pré-definidos.
    ; entrada: randomNum, cpuMap, playerMap,maps
    ; saida: playerBoard,cpuBoard

    XOR BX,BX
    XOR DX,DX

    ; gera um numero aleatório entre 0-9 e então pega o mapa com o index correpondente no vetor maps e coloca o endereço de memória da matriz do mapa selecionádo em playerMap
    CALL randomNumber
    MOV BL,randomNum
    SHL BX,1
    MOV DX,maps[BX]
    MOV playerMap,DX
    ; gera um numero aleatório entre 0-9 e então pega o mapa com o index correpondente no vetor maps e coloca o endereço de memória da matriz do mapa selecionádo em cpuMap
    CALL randomNumber
    MOV BL,randomNum
    SHL BX,1
    MOV DX,maps[BX]
    MOV cpuMap,DX
    ; copia os mapas selecionados em playerMap e cpuMap nas matrizes playerBoard e cpuSecret
    CALL copyPLAYERMap
    CALL copyCPUMap

    RET
generateMaps ENDP

copyCPUMap PROC
    ;  Copia o mapa selecionado para cpuSecret
    ; endtrada: cpuMap
    ; saida: cpuBoard

    XOR BX,BX
    MOV DI,cpuMap
    XOR SI,SI
    MOV CX,10

    COPIAR:
        
        XOR DX,DX
        XCHG BX,DI
        MOV DX,[BX][SI]
        XCHG DI,BX
        MOV cpuSecret[BX][SI],DX
        ADD SI,2
        CMP SI,20
        JNZ COPIAR

        ADD BX,22
        ADD DI,20
        XOR SI,SI
        LOOP COPIAR

    RET
copyCPUMap ENDP

copyPLAYERMap PROC
    ; Copia o mapa selecionado para a matriz playerBoard
    ; endtrada: playerMap
    ; saida: playerBoard

    XOR BX,BX
    MOV DI,playerMap
    XOR SI,SI
    MOV CX,10

    COPY:
        
        XOR DX,DX
        XCHG BX,DI
        MOV DX,[BX][SI]
        XCHG DI,BX
        MOV playerBoard[BX][SI],DX
        ADD SI,2
        CMP SI,20
        JNZ COPY

        ADD BX,22
        ADD DI,20
        XOR SI,SI
        LOOP COPY

    RET
copyPLAYERMap ENDP

inputPlayerTarget PROC
    ; input das coordenadas do alvo do player 
    ; entrada: playerTurnMsg, playerBoard
    ; saida: DX (DL:x-cordenada DH: y-coordenada)
    MOV AH,9h
    LEA DX,playerTurnMsg
    INT 21h
    DO_WHILE2:
        MOV AH,9h
        LEA DX,playerInputMsg
        INT 21h

        MOV AH,1h
        INT 21h

        SUB AL,30H

        CMP AL,9
        JA COORDENADAINVALIDA

        AND AX,000FH
        SHL AX,1

        MOV DI,AX

        MOV AH,1h
        INT 21h

        SUB AL,'A'

        CMP AL,9
        JA COORDENADAINVALIDA
        
        MOV DL,22
        MUL DL
        MOV BX,AX

        MOV CX,cpuSecret[BX][DI]
        CMP CX,'X'
        JZ DO_WHILE2
        CMP CX,'O'
        JZ DO_WHILE2
        XOR DX,DX
        MOV DX,DI
        MOV DH,BL

    RET

    COORDENADAINVALIDA:
    PUSH AX
    pulaLinha
    MOV AH,9
    LEA DX,coordenadaInvalidaMsg
    INT 21h
    pulaLinha
    POP AX
    JMP DO_WHILE2
inputPlayerTarget ENDP

transferSecrettoBoard PROC
    ; transfere os O e X da matriz cpuSecret para a matriz cpuBoard
    ; entrada: cpuSecret
    ; saida: cpuBoard
    
    PUSH CX
    PUSH AX
    PUSH SI
    PUSH BX

    XOR BX,BX

    NEWLINE:
        MOV CX,10
        XOR SI,SI
    TRANSFER:
        MOV AX,cpuSecret[BX][SI]
        CMP AL,'X'
        JZ SUBSTITUTE
        CMP AL,'O'
        JZ SUBSTITUTE

    CONTINUE_TRANSFER:
        ADD SI,2
        LOOP TRANSFER

        ADD BX,22
        CMP BX,220
        JNZ NEWLINE

        POP BX
        POP SI
        POP AX
        POP CX

        RET

    SUBSTITUTE:
        MOV cpuBoard[BX][SI],AX
        JMP CONTINUE_TRANSFER



    RET

transferSecrettoBoard ENDP    

inputCpuTarget PROC
    ; gera um alvo válido para a cpu
    ; entrada: cpuTurnMsg, randomNum, cpuSecret, cpuTarget
    ; saida: DX (DL:x-cordenada DH: y-coordenada)

    MOV AH,9h
    LEA DX,cpuTurnMsg
    INT 21h
    LEA DX,cpuInputMsg
    INT 21h
    INPUT:
    CALL randomNumber
    MOV AL,randomNum
    MOV cpuTarget[0],AL
    AND AX,000FH
    SHL AX,1
    MOV DI,AX

    CALL randomNumber
    MOV AL,randomNum
    MOV cpuTarget[1],AL
    AND AX,000FH
    MOV BX,22
    MUL BL
    MOV BX,AX


    
    CMP cpuSecret[BX][DI],'O' 
    JZ INPUT

    CMP cpuSecret[BX][DI],'X' 
    JZ INPUT

    MOV AH,2
    MOV DL,cpuTarget[0]
    ADD DL,30h
    INT 21h

    MOV AH,2
    MOV DL,cpuTarget[1]
    ADD DL,65
    INT 21h

    XOR DX,DX
    MOV DX,DI
    MOV DH,BL

    RET
inputCpuTarget ENDP

verifyIftargetHit PROC
    ; entrada: DX (DL:x-cordenada DH: y-coordenada),
    ;          BX OFFSET da matriz a ser lida (player ou cpu),
    ;          SI OFFSET do vetor dos barcos
    ; saida: void encreve na tela se foi acertado algum alvo e atualiza a tela

    XOR CX,CX
    MOV CL,DH
    ADD BX,CX
    AND DX,00FFh
    MOV DI,DX
    MOV AH,9h
    ; switch (input)
    MOV DX,[BX][DI]
    ; case [input] = '~'
        CMP DX,'~'
        JZ MISS
    ; case [input] = 'E'
        CMP DX,'E'
        JNZ CONTINUE1
        DEC BYTE PTR [SI]
        JMP HIT ; break
    CONTINUE1:
    ; case [input] = 'F'
        CMP DX,'F'
        JNZ CONTINUE2
        DEC BYTE PTR [SI+1]
        JMP HIT ; break
    CONTINUE2:
    ; case [input] = 'S'
        CMP DX,'S'
        JNZ CONTINUE3
        DEC BYTE PTR [SI+2]
        JMP HIT ; break
    CONTINUE3:
    ; case [input] = 's'
        CMP DX,'s'
        JNZ CONTINUE4
        DEC BYTE PTR [SI+3]
        JMP HIT ; break
    CONTINUE4:
    ; case [input] = 'H'
        CMP DX,'H'
        JNZ CONTINUE5
        DEC BYTE PTR [SI+4]
        JMP HIT ; break
    CONTINUE5:
    ; case [input] = 'h'
        CMP DX,'h'
        JNZ CONTINUE6
        DEC BYTE PTR [SI+5]
        JMP HIT ; break
    CONTINUE6:
    ; default: coordenadaInválida 
        LEA DX,coordenadaInvalidaMsg
        INT 21h
        pulaLinha
        JMP EXIT5
    ; end_switch

    ; if hit
    HIT:
        MOV DX,'X'
        MOV [BX][DI],DX
        CALL transferSecrettoBoard
        CALL updateScreen
        LEA DX,hitBoatMsg
        INT 21h
        pulaLinha
        JMP EXIT5
    ; else if miss
    MISS:
        MOV DX,'O'
        MOV [BX][DI],DX
        CALL transferSecrettoBoard
        CALL updateScreen
        LEA DX,missBoatMsg
        INT 21h
        DEC BYTE PTR hitBoat
    ; else
    EXIT5:
    RET
verifyIftargetHit ENDP

verifyPlayerSunkships PROC
    ; verifica se todos os návios da PLAYER naufragaram. Se um návio tiver afundado é exibido uma menssagem boatSunken. Se todos os návio tiverem afundado é exibido uma menssagem de derrota e o jogo é terminado
    ; entrada: playerBoats, sunkShips, cplayerBoatsSunken
    ; saida: playerBoatsSunken
    
    PUSH AX
    PUSH SI

    XOR SI,SI

    COMPARE:
        MOV AL,playerBoats[SI]
        CMP AL,0
        JNZ CONTINUA
        INC BYTE PTR sunkShips
    
    CONTINUA:
        CMP BYTE PTR sunkShips,6
        JAE GAMEOVER
        MOV DL,sunkShips
        MOV DH,playerBoatsSunken
        CMP DL,DH
        JNZ PRINTSUNKENBOAT
        CMP SI,5
        JAE ENDING
        
        
        INC SI
        JMP COMPARE

    PRINTSUNKENBOAT:
        INC BYTE PTR playerBoatsSunken
        MOV AH,9
        LEA DX,boatSunken
        INT 21h

    ENDING:
        MOV BYTE PTR sunkShips,0
        POP SI
        POP AX
        RET  

    GAMEOVER:
        clearScreen
        CALL updateScreen
        imprimeString victoryString1
        imprimeString victoryString2
        pulaLinha

        imprimeString defeatText1
        imprimeString defeatText2
        imprimeString defeatText3
        imprimeString defeatText4

        imprimeString victoryString2
        imprimeString victoryString1
        MOV AH,4ch
        INT 21H
    

verifyPlayerSunkships ENDP

verifyCPUSunkships PROC
    ; verifica se todos os návios da CPU naufragaram. Se um návio tiver afundado é exibido uma menssagem boatSunken. Se todos os návio tiverem afundado é exibido uma menssagem de vitória e o jogo é terminado
    ; entrada: cpuBoats, sunkShips, cpuBoatsSunken
    ; saida: cpuBoatsSunken
    
    PUSH AX
    PUSH SI

    XOR SI,SI

    COMPARE_CPU:
        MOV AL,BYTE PTR cpuBoats[SI]
        CMP AL,0
        JNZ CONTINUA_CPU
        INC BYTE PTR sunkShips
    
    CONTINUA_CPU:
        CMP BYTE PTR sunkShips,6
        JAE GAMEOVER_CPU
        MOV DL,sunkShips
        MOV DH,cpuBoatsSunken
        CMP DL,DH
        JNZ PRINTSUNKENBOAT1
        CMP SI,5
        JAE ENDING_CPU
        
        INC SI
        JMP COMPARE_CPU
    PRINTSUNKENBOAT1:
        INC BYTE PTR cpuBoatsSunken
        MOV AH,9
        LEA DX,boatSunken
        INT 21h

    ENDING_CPU:
        MOV BYTE PTR sunkShips,0
        POP SI
        POP AX
        RET 

    GAMEOVER_CPU:
        clearScreen
        CALL updateScreen
        imprimeString victoryString1
        imprimeString victoryString2
        imprimeString victoryText1
        imprimeString victoryText2
        imprimeString victoryText3
        imprimeString victoryText4
        imprimeString victoryString2
        imprimeString victoryString1
        MOV AH,4ch
        INT 21h


verifyCPUSunkships ENDP

continueGame PROC
    ; pausa o jogo e dá a opção do jogador continuar ou sair do jogo
    ; entrada: delayMsg
    ; saida: void
    PRINTF:
    PUSH AX
    PUSH DX
    MOV AH,9
    LEA DX,delayMsg
    INT 21h
    MOV AH,1
    INT 21h
    CMP AL,1Bh
    JNZ EXIT6
    MOV AH,4ch
    INT 21h
    EXIT6: 
    POP DX
    POP AX
    RET
continueGame ENDP

MENU_SCREEN PROC
    ; imprime o menu inicial do jogo
    ; entrada: MENU_SCREEN1,MENU_SCREEN2,MENU_SCREEN3,MENU_SCREEN4
    ; saida: void

    MOV AH,9h
    LEA DX,MENU_SCREEN1
    INT 21h
    LEA DX,MENU_SCREEN2
    INT 21h
    LEA DX,MENU_SCREEN3
    INT 21h
    LEA DX,MENU_SCREEN4
    INT 21h

    CALL continueGame
    clearScreen

    RET
MENU_SCREEN ENDP

MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
; code_overview
    CALL MENU_SCREEN                        ; exibe a tela inicial
    CALL delay
    CALL generateMaps                       ; gera mapas aleatórios para o player e a cpu
    CALL delay
    pulaLinha
    CALL updateScreen                       ; imprime as matrizes na tela
    ;while !(todos os návios do player ou da cpu naufragaram)
    MAIN_LOOP:
        ; while player não errar
        PLAYER_REPEAT:
                CALL inputPlayerTarget      ; input das coordenadas do alvo
                LEA BX,cpuSecret            
                LEA SI,cpuBoats
                clearScreen
                CALL verifyIftargetHit      ; verifica se o player acertou um návio
                CALL verifyCPUSunkships     ; verifica se o player afundou um návio da cpu e se ele afundou todos os návios do player
            MOV CL,hitBoat
            OR CL,CL
            JNZ PLAYER_REPEAT
        ; end_while
            CALL continueGame                ; pausa o jogo e pergunta se o jogador quer continuar ou sair do jogo

            INC BYTE PTR hitBoat             ; reseta o contador dos tiros
            clearScreen
            CALL updateScreen                ; imprime as matrizes na tela
            clearScreen
        ; while cpu não errar
        CPU_REPEAT:
                CALL inputCpuTarget          ; input das coordenadas do alvo da cpu
                LEA BX,playerBoard
                LEA SI,playerBoats
                CALL verifyIftargetHit       ; verifica se a cpu acertou um návio
                CALL verifyPlayerSunkships   ; verifica se a cpu afundou um návio do player e se ele afundou todos os návios do player
                CALL continueGame            ; pausa o jogo e pergunta se o jogador quer continuar ou sair do jogo
            MOV CL,hitBoat
            OR CL,CL
            JNZ CPU_REPEAT
        ; end_while
            clearScreen       
            CALL updateScreen                 ; imprime as matrizes na tela
            INC BYTE PTR hitBoat              ; reseta o contador dos tiros
        JMP PLAYER_REPEAT

    MOV AH,4ch
    INT 21h
MAIN ENDP
END MAIN