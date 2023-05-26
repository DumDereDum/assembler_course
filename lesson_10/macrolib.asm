;=====================================================================
print_letter macro letter
    push AX
    push DX
    
    mov DL, letter
    mov AH, 02
    int 21h
    
    pop DX
    pop AX
endm
;=====================================================================
start_new_line macro
    push AX
    push DX
    
    mov DL, 0Dh
    mov AH, 02h
    int 21h
    mov DL, 0Ah
    mov AH, 02h
    int 21h
    
    pop DX
    pop AX
endm
;=====================================================================
print_mes macro message
local msg, nxt
    push AX
    push DX

    mov DX, offset msg
    mov AH, 09h
    int 21h

    pop DX
    pop AX

    jmp nxt
    msg DB message,'$'
    nxt:
endm
;=====================================================================
print_mes1 macro message

    push AX
    push DX

    mov DX, offset message
    mov AH, 09h
    int 21h

    pop DX
    pop AX

endm
;=====================================================================
rand_dx_9 macro

    push AX
    push CX

    mov AH, 00h        
    int 1AH

    mov ax, dx
    xor dx, dx
    aam
    mov dl, al

    pop CX
    pop AX

endm
;=====================================================================
