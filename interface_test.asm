.model small
.stack 100h

vetor MACRO linha,coluna
    
          mov al,MATRIZ4X4[linha+coluna]    ;  move para al o valor desejado

ENDM







.data              

                ;0 1 2 3 4 5 6 7 8 9
    MATRIZ4X4 DB 1,2,0,0,0,1,0,0,0,0  ; A -0 
              DB 2,2,0,0,0,0,0,0,0,0  ; B - 4 
              DB 2,2,0,0,0,0,0,0,0,0  ; C - 8
              DB 0,0,0,0,0,0,0,0,0,0  ; D 
              DB 0,0,0,0,1,0,0,0,0,0  ; E   
              DB 0,0,0,0,0,0,0,0,0,0  ; F
              DB 0,0,0,0,0,0,0,0,0,0  ; G
              DB 0,0,0,0,0,0,0,0,0,0  ; H
              DB 0,0,0,0,0,0,0,0,0,0  ; I
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
        

    mov cx, 30             ; Total de elementos a serem processados
 

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

conferelinha : 

cmp al, 'A'
je mostra_posição 

add bx,4  ; passar para próxima coluna 

cmp al, 'B'
je mostra_posição 
add bx, 4 ; passar para próxima coluna 


cmp al, 'C'
je mostra_posição 
add bx,4  ; passar para próxima coluna 


cmp al, 'D'
je mostra_posição 
add bx,4  ; passar para próxima coluna 


cmp al, 'E'
je mostra_posição 
add bx,4  ; passar para próxima coluna 


cmp al, 'F'
je mostra_posição 
add bx,4  ; passar para próxima coluna 


cmp al, 'G'
je mostra_posição 
add bx,4  ; passar para próxima coluna 


cmp al, 'H'
je mostra_posição 
add bx,4  ; passar para próxima coluna 


cmp al, 'I'
je mostra_posição 
add bx,4  ; passar para próxima coluna 



cmp al, 'J'
je mostra_posição 
add bx,4  ; passar para próxima coluna 






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