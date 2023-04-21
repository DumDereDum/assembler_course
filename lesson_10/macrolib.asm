;=====================================================================
%macro print_letter 1
    push AX
    push DX
    
    mov DL, %1
    mov AH, 02
    int 21h
    
    pop DX
    pop AX
%endmacro 
;=====================================================================
%macro start_new_line 0
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
%endmacro 
;=====================================================================
%macro print_mes 1
local msg, nxt
    push AX
    push DX

    mov DX, offset msg
    mov AH, 09h
    int 21h

    pop DX
    pop AX

    jmp nxt
    msg DB %1,'$'
    nxt:
%endmacro 
;=====================================================================
%macro print_mes1 1

    push AX
    push DX

    mov DX, offset %1
    mov AH, 09h
    int 21h

    pop DX
    pop AX

%endmacro 
;=====================================================================
%macro rand_dx_9 0

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

%endmacro 
;=====================================================================
