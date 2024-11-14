.model small 

.data 

var db 0
.code 


main proc 



l1 : 


inc var 

cmp var,17
je mostra 


jmp l1 

jmp fim 


mostra : 
mov bl,32h

mov ah,2
mov dl,bl
int 21h 



fim : 

mov ah,4ch 
int 21h 




main endp 
end main 