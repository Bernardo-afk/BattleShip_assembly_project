.model small 
.stack 100h   ; tela do prompt 80 : 25





; ; falta implementar sistema de falar quantas tentativas falta / verificar se está certo o numero de tentativas em cada um 
; fazer as regras ; e tela que perdeu o jogo 
; falta zerar TUDO/ voltar ao valor original quando reinicia o programa 
; fazer formulario com as regras do jogi 
; fazer regras com o tamanho dos navios 



; ------1----------------------------------------------------- ; 
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
  D1                      DB   '                              O  O  O$'
  D2                      DB   '                                      O$'
  D3                      DB   '                                     __|__$'
  D4                      DB   '                                     || ||_____$'
  D5                      DB   '                                     || ||    |$'
  D6                      DB   '                          --------------------------$'
  D7                      DB   '                           \   O   O   O   O      /$'
  D8                      DB   '                       ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~$'
  D9                      DB   '                       _____ _____ _____ _____ __    _____ _____  $'
                          D10  DB'                      | __  |  _  |_   _|  _  |  |  |  |  |  _  | $'
                          D11  DB'                      | __ -|     | | | |     |  |__|     |     | $'
                          D12  DB'                      |_____|__|__| |_| |__|__|_____|__|__|__|__| $'
                          D13  DB'                       _____ _____ _____ _____ __  $'
                          D14  DB'                      |   | |  _  |  |  |  _  |  | $'
                          D15  DB'                      | | | |     |  |  |     |  |__$'
                          D16  DB'                      |_|___|__|__|\___/|__|__|_____|$'

  INSERT_COIN             DB   '                         INSERT YOUR COIN - PRESS ENTER $'


  ; fim Imagem inicial

  ; parametro que cria uma linha em branco
  LINHA_L                 DB   13,10,'$'

  Ask_linha               db   10,13, 'digite a linha da matriz (0-9) : $'
  Ask_coluna              db   10,13, 'digite a coluna da matriz (A-J) : $'

  Acertou_tiro            db   10,13, ' Acertou seu merda $'
  Errou_tiro              db   10,13, 'Errou seu merda $'

  ;---------------------------------------------;
  ;  Campo do jogo                             ;
  ;---------------------------------------------;

  ; Mapa do jogo
  ;   ll1   db '    0 1 2 3 4 5 6 7 8 9', 13, 10
  ;  ll2   db ' _ _ _ _ _ _ _ _ _ _', 13, 10




  mapa                    db   '|_|_|_|_|_|_|_|_|_|_| A', 13, 10                                                      ; si -2 = '_'   si -4 = '_ ' ...
                          db   '|_|_|_|_|_|_|_|_|_|_| B', 13, 10
                          db   '|_|_|_|_|_|_|_|_|_|_| C', 13, 10
                          db   '|_|_|_|_|_|_|_|_|_|_| D', 13, 10
                          db   '|_|_|_|_|_|_|_|_|_|_| E', 13, 10
                          db   '|_|_|_|_|_|_|_|_|_|_| F', 13, 10
                          db   '|_|_|_|_|_|_|_|_|_|_| G', 13, 10
                          db   '|_|_|_|_|_|_|_|_|_|_| H', 13, 10
                          db   '|_|_|_|_|_|_|_|_|_|_| I', 13, 10
                          db   '|_|_|_|_|_|_|_|_|_|_| J', 13
                          db   '$'

  underline               db   10,13, '_____________________$'
   
  variavel_de_soma_coluna db   0
  variavel_de_letra       db   41h                                                                                    ; iniciar variavel com a letra 'A' ( para comparação futura )
 

  next_try                db   10,13 ,'PRESS ENTER TO NEXT TRY $'

  sair_em_qualquer_momento db 10,13, 'PRESS X to exit$'



  numeros_linha           db   ' 0 1 2 3 4 5 6 7 8 9 $'

  contadoreasy      db '30', '29', '28', '27', '26', '25', '24', '23', '22', '21', '20', '19', '18', '17', '16', '15', '14', '13', '12', '11', '10', '9', '8', '7', '6', '5', '4', '3', '2', '1'

  contadormedium db '25', '24', '23', '22', '21', '20', '19', '18', '17', '16', '15', '14', '13', '12', '11', '10', '9', '8', '7', '6', '5', '4', '3', '2', '1', '0'

  contadorhard db '20', '19', '18', '17', '16', '15', '14', '13', '12', '11', '10', '9', '8', '7', '6', '5', '4', '3', '2', '1', '0'

  contadoruncrumble db '15', '14', '13', '12', '11', '10', '9', '8', '7', '6', '5', '4', '3', '2', '1', '0'

  contador_saber_se_venceu db 19

  remaining_chances db 10,13, 'You have $'
  more_chances db ' more chances $'

  ;---------------------------------------------;
  ;  Nivel EASY                                 ;
  ;---------------------------------------------;


  ;0 1 2 3 4 5 6 7 8 9
  MATRIZEASY              DB   1,1,1,1,0,0,0,0,0,0                                                                    ; A -0 ; encouraçado
                          DB   0,0,0,0,0,1,1,1,0,0                                                                    ; B - 10  ;fragata
                          DB   0,1,1,0,0,0,0,0,0,0                                                                    ; C - 20   ; submarino
                          DB   0,0,0,0,0,0,0,0,0,0                                                                    ; D
                          DB   0,0,0,1,1,0,0,0,0,0                                                                    ; E   ; submarino
                          DB   0,0,0,0,0,0,0,0,0,0                                                                    ; F
                          DB   0,1,0,0,0,0,0,1,0,0                                                                    ; G; hidro
                          DB   0,1,1,0,0,0,1,1,0,0                                                                    ; H ; hidro
                          DB   0,1,0,0,0,0,0,1,0,0                                                                    ; I
                          DB   0,0,0,0,0,0,0,0,0,0                                                                    ; J

  ; si = linha, bx = coluna





  ;---------------------------------------------;
  ;  Nivel MEDIUM                               ;
  ;---------------------------------------------;


  ;0 1 2 3 4 5 6 7 8 9
  MATRIZMEDIUM            DB   1,1,1,1,0,0,0,0,0,0                                                                    ; A -0 ; encouraçado
                          DB   0,0,0,0,0,1,1,1,0,0                                                                    ; B - 10  ;fragata
                          DB   0,1,1,0,0,0,0,0,0,0                                                                    ; C - 20   ; submarino
                          DB   0,0,0,0,0,0,0,0,0,0                                                                    ; D
                          DB   0,0,0,1,1,0,0,0,0,0                                                                    ; E   ; submarino
                          DB   0,0,0,0,0,0,0,0,0,0                                                                    ; F
                          DB   0,1,0,0,0,0,0,1,0,0                                                                    ; G; hidro
                          DB   0,1,1,0,0,0,1,1,0,0                                                                    ; H ; hidro
                          DB   0,1,0,0,0,0,0,1,0,0                                                                    ; I
                          DB   0,0,0,0,0,0,0,0,0,0                                                                    ; J

  ; si = linha, bx = coluna





  ;---------------------------------------------;
  ;  Nivel HARD                               ;
  ;---------------------------------------------;


 

  ;0 1 2 3 4 5 6 7 8 9
  MATRIZHARD              DB   1,1,1,1,0,0,0,0,0,0                                                                    ; A -0 ; encouraçado
                          DB   0,0,0,0,0,1,1,1,0,0                                                                    ; B - 10  ;fragata
                          DB   0,1,1,0,0,0,0,0,0,0                                                                    ; C - 20   ; submarino
                          DB   0,0,0,0,0,0,0,0,0,0                                                                    ; D
                          DB   0,0,0,1,1,0,0,0,0,0                                                                    ; E   ; submarino
                          DB   0,0,0,0,0,0,0,0,0,0                                                                    ; F
                          DB   0,1,0,0,0,0,0,1,0,0                                                                    ; G; hidro
                          DB   0,1,1,0,0,0,1,1,0,0                                                                    ; H ; hidro
                          DB   0,1,0,0,0,0,0,1,0,0                                                                    ; I
                          DB   0,0,0,0,0,0,0,0,0,0                                                                    ; J

  ; si = linha, bx = coluna


  ; ---------------------------------------------;
  ;  Nivel UNCRUMBLE                               ;
  ;---------------------------------------------;



  ;0 1 2 3 4 5 6 7 8 9
  MATRIZUNCRUMBLE         DB   1,1,1,1,0,0,0,0,0,0                                                                    ; A -0 ; encouraçado
                          DB   0,0,0,0,0,1,1,1,0,0                                                                    ; B - 10  ;fragata
                          DB   0,1,1,0,0,0,0,0,0,0                                                                    ; C - 20   ; submarino
                          DB   0,0,0,0,0,0,0,0,0,0                                                                    ; D
                          DB   0,0,0,1,1,0,0,0,0,0                                                                    ; E   ; submarino
                          DB   0,0,0,0,0,0,0,0,0,0                                                                    ; F
                          DB   0,1,0,0,0,0,0,1,0,0                                                                    ; G; hidro
                          DB   0,1,1,0,0,0,1,1,0,0                                                                    ; H ; hidro
                          DB   0,1,0,0,0,0,0,1,0,0                                                                    ; I
                          DB   0,0,0,0,0,0,0,0,0,0                                                                    ; J

  ; si = linha, bx = coluna









  ;---------------------------------------------;
  ;  Interfaçe Final ]                          ;
  ;---------------------------------------------;




                          FIM1 DB'                            _______   __    __________        $'
                          FIM2 DB'                           |   ____| |  |  |          |       $'
                          FIM3 DB'                           |   |___  |  |  |   |  |   |       $'
                          FIM4 DB'                           |   ____| |  |  |   |  |   |       $'
                          FIM5 DB'                           |   |     |  |  |   |  |   |       $'
                          FIM6 DB'                           |___|     |__|  |___|__|___|       $'


  Agradecimento           db   '                         Obrigado por jogar, volte sempre ! $'

  Agradecimento2           db   '                         Parabens por vencer o jogar, volte sempre ! $'

  TAKE_TIME               db   '                                                   PRESS G TO EXIT     $'

  INSERT_ANOTHER_COIN     DB   '                                                INSERT ANOTHER COIN - PRESS ENTER $'


  ; parametro de saida do jogo
  PRESS_EXIT              DB   '                                                 EXIT GAME - PRESS G        $'
  PRESS_RULES             DB   '                                                  SHOW THE RULES - PRESS R        $'


  ; Regras

  REGRA1                  db   '              1 -           $'
  REGRA2                  db   '              2 -           $'
  REGRA3                  db   '              3 -           $'
  REGRA4                  db   '              4 -           $'
  REGRA5                  db   '              5 -           $'
  REGRA6                  db   '              6 -           $'



  ; niveis

  Select_level            db   '                          Select The Level  $'
  NIVEL1                  db   '                          1 - Easy          $'
  NIVEL2                  db   '                          2 - Medium        $'
  NIVEL3                  db   '                          3 - Hard          $'
  NIVEL4                  db   '                          4 - Uncrumble mode$'
 







.code

  ; ----------------------------------------------------------- ;
  ; Espaço dedicado para o main                                 ;
  ; ----------------------------------------------------------  ;


main proc

                           mov      ax,@data                    ; chamando data para AX
                           mov      ds,ax





  reinicia:                

                           call     limpatela

                           move_XY  1,3                         ; 80 25  ; reposicionar cursor


                     
                           call     tela_inicial
                           move_XY  1,3                         ; 80 25  ; reposicionar cursor

                           call     Vefica_CR_RULES

                           call     Level_select



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
                           mov      ah, 09h                     ; Função DOS para imprimir string
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
Vefica_CR_RULES proc
 
                           MOV      AH, 01h                     ; Função para ler entrada de um caractere
  Espera:                  
                           INT      21h                         ; Chama interrupção para receber caractere
                           cmp      AL,'g'
                           je       acaba
    
                           cmp      AL,'r'
                           je       regra
    


                           CMP      AL, 0Dh                     ; Compara se é "CR" (ASCII 13)
                           JZ       limparateladousuario        ; Se for "CR", salta para o fim e sai do procedimento
                           JMP      Espera                      ; Caso contrário, continua esperando entrada
    

  acaba:                   
                           call     end_game
    

  regra:                   
                           call     RULES

                           jmp      skipverifycr

  limparateladousuario:    

                           call     limpatela


  skipverifycr:            


                           RET                                  ; Sai do procedimento

Vefica_CR_RULES endp


RULES proc

                           call     limpatela

                           move_XY  1,4

  ; MOSTRAR AS REGRAS
                           mov      ah,9
                           lea      dx, LINHA_L
                           int      21h

                           mov      ah,9
                           lea      dx, REGRA1
                           int      21h

                           mov      ah,9
                           lea      dx, LINHA_L
                           int      21h


                           mov      ah,9
                           lea      dx, LINHA_L
                           int      21h


                           mov      ah,9
                           lea      dx,REGRA2
                           int      21h

                           mov      ah,9
                           lea      dx, LINHA_L
                           int      21h


                           mov      ah,9
                           lea      dx, LINHA_L
                           int      21h

                           mov      ah,9
                           lea      dx,REGRA3
                           int      21h

                           mov      ah,9
                           lea      dx, LINHA_L
                           int      21h


                           mov      ah,9
                           lea      dx, LINHA_L
                           int      21h

                           mov      ah,9
                           lea      dx,REGRA4
                           int      21h

                           mov      ah,9
                           lea      dx, LINHA_L
                           int      21h


                           mov      ah,9
                           lea      dx, LINHA_L
                           int      21h

                           mov      ah,9
                           lea      dx,REGRA5
                           int      21h

                           mov      ah,9
                           lea      dx, LINHA_L
                           int      21h


                           mov      ah,9
                           lea      dx, LINHA_L
                           int      21h



                           mov      ah,9
                           lea      dx, REGRA6
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
                           lea      dx, INSERT_COIN
                           int      21h

                           mov      ah,9
                           lea      dx, PRESS_EXIT
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
                           lea      dx, LINHA_L
                           int      21h

                           call     Vefica_CR_RULES

                           ret

RULES endp

Level_select proc

                           call     limpatela



                           call     limpatela

                           move_XY  25,6

  ; MOSTRAR AS REGRAS

                           mov      ah,9
                           lea      dx, LINHA_L
                           int      21h

                           mov      ah,9
                           lea      dx, Select_level
                           int      21h

                           mov      ah,9
                           lea      dx, LINHA_L
                           int      21h


                           mov      ah,9
                           lea      dx, LINHA_L
                           int      21h


                           mov      ah,9
                           lea      dx,NIVEL1
                           int      21h

                           mov      ah,9
                           lea      dx, LINHA_L
                           int      21h


                           mov      ah,9
                           lea      dx, LINHA_L
                           int      21h

                           mov      ah,9
                           lea      dx,NIVEL2
                           int      21h

                           mov      ah,9
                           lea      dx, LINHA_L
                           int      21h


                           mov      ah,9
                           lea      dx, LINHA_L
                           int      21h

                           mov      ah,9
                           lea      dx,NIVEL3
                           int      21h

                           mov      ah,9
                           lea      dx, LINHA_L
                           int      21h


                           mov      ah,9
                           lea      dx, LINHA_L
                           int      21h

                           mov      ah,9
                           lea      dx,NIVEL4
                           int      21h

                           mov      ah,9
                           lea      dx, LINHA_L
                           int      21h


                           mov      ah,9
                           lea      dx, LINHA_L
                           int      21h


                           mov      ah,1
                           int      21h

                           cmp      al,'1'
                           call     GAME_INTERFACE_EASY
                           jmp      saidaqui

                           cmp      al,'2'
                           call     GAME_INTERFACE_MEDIUM
                           jmp      saidaqui


                           cmp      al,'3'
                           call     GAME_INTERFACE_HARD
                           jmp      saidaqui


                           cmp      al,'4'
                           call     GAME_INTERFACE_UNCRUMBLE
                           jmp      saidaqui


  saidaqui:                

                           ret
Level_select endp


  
  ; ----------------------------------------------------------- ;
  ;                        the game                           ;
  ; ---------------------------------------------------------- ;
  ; imprimir o mapar
imprimir_mapa proc

                           push_all

 
                           mov      ah,9
                           lea      dx , LINHA_L
                           int      21h


                           mov      ah,9
                           lea      dx , numeros_linha
                           int      21h


                           mov      ah,9
                           lea      dx ,underline
                           int      21h

  
                           mov      ah,9
                           lea      dx , LINHA_L
                           int      21h

 

                           mov      ah, 09h
                           lea      dx, mapa                    ; imprime o mapa
                           int      21h



                           pop_all

                           ret
imprimir_mapa endp


visual_errou proc

                           push_all


                           lea      bx,mapa
  ;add bx,1  ; primeira posição da primeira linha
  ;add bx,24 ;  primeira posição da segunda linha
  ;add bx,47   ; primeira posição da terceira linha


                           add      bx,si                       ; adds para pegar a posição na linha
                           add      bx,si



                           add      bx,1                        ; passar para posição do quadradinho
                           add      bl,variavel_de_soma_coluna

                           mov      byte ptr [bx], '~'
                           mov      byte ptr [bx-1], '|'
                           mov      byte ptr [bx+1], '|'

                           call     limpatela
                           call     imprimir_mapa

                           mov      ah,9
                           lea      dx,Errou_tiro
                           int      21h



                           pop_all


                           ret
visual_errou endp


visual_acertou proc

                           push_all

  sub contador_saber_se_venceu,1
                           lea      bx,mapa
  ;add bx,1  ; primeira posição da primeira linha
  ;add bx,24 ;  primeira posição da segunda linha
  ;add bx,47   ; primeira posição da terceira linha


                           add      bx,si                       ; adds para pegar a posição na linha
                           add      bx,si



                           add      bx,1                        ; passar para posição do quadradinho
                           add      bl,variavel_de_soma_coluna

                           mov      byte ptr [bx], 11011100b
                           mov      byte ptr [bx-1], 11011100b
                           mov      byte ptr [bx+1], 11011100b

                           call     limpatela
                           call     imprimir_mapa

                           mov      ah,9
                           lea      dx,Acertou_tiro
                           int      21h







                           pop_all

                           ret
visual_acertou endp


  ; atualiza o mapa



  ; interface easy

GAME_INTERFACE_EASY proc
xor cx,cx 
mov cx,30

                       
  l1:                      

                           xor      bx,bx
                           xor      si,si


                           call     limpatela
                           call     imprimir_mapa


                           mov      ah,9
                           lea      dx, Ask_linha
                           int      21h

                           mov      ah,1
                           int      21h
                           mov      si,ax
                           and      si,0fh                      ; supondo que si = 1
  ; si já está salvo



                           mov      ah,9
                           lea      dx , Ask_coluna
                           int      21h

                           mov      ah,1
                           int      21h




  confere_coluna:          


                           cmp      al, variavel_de_letra
                           je       mostra_posição

                           inc      variavel_de_letra
                           add      variavel_de_soma_coluna,25  ; 0 25 50 75 100 125
                           add      bx,10

                           jmp      confere_coluna


mostra_posição:


                           mov      al,MATRIZEASY[si+bx]        ;  move para al o valor desejado

                           cmp      al,1
                           je       acertou

     
                           call     visual_errou

                           jmp      skip
       


  acertou:                 
                           call     visual_acertou
                    



  skip:                    

                           mov      variavel_de_soma_coluna,0
                           mov      variavel_de_letra,41h
                         



                           call     feedback

           
                      
                  
                          
                           mov      ah,1
                           int      21h

                          cmp al,'x' 
                          je saidaqui2





                  dec cx
                  cmp cx,0
                  je saidaqui2      ; decrementar o 'loop'
                  jmp l1

saidaqui2:

call end_game
                           ret

GAME_INTERFACE_EASY endp


  ; interface medium

GAME_INTERFACE_MEDIUM proc

                           xor      cx,cx



                           mov      cx,25

  l2:                      

                           xor      bx,bx
                           xor      si,si


                           call     limpatela
                           call     imprimir_mapa


                           mov      ah,9
                           lea      dx, Ask_linha
                           int      21h

                           mov      ah,1
                           int      21h
                           mov      si,ax
                           and      si,0fh                      ; supondo que si = 1
  ; si já está salvo



                           mov      ah,9
                           lea      dx , Ask_coluna
                           int      21h

                           mov      ah,1
                           int      21h




  confere_coluna2:         


                           cmp      al, variavel_de_letra
                           je       mostra_posição2

                           inc      variavel_de_letra
                           add      variavel_de_soma_coluna,25  ; 0 25 50 75 100 125
                           add      bx,10

                           jmp      confere_coluna2


mostra_posição2:


                           mov      al,MATRIZMEDIUM[si+bx]      ;  move para al o valor desejado

                           cmp      al,1
                           je       acertou2

     
                           call     visual_errou

                           jmp      skip2
       


  acertou2:                
                           call     visual_acertou



  skip2:                   

                           mov      variavel_de_soma_coluna,0
                           mov      variavel_de_letra,41h
                      

                           call     feedback

                                 
                           mov      ah,1
                           int      21h

                          cmp al,'x' 
                          je saidaqui3





                  dec cx
                  cmp cx,0
                  je saidaqui3      ; decrementar o 'loop'
                  jmp l1

saidaqui3:

call end_game

                           ret
GAME_INTERFACE_MEDIUM endp


  ; interface hard

GAME_INTERFACE_HARD proc
                 
                           xor      cx,cx



                           mov      cx,20

  l3:                      

                           xor      bx,bx
                           xor      si,si


                           call     limpatela
                           call     imprimir_mapa


                           mov      ah,9
                           lea      dx, Ask_linha
                           int      21h

                           mov      ah,1
                           int      21h
                           mov      si,ax
                           and      si,0fh                      ; supondo que si = 1
  ; si já está salvo



                           mov      ah,9
                           lea      dx , Ask_coluna
                           int      21h

                           mov      ah,1
                           int      21h




  confere_coluna3:         


                           cmp      al, variavel_de_letra
                           je       mostra_posição3

                           inc      variavel_de_letra
                           add      variavel_de_soma_coluna,25  ; 0 25 50 75 100 125
                           add      bx,10

                           jmp      confere_coluna3


mostra_posição3:


                           mov      al,MATRIZHARD[si+bx]        ;  move para al o valor desejado

                           cmp      al,1
                           je       acertou3

     
                           call     visual_errou

                           jmp      skip3
       


  acertou3:                
                           call     visual_acertou



  skip3:                   

                           mov      variavel_de_soma_coluna,0
                           mov      variavel_de_letra,41h
                         

                           call     feedback

                           
                           mov      ah,1
                           int      21h

                          cmp al,'x' 
                          je saidaqui4





                  dec cx
                  cmp cx,0
                  je saidaqui4      ; decrementar o 'loop'
                  jmp l1

saidaqui4:

call end_game




                           ret
GAME_INTERFACE_HARD endp

  ; interface uncrumble do game

GAME_INTERFACE_UNCRUMBLE proc
                           xor      cx,cx



                           mov      cx,15

  l4:                      

                           xor      bx,bx
                           xor      si,si


                           call     limpatela
                           call     imprimir_mapa


                           mov      ah,9
                           lea      dx, Ask_linha
                           int      21h

                           mov      ah,1
                           int      21h
                           mov      si,ax
                           and      si,0fh                      ; supondo que si = 1
  ; si já está salvo



                           mov      ah,9
                           lea      dx , Ask_coluna
                           int      21h

                           mov      ah,1
                           int      21h




  confere_coluna4:         


                           cmp      al, variavel_de_letra
                           je       mostra_posição4

                           inc      variavel_de_letra
                           add      variavel_de_soma_coluna,25  ; 0 25 50 75 100 125
                           add      bx,10

                           jmp      confere_coluna4


mostra_posição4:


                           mov      al,MATRIZUNCRUMBLE[si+bx]   ;  move para al o valor desejado

                           cmp      al,1
                           je       acertou4

     
                           call     visual_errou

                           jmp      skip4
       


  acertou4:                
                           call     visual_acertou



  skip4:                   

                           mov      variavel_de_soma_coluna,0
                           mov      variavel_de_letra,41h
                      

                           call     feedback

    
                                    
                           mov      ah,1
                           int      21h

                          cmp al,'x' 
                          je saidaqui5





                  dec cx
                  cmp cx,0
                  je saidaqui5      ; decrementar o 'loop'
                  jmp l1

saidaqui5:

call end_game

skipall:
mov ah,4ch

                           ret
GAME_INTERFACE_UNCRUMBLE endp



  ; ----------------------------------------------------------- ;
  ;                        Fim Procedimentos                    ;
  ; ---------------------------------------------------------- ;

feedback proc

                           push_all
 

        cmp contador_saber_se_venceu,0
        je winer

jmp continua
        winer: 

call win_game
continua:







                           mov      ah,9
                           lea      dx,LINHA_L
                           int      21h


                           mov      ah,9
                           lea      dx , next_try
                           int      21h


                          mov ah,9 
                          lea dx,sair_em_qualquer_momento
                          int 21h 




                      

                           pop_all

                           ret
feedback endp


  ; ----------------------------------------------------------- ;
  ;                        FINAL DO JOGO                       ;
  ; ---------------------------------------------------------- ;


end_game proc

                           call     limpatela

                           move_XY  1,9                         ; mover cursor para altura desejada ( começar a imprimir no meio do programa )

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

                           mov      ah,9
                           lea      dx,  TAKE_TIME
                           int      21h

              
                           mov      ah,9
                           lea      dx,  INSERT_ANOTHER_COIN
                           int      21h



                           mov      ah,1
                           int      21h
                           mov      bl,al
                           move_XY  80,25                       ; mover cursor lá para baixo


            
                           cmp      bl,'g'
                           je       finaldojogo
                        
   
                           cmp      bl,0dh                      ; reinicia o programa
                           jmp      reinicia




  finaldojogo:             
                           mov      ah,4ch
                           int      21h

                           ret
end_game endp



win_game proc

                           call     limpatela

                           move_XY  1,9                         ; mover cursor para altura desejada ( começar a imprimir no meio do programa )

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
                           lea      dx, Agradecimento2
                           int      21h

                           mov      ah,9
                           lea      dx,  TAKE_TIME
                           int      21h

              
                           mov      ah,9
                           lea      dx,  INSERT_ANOTHER_COIN
                           int      21h



                           mov      ah,1
                           int      21h
                           mov      bl,al
                           move_XY  80,25                       ; mover cursor lá para baixo


            
                           cmp      bl,'g'
                           je       finaldojogo2
                        
   
                           cmp      bl,0dh                      ; reinicia o programa
                           jmp      reinicia




  finaldojogo2:             
                           mov      ah,4ch
                           int      21h

                           ret
win_game endp




end main 