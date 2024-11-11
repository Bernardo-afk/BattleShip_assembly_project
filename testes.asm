.model small
.stack 100h

.data
        ; Mensagem de tentativas restantes
        tentativas db 'Tentativas restantes -> $',10,13

        ; Mapa do jogo
        mapa db '    0 1 2 3 4 5 6 7 8 9', 13, 10
             db '    _ _ _ _ _ _ _ _ _ _', 13, 10
             db 'A  |_|_|_|_|_|_|_|_|_|_|', 13, 10
             db 'B  |_|_|_|_|_|_|_|_|_|_|', 13, 10
             db 'C  |_|_|_|_|_|_|_|_|_|_|', 13, 10
             db 'D  |_|_|_|_|_|_|_|_|_|_|', 13, 10
             db 'E  |_|_|_|_|_|_|_|_|_|_|', 13, 10
             db 'F  |_|_|_|_|_|_|_|_|_|_|', 13, 10
             db 'G  |_|_|_|_|_|_|_|_|_|_|', 13, 10
             db 'H  |_|_|_|_|_|_|_|_|_|_|', 13, 10
             db 'I  |_|_|_|_|_|_|_|_|_|_|', 13, 10
             db 'J  |_|_|_|_|_|_|_|_|_|_|', 13, 10
call imprimir_mapa
    call ler_coordenadas

    ; Verificar se acertou alguma embarcação
    call verificar_acerto
    
    ; Atualizar o mapa com a coordenada fornecida
    call atualizar_mapa

    jmp loop_inicio

fim_programa:
    ; Sair do programa
    mov ah, 4Ch
    int 21h

; Função para imprimir o mapa
imprimir_mapa:
    mov ah, 09h
    lea dx, mapa
    int 21h
    ret

; Função para ler as coordenadas do usuário
ler_coordenadas:
    ; Ler a letra (A-J) da linha
    mov ah, 01h
    int 21h

    cmp al, 'q'
    je fim
    cmp al, 'Q'
    je fim

    sub al, 'A'           ; Converte para índice (0-9)

    ; Armazenar no registrador BL a linha (0-9)
    mov bl, al

    ; Ler o número (0-9) da coluna
    mov ah, 01h
    int 21h
    sub al, '0'           ; Converte para índice (0-9)

    ; Armazenar no registrador BH a coluna (0-9)
    mov bh, al

    fim:
    ret

; Função para verificar se acertou alguma embarcação
verificar_acerto:
    ; Usa registradores BL e BH para armazenar linha e coluna fornecidas
    mov al, bl       ; Linha em al (0-9)
    mov ah, bh       ; Coluna em ah (0-9)

    ; Checar no encouraçado
    lea si, encouracado
    mov cx, 4        ; 4 partes do encouraçado
loop_encouraçado:
    cmp al, [si]     ; Compara linha
    jne prox_verificacao_enc
    cmp ah, [si + 1]   ; Compara coluna
    jne prox_verificacao_enc

    ; Se acertar, marca o ponto como atingido e exibe "Acertou uma parte!"
    call mensagem_acerto
    mov byte ptr [si], -1   ; Marca posição atingida
    mov byte ptr [si + 1], -1 ; Marca posição atingida
    jmp fim_verificar

prox_verificacao_enc:
    add si, 2        ; Move para a próxima coordenada
    loop loop_encouraçado

    ; Repetir lógica acima para fragata, submarinos, hidroaviões

    ; Caso não acerte nenhuma posição
    call mensagem_agua

fim_verificar:
    ret

; Mensagem para acerto de parte da embarcação
mensagem_acerto:
    mov ah, 09h
    lea dx, msg_acerto
    int 21h
    ret

; Mensagem para acerto da água (erro)
mensagem_agua:
    mov ah, 09h
    lea dx, msg_agua
    int 21h
    ret

; Função para atualizar o mapa com um 'X' quando o usuário acerta uma posição
atualizar_mapa:
    ; Calcular o deslocamento da linha: cada linha ocupa 24 caracteres no total
    mov al, bl            ; Linha (0-9) está em BL
    mov ah, 0             ; Limpar AH para multiplicação
    mov cx, 24            ; Cada linha ocupa 24 caracteres
    mul cx                ; Multiplica a linha pelo tamanho total da linha, resultado em AX

    ; Adicionar a posição base da linha para a primeira coluna
    add ax, 54             ; Começar na posição [2,2] para a primeira célula em cada linha

    ; Ajuste adicional para cada nova linha, incrementando em 2 sucessivamente
    mov cl, bl            ; Copia o valor de bl para cl
    shl cl, 1             ; Multiplica cl por 2 para incrementos de 2, 4, 6, etc.
    add ax, cx            ; Incrementa o deslocamento da linha em múltiplos de 2

    ; Calcular o deslocamento da coluna: cada coluna se move duas posições para a direita
    mov cl, bh            ; Coluna (0-9) está em BH
    shl cl, 1             ; Multiplica coluna por 2 (salto de 2 caracteres por coluna)
    add ax, cx            ; Soma o deslocamento da coluna ao endereço

    ; Calcular o endereço final no mapa
    lea si, mapa          ; Carrega o endereço base do mapa em SI
    add si, ax            ; Soma o índice calculado em AX ao endereço base

    ; Substituir o caractere no mapa por 'X' (marcando a posição)
    mov byte ptr [si], 'X'
    ret

end main