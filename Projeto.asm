.model small 
.stack 100h   ; tela do prompt 80 : 25

; ----------------------------------------------------------- ; 
;                       Macros                               ; 
; ---------------------------------------------------------- ; 

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

move_XY macro x,y        ;Macro para pocionar o cursor numa posicao desejada

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
  ; ----------------------------------------------------------- ;

  ;---------------------------------------------;
  ;           Inicial                           ;
  ;---------------------------------------------;

  ; Imagem inicial
  D1            DB   '                              O  O  O$'
  D2            DB   '                                      O$'
  D3            DB   '                                     __|__$'
  D4            DB   '                                     || ||_____$'
  D5            DB   '                                     || ||    |$'
  D6            DB   '                          --------------------------$'
  D7            DB   '                           \   O   O   O   O      /$'
  D8            DB   '                       ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~$'
  D9            DB   '                       _____ _____ _____ _____ __    _____ _____  $'
                D10  DB'                      | __  |  _  |_   _|  _  |  |  |  |  |  _  | $'
                D11  DB'                      | __ -|     | | | |     |  |__|     |     | $'
                D12  DB'                      |_____|__|__| |_| |__|__|_____|__|__|__|__| $'
                D13  DB'                       _____ _____ _____ _____ __  $'
                D14  DB'                      |   | |  _  |  |  |  _  |  | $'
                D15  DB'                      | | | |     |  |  |     |  |__$'
                D16  DB'                      |_|___|__|__|\___/|__|__|_____|$'

  INSERT_COIN   DB   '                         INSERT YOUR COIN - PRESS ENTER $'

  ; fim Imagem inicial

  ; parametro que cria uma linha em branco
  LINHA_L       DB   13,10,'$'


  ;---------------------------------------------;
  ;  Interfaçe Final ]                          ;
  ;---------------------------------------------;




                FIM1 DB'                            _______   __    __________        $'
                FIM2 DB'                           |   ____| |  |  |          |       $'
                FIM3 DB'                           |   |___  |  |  |   |  |   |       $'
                FIM4 DB'                           |   ____| |  |  |   |  |   |       $'
                FIM5 DB'                           |   |     |  |  |   |  |   |       $'
                FIM6 DB'                           |___|     |__|  |___|__|___|       $'


  Agradecimento db   '                         Obrigado por jogar, volte sempre ! $'





  ; parametro de saida do jogo
  PRESS_EXIT    DB   '                                                 PARA SAIR - PRESS G        $'
 PRESS_RULES    DB   '                                                  PARA VER AS REGRAS - PRESS R        $'




.code




  ; ----------------------------------------------------------- ;
  ; Espaço dedicado para o main                                 ;
  ; ----------------------------------------------------------  ;


main proc

                       mov      ax,@data              ; chamando data para AX
                       mov      ds,ax



                       call     limpatela

                       move_XY  1,3                   ; 80 25  ; reposicionar cursor


                       call     tela_inicial
                       move_XY  1,3                   ; 80 25  ; reposicionar cursor
                       call     Vefica_CR


                       mov      ah,4ch
                       int      21h


main endp



  ; ----------------------------------------------------------- ;
  ;                        FINAL DO main                        ;
  ; ----------------------------------------------------------- ;




  ; ----------------------------------------------------------- ;
  ; Espaço dedicado para colocar os procedimentos               ;
  ; ---------------------------------------------------------- ;


  ;---------------------------------------------;
  ;           Procedimentos visuais             ;
  ;---------------------------------------------;

  ; rotina para limpar tela
limpatela proc

 
                       push_all

                       MOV      AH,0
                       MOV      AL,3
                       INT      10H

                       pop_all



                       ret
limpatela endp

  ; Rotina para imprimir uma string
imprimir proc
                       mov      ah, 09h               ; Função DOS para imprimir string
                       int      21h
                       ret
imprimir endp

  ;tela inicial ( imprimir )
tela_inicial proc


  ;Desenho de inicio de jogo
                       MOV      AH,9
                       LEA      DX,D1
                       INT      21H
                       MOV      AH,9
                       LEA      DX,LINHA_L
                       INT      21H
 
                       MOV      AH,9
                       LEA      DX,D2
                       INT      21H
                       MOV      AH,9
                       LEA      DX,LINHA_L
                       INT      21H
 
                       MOV      AH,9
                       LEA      DX,D3
                       INT      21H
                       MOV      AH,9
                       LEA      DX,LINHA_L
                       INT      21H
 
                       MOV      AH,9
                       LEA      DX,D4
                       INT      21H
 
                       MOV      AH,9
                       LEA      DX,LINHA_L
                       INT      21H
 
                       MOV      AH,9
                       LEA      DX,D5
                       INT      21H
 
                       MOV      AH,9
                       LEA      DX,LINHA_L
                       INT      21H
 
                       MOV      AH,9
                       LEA      DX,D6
                       INT      21H
                       MOV      AH,9
                       LEA      DX,LINHA_L
                       INT      21H
 
                       MOV      AH,9
                       LEA      DX,D7
                       INT      21H
                       MOV      AH,9
                       LEA      DX,LINHA_L
                       INT      21H
 
                       MOV      AH,9
                       LEA      DX,D8
                       INT      21H
                       MOV      AH,9
                       LEA      DX,LINHA_L
                       INT      21H
 
                       MOV      AH,9
                       LEA      DX,D8
                       INT      21H
                       MOV      AH,9
                       LEA      DX,LINHA_L
                       INT      21H
 
  ;BARCO
                       MOV      AH,9
                       LEA      DX,D9
                       INT      21H
                       MOV      AH,9
                       LEA      DX,LINHA_L
                       INT      21H
                       MOV      AH,9
                       LEA      DX,D10
                       INT      21H
                       MOV      AH,9
                       LEA      DX,LINHA_L
                       INT      21H
                       MOV      AH,9
                       LEA      DX,D11
                       INT      21H
                       MOV      AH,9
                       LEA      DX,LINHA_L
                       INT      21H
                       MOV      AH,9
                       LEA      DX,D12
                       INT      21H
                       MOV      AH,9
                       LEA      DX,LINHA_L
                       INT      21H
                       MOV      AH,9
                       LEA      DX,D13
                       INT      21H
                       MOV      AH,9
                       LEA      DX,LINHA_L
                       INT      21H
                       MOV      AH,9
                       LEA      DX,D14
                       INT      21H
                       MOV      AH,9
                       LEA      DX,LINHA_L
                       INT      21H
                       MOV      AH,9
                       LEA      DX,D15
                       INT      21H
                       MOV      AH,9
                       LEA      DX,LINHA_L
                       INT      21H
                       MOV      AH,9
                       LEA      DX,D16
                       INT      21H
                       MOV      AH,9
                       LEA      DX,LINHA_L
                       INT      21H
 

                       MOV      AH,9
                       LEA      DX,LINHA_L
                       INT      21H

                       mov      ah,9
                       lea      dx, INSERT_COIN
                       int      21h

                       mov      ah,9
                       lea      dx, PRESS_RULES
                       int      21h


                       mov      ah,9
                       lea      dx, PRESS_EXIT
                       int      21h








                       ret
tela_inicial endp

  ; pede entrada e verifica se é CR
Vefica_CR proc
 
                       MOV      AH, 01h               ; Função para ler entrada de um caractere
  Espera:              
                       INT      21h                   ; Chama interrupção para receber caractere
                       cmp      AL,'g'
                       je       acaba
    
                       CMP      AL, 0Dh               ; Compara se é "CR" (ASCII 13)
                       JZ       limparateladousuario  ; Se for "CR", salta para o fim e sai do procedimento
                       JMP      Espera                ; Caso contrário, continua esperando entrada
    

  acaba:               
                       call     end_game


  limparateladousuario:

                       call     limpatela

                       RET                            ; Sai do procedimento

Vefica_CR endp





  ; ----------------------------------------------------------- ;
  ;                        Fim Procedimentos                    ;
  ; ---------------------------------------------------------- ;



  ; ----------------------------------------------------------- ;
  ;                        FINAL DO JOGO                       ;
  ; ---------------------------------------------------------- ;


end_game proc

                       call     limpatela

                       move_XY  1,9                   ; mover cursor para altura desejada ( começar a imprimir no meio do programa )

  ; todos os mov ah,9 são destinados ao visual do final do programa
                       mov      ah,9
                       lea      dx, LINHA_L
                       int      21h

                       mov      ah,9
                       lea      dx, FIM1
                       int      21h

                       mov      ah,9
                       lea      dx, LINHA_L
                       int      21h

                       mov      ah,9
                       lea      dx,FIM2
                       int      21h

                       mov      ah,9
                       lea      dx, LINHA_L
                       int      21h

                       mov      ah,9
                       lea      dx,FIM3
                       int      21h

                       mov      ah,9
                       lea      dx, LINHA_L
                       int      21h

                       mov      ah,9
                       lea      dx,FIM4
                       int      21h

                       mov      ah,9
                       lea      dx, LINHA_L
                       int      21h

                       mov      ah,9
                       lea      dx,FIM5
                       int      21h

                       mov      ah,9
                       lea      dx, LINHA_L
                       int      21h


                       mov      ah,9
                       lea      dx, FIM6
                       int      21h
     
                       mov      ah,9
                       lea      dx, LINHA_L
                       int      21h

                       mov      ah,9
                       lea      dx, LINHA_L
                       int      21h

                       mov      ah,9
                       lea      dx, LINHA_L
                       int      21h


                       mov      ah,9
                       lea      dx, Agradecimento
                       int      21h

                       move_XY  80,25                 ; mover cursor lá para baixo





                       mov      ah,4ch
                       int      21h

                       ret
end_game endp


end main 