.MODEL SMALL
.STACK 100H
.DATA
    ; Definindo o vetor com valores de 30 a 1 como palavras (16 bits)
    vetor db '1','2'

.CODE
MAIN PROC
    MOV AX, @DATA      ; Inicializa o segmento de dados
    MOV DS, AX

   

mov cx,2
   nc: 

   mov ah,2
   mov dl,vetor[bx]
   int 21h 

    loop nc


mov ah,4ch
int 21h



MAIN ENDP
END MAIN
