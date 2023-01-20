; Example of simple function and registers CF, SF, ZF, PF

org 100h

mov ah, 00h; ZF=0, PF=0
add ah, 02h; ZF=0, PF=0

sub ah, ah;  ZF=1, PF=1

add ah, 03h; ZF=0, PF=1
xor ah, ah;  ZF=1, PF=1
                     
mov ah, 00h; ZF=1, PF=1  

add ax, 01h; 1 00000001 ZF=0, PF=0
add ax, 01h; 2 00000010 ZF=0, PF=0
add ax, 01h; 3 00000011 ZF=0, PF=1
add ax, 01h; 4 00000100 ZF=0, PF=0
add ax, 01h; 5 00000101 ZF=0, PF=1
add ax, 01h; 6 00000110 ZF=0, PF=1
add ax, 01h; 7 00000111 ZF=0, PF=0
add ax, 01h; 8 00001000 ZF=0, PF=0

sub ax, 10h;  
; FFF8 (1111 1111 1111 0100)
; CF=1 Carry flag, because first bit equal to 1
; SF=1 Sign Flag, because number is negative
; ZF=0 Zero Flag, because number is npt equal to 0
; PF=0 Parity Flag, bacause number of 1 is not even
                      
ret

