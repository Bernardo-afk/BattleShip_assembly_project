.model small 
.stack 100h   ; tela do prompt 80 : 25

; ----------------------------------------------------------- ; 
;                       Macros                               ; 
; ---------------------------------------------------------- ; 

Push_all macro                  ; Macro para push em todos os registradores
             push ax
             push BX
             push cx
             push Dx
             push si
             push di
endm

pop_all macro               ; Macro para pop em todos os registradores 
            pop di
            pop si
            pop dx
            pop cx
            pop bx
            pop ax
endm

move_XY macro x,y            ;Macro para pocionar o cursor numa posicao desejada

            push_all

            mov      ah,2
            mov      dh,y
            mov      dl,x
            int      10h

            pop_all
endm


; ----------------------------------------------------------- ; 
;                   Fim Macros                               ; 
; ---------------------------------------------------------- ; 






.data 
; ----------------------------------------------------------- ; 
;                       Interface                             ; 
; ---------------------------------------------------------- ; 

   ;---------------------------------------------;
   ;           Inicial                           ;
  ;---------------------------------------------;



.code 

main proc 




call limpatela 




mov ah,4ch
int 21h


main endp 

; ----------------------------------------------------------- ; 
; Espaço dedicado para colocar os procedimentos               ; 
; ---------------------------------------------------------- ; 


            ;---------------------------------------------;
            ;           Procedimentos visuais             ;
            ;---------------------------------------------;


            limpatela proc 

 
                            push_all

                            MOV              AH,0
                            MOV              AL,3
                            INT              10H

                            pop_all

                            ret
            limpatela endp 


; Rotina para imprimir uma string
imprimir proc
            mov ah, 09h  ; Função DOS para imprimir string
            int 21h
            ret
imprimir endp










; ----------------------------------------------------------- ; 
;                        Fim Procedimentos                    ; 
; ---------------------------------------------------------- ; 



end main 