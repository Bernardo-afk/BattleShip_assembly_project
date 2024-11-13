
.model small 
Push_all macro      ; Macro para push em todos os registradores
           push ax
           push BX
           push cx
           push Dx
           push si
           push di
endm

pop_all macro     ; Macro para pop em todos os registradores
          pop di
          pop si
          pop dx
          pop cx
          pop bx
          pop ax
endm

.data 



       mapa  db '|_|_|_|_|_|_|_|_|_|_|', 13, 10    ; si -2 = '_'   si -4 = '_ ' ...
             db '|_|_|_|_|_|_|_|_|_|_|', 13, 10
             db '|_|_|_|_|_|_|_|_|_|_|', 13, 10
             db '|_|_|_|_|_|_|_|_|_|_|', 13, 10
             db '|_|_|_|_|_|_|_|_|_|_|', 13, 10
             db '|_|_|_|_|_|_|_|_|_|_|', 13, 10
             db '|_|_|_|_|_|_|_|_|_|_|', 13, 10
             db '|_|_|_|_|_|_|_|_|_|_|', 13, 10
             db '|_|_|_|_|_|_|_|_|_|_|', 13, 10
             db '|_|_|_|_|_|_|_|_|_|_|', 13, 10
             db '$'




             variavel_soma db 0 

             variavel_de_letra db 41h  ; TIPO DB = 8 bits 41h = 'A'

            pedesi db 10,13, 'Digite si : $'

            pedecoluna db 10,13, 'Digite a coluna : $ '

Errou_tiro db 'EREROU $'
Acertou_tiro db 'Ace $'

  ;---------------------------------------------;
  ;  Nivel EASY                                 ;
  ;---------------------------------------------;


                ;0 1 2 3 4 5 6 7 8 9
  MATRIZEASY  DB 1,1,1,1,0,0,0,0,0,0  ; A -0 ; encouraçado 
              DB 0,0,0,0,0,1,1,1,0,0  ; B - 10  ;fragata 
              DB 0,1,1,0,0,0,0,0,0,0  ; C - 20   ; submarino 
              DB 0,0,0,0,0,0,0,0,0,0  ; D 
              DB 0,0,0,1,1,0,0,0,0,0  ; E   ; submarino
              DB 0,0,0,0,0,0,0,1,0,0  ; F
              DB 0,1,0,0,0,0,1,1,0,0  ; G; hidro 
              DB 0,1,1,0,0,0,0,1,0,0  ; H ; hidro 
              DB 0,1,0,0,0,0,0,0,0,0  ; I
              DB 0,0,0,0,0,0,0,0,0,1  ; J






.code  

main proc  


mov ax,@data 
mov ds ,ax 




call GAME_INTERFACE_EASY







fim : 
mov ah,4ch 
int 21h 

main endp 

limpatela proc 


push_all
                      MOV      AH,0
                       MOV      AL,3
                       INT      10H
pop_all

ret 

limpatela endp 


imprimir_mapa proc 



mov ah,9 
lea dx, mapa 
int 21h 
ret 
imprimir_mapa endp 






visual_errou proc 


lea bx,mapa 
;add bx,1  ; primeira posição da primeira linha 
;add bx,24 ;  primeira posição da segunda linha 
;add bx,47   ; primeira posição da terceira linha 


add bx,si     ; adds para pegar a posição na linha 
add bx,si



add bx,1 ; passar para posição do quadradinho 
add bl,variavel_soma

mov byte ptr [bx], 'O'

call limpatela
call imprimir_mapa







ret 
visual_errou endp 


visual_acertou proc 


lea bx,mapa 
;add bx,1  ; primeira posição da primeira linha 
;add bx,24 ;  primeira posição da segunda linha 
;add bx,47   ; primeira posição da terceira linha 


add bx,si     ; adds para pegar a posição na linha 
add bx,si



add bx,1 ; passar para posição do quadradinho 
add bl,variavel_soma

mov byte ptr [bx], 'X'

call limpatela
call imprimir_mapa


ret 
visual_acertou endp 



end main 
