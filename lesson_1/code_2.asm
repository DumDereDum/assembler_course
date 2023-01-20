; Example of read char and print registers and messages

org 100h 
             
jmp start

msg db "Hellow world!$"        
            
start:

; show char interuption
; dl is equal to char 'a'
mov ah, 02h; 
mov dl, 'a';
int 21h   

; read interaption
; result store in al register
mov ah, 01h; 
int 21h      

; show char interuption
; dl is equal to register al
mov ah, 02h; 
mov dl, al;
int 21h   

; show char interuption
; dl is equal to ASCII char
; 0Ah - move curr line down   
mov ah, 02h; 
mov dl, 0Ah;
int 21h   

; show char interuption
; dl is equal to ASCII char
; 0Dh - move curr position on line to start          
mov ah, 02h; 
mov dl, 0Dh;
int 21h

; show set of chars interuption
; dx is equal to offset
mov ah, 09h; 
mov dx, offset msg;
int 21h   

ret
