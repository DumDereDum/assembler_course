; https://gist.github.com/nikAizuddin/0e307cac142792dcdeba
; https://redirect.cs.umbc.edu/portal/help/nasm/nasm.shtml
; https://www.h-schmidt.net/FloatConverter/IEEE754.html

[bits 32]

section .text

extern printf
global main

main:

    ;mov ebx, dword [num11]
    ;mov dword [num11], ebx
_num11:
    ; load pi into st(0)
    fldpi
    ;fld dword [num11]
    ;fld dword [num2]
    ;fadd
    
    ; prepare some space on the stack
    sub   esp, 8
    ; to be able to push st(0) in there
    fstp  qword [esp]
    ; get the string format on the stack as well
    push  format
    ; print the string
    call  printf

    ; repair the stack
    ;   4 bytes memory address (for the format)
    ; + 8 bytes memory for the float
    ; =========
    ;  12 bytes
    add   esp, 12

    ; exit without error
    xor   eax, eax
    ret

section .data
    num11: dd 1.4
    num12: dd 0x3fb33333
    num13: dd 00111111101100110011001100110011b
    num2:  dd 2.6
    num3:  dd 1.5
    num4:  dd 2.5
    format: db "%.32g",10,0

