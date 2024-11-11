.model small 
.stack 100h 






.data

           ;0 1 2 3 
    mapa DB 1,2,3,4    ;0,0          ; definindo a matriz
  



.code
main proc
             mov   ax,@data
             mov   ds,ax




             call  processo

             mov   ah,4ch
             int   21h



processo proc



lea si,mapa 
  mov byte ptr mapa[2], 'X'


mov ah,2 
mov dl,si 
int 21h 



             ret
processo endp





main endp
end main 