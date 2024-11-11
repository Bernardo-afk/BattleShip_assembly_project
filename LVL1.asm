.model small
.stack 100h








.data              

                ;0 1 2 3 4 5 6 7 8 9
    MATRIZ4X4 DB 1,1,1,1,0,0,0,0,0,0  ; A -0 ; encouraçado 
              DB 0,0,0,0,0,1,1,1,0,0  ; B - 10  ;fragata 
              DB 0,1,1,0,0,0,0,0,0,0  ; C - 20   ; submarino 
              DB 0,0,0,0,0,0,0,0,0,0  ; D 
              DB 0,0,0,1,1,0,0,0,0,0  ; E   ; submarino
              DB 0,0,0,0,0,0,0,1,0,0  ; F
              DB 0,1,0,0,0,0,1,1,0,0  ; G; hidro 
              DB 0,1,1,0,0,0,0,1,0,0  ; H ; hidro 
              DB 0,1,0,0,0,0,0,0,0,0  ; I
              DB 0,0,0,0,0,0,0,0,0,0  ; J

; si = linha, bx = coluna

linha db 10,13, 'digite a linha da matriz (0-9) : $'
coluna db 10,13, 'digite a coluna da matriz (A-J) : $'

acerto db 10,13, ' Acertou seu merda $'
erroufeio db 10,13, 'Errou seu merda $' 

.code



main proc
    mov ax, @data
    mov ds, ax



    call processo




    mov ah, 4Ch
    int 21h
main endp


processo proc


        ;  CX definido pelo nivel 
        

    mov cl, 30             ; Total de elementos a serem processados
 

l1:

    xor si, si               ; si = linha
    xor bx, bx               ; bx = coluna

; colocar proc de limpa tela 


mov ah,9 
lea dx, linha 
int 21h 

mov ah,1 
int 21h    ; pegar linha 
and ax,0FH
mov si,ax   ; salvando primeira posição 

;; salvo correto 


mov ah,9 
lea dx, coluna  ; A-J
int 21h 


mov ah,1
int 21h    ; pegar linha 

call matrizleitura 

    loop l1


fim: 


    ret
processo endp



matrizleitura proc 


add ch, 41h




conferelinha : 

cmp al, ch ; comparar a letra digitada com cl ( para identificar a coordenada ) 
je mostra_posição 
add bx,10  ; passar para próxima coluna 
add ch,1

jmp conferelinha 







mostra_posição:


     mov al,MATRIZ4X4[si+bx]    ;  move para al o valor desejado

    
    cmp al,2
    je acertou  

jmp errou  

    acertou: 
    mov ah,9 
    lea dx,acerto         
    int 21h 

jmp fim 


    errou : 
    mov ah,9 
    lea dx,erroufeio 
    int 21h

ret 

matrizleitura endp 


end main