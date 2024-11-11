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

        Ask_linha db 10,13, 'digite a linha da matriz (0-9) : $'
        Ask_coluna db 10,13, 'digite a coluna da matriz (A-J) : $'

        Acertou_tiro db 10,13, ' Acertou seu merda $'
        Errou_tiro db 10,13, 'Errou seu merda $' 

 ;---------------------------------------------;
  ;  Campo do jogo                             ;
  ;---------------------------------------------;

        ; Mapa do jogo
        ll1   db '    0 1 2 3 4 5 6 7 8 9', 13, 10
        ll2   db ' _ _ _ _ _ _ _ _ _ _', 13, 10

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
              DB 0,0,0,0,0,0,0,0,0,0  ; J

; si = linha, bx = coluna





  ;---------------------------------------------;
  ;  Nivel MEDIUM                               ;
  ;---------------------------------------------;
















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

      TAKE_TIME db    '                                                   PRESS G TO EXIT     $'

  INSERT_ANOTHER_COIN   DB   '                                                INSERT ANOTHER COIN - PRESS ENTER $'


  ; parametro de saida do jogo
  PRESS_EXIT    DB   '                                                 EXIT GAME - PRESS G        $'
  PRESS_RULES   DB   '                                                  SHOW THE RULES - PRESS R        $'


  ; Regras

  REGRA1        db   '              1 -           $'
  REGRA2        db   '              2 -           $'
  REGRA3        db   '              3 -           $'
  REGRA4        db   '              4 -           $'
  REGRA5        db   '              5 -           $'
  REGRA6        db   '              6 -           $'



    ; niveis 

  Select_level  db   '                          Select The Level  $' 
  NIVEL1        db   '                          1 - Easy          $'
  NIVEL2        db   '                          2 - Medium        $'
  NIVEL3        db   '                          3 - Hard          $'
  NIVEL4        db   '                          4 - Uncrumble mode$'
 







.code

  ; ----------------------------------------------------------- ;
  ; Espaço dedicado para o main                                 ;
  ; ----------------------------------------------------------  ;


main proc

                       mov      ax,@data              ; chamando data para AX
                       mov      ds,ax

reinicia : 

                       call     limpatela

                       move_XY  1,3                   ; 80 25  ; reposicionar cursor


                       call     tela_inicial
                       move_XY  1,3                   ; 80 25  ; reposicionar cursor

                       call     Vefica_CR_RULES

                        call Level_select 



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
Vefica_CR_RULES proc
 
                       MOV      AH, 01h               ; Função para ler entrada de um caractere
  Espera:              
                       INT      21h                   ; Chama interrupção para receber caractere
                       cmp      AL,'g'
                       je       acaba
    
                       cmp      AL,'r'
                       je       regra
    


                       CMP      AL, 0Dh               ; Compara se é "CR" (ASCII 13)
                       JZ       limparateladousuario  ; Se for "CR", salta para o fim e sai do procedimento
                       JMP      Espera                ; Caso contrário, continua esperando entrada
    

  acaba:               
                       call     end_game
    

  regra:               
                       call     RULES

                       jmp      skipverifycr

  limparateladousuario:

                       call     limpatela


  skipverifycr:        


                       RET                            ; Sai do procedimento

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

call Vefica_CR_RULES

                       ret

RULES endp

Level_select proc 

call limpatela



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


mov ah,1 
int 21h 

cmp al,'1'
call GAME_INTERFACE_EASY
jmp saidaqui 

cmp al,'2'
call GAME_INTERFACE_MEDIUM
jmp saidaqui 


cmp al,'3'
call GAME_INTERFACE_HARD
jmp saidaqui 


cmp al,'4'
call GAME_INTERFACE_UNCRUMBLE
jmp saidaqui 


saidaqui: 

ret 
Level_select endp


  
; ----------------------------------------------------------- ;
  ;                        the game                           ;
  ; ---------------------------------------------------------- ;

; interface easy 
GAME_INTERFACE_EASY proc 

call limpatela

call imprimir_mapa





 ;  Cl definido pelo nivel 
        
xor cx,cx 

    mov cl, 30             ; Total de elementos a serem processados
 

l1:

    xor si, si               ; si = linha
    xor bx, bx               ; bx = coluna

; colocar proc de limpa tela 


mov ah,9 
lea dx, Ask_linha 
int 21h 

mov ah,1 
int 21h    ; pegar linha 
and ax,0FH
mov si,ax   ; salvando a posição da linha  




mov ah,9 
lea dx, Ask_coluna  ; A-J
int 21h 


mov ah,1
int 21h    ; pegar linha 


add ch, 41h

conferelinha : 

cmp al, ch ; comparar a letra digitada com cl ( para identificar a coordenada ) 
je mostra_posição 
add bx,10  ; passar para próxima coluna 
add ch,1

jmp conferelinha 







mostra_posição:

     mov al,MATRIZEASY[si+bx]    ;  move para al o valor desejado

push ax ; salva a posição da matriz 

       call  atualizar_mapa 

pop ax ; retorna a posição para verificar o acerto/erro 



    cmp al,1            ; compara para ver se há algum alvo 
    je acertou  

jmp errou  

    acertou: 
    mov ah,9 
    lea dx,Acertou_tiro         
    int 21h 

jmp fim 


    errou : 
    mov ah,9 
    lea dx,Errou_tiro 
    int 21h

loop l1 






fim: 

ret 
GAME_INTERFACE_EASY endp 


; imprimir o campo 

imprimir_mapa proc 

    mov ah, 09h
    lea dx, mapa
    int 21h


ret 
imprimir_mapa endp 



; se quero mudar a posição 0 ; si =1 ..... posição 1 ; si = 2 
atualizar_mapa proc 
xor ax,ax 

lea bx, mapa 

iniciodamostraX: 

cmp si, ax 
je mostrarX
inc ax
add bx,2  
jmp iniciodamostraX

mostrarX:
inc bx
mov byte ptr[bx], 'X'

call limpatela
call imprimir_mapa

ret 
atualizar_mapa endp 





; falta pegar de acordo com a coluna /  


; interface medium 

GAME_INTERFACE_MEDIUM proc 

ret 
GAME_INTERFACE_MEDIUM endp


; interface hard 

GAME_INTERFACE_HARD proc 

ret 
GAME_INTERFACE_HARD endp 

; interface uncrumble do game 

GAME_INTERFACE_UNCRUMBLE proc 

ret 
GAME_INTERFACE_UNCRUMBLE endp 



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

                      mov ah,9 
                      lea dx,  TAKE_TIME
                      int 21h 

              


                mov ah,9 
                      lea dx,  INSERT_ANOTHER_COIN
                      int 21h 



                      mov ah,1 
                      int 21h 
       mov bl,al 
                       move_XY  80,25                 ; mover cursor lá para baixo


            
                      cmp bl,'g'
                        je finaldojogo
                        
   
                       cmp bl,0dh     ; reinicia o programa 
                       jmp reinicia




finaldojogo : 
                       mov      ah,4ch
                       int      21h

                       ret
end_game endp


end main 