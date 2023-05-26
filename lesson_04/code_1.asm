code_seg segment
ASSUME CS:CODE_SEG,DS:code_seg,ES:code_seg
org 100h

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

start:

    mov AX, 3D02h
    mov DX, offset file_name
    int 21h

    jnc print_ok
    print_mes 'ERROR'
    jmp _end
    print_ok:
    print_mes 'OK'
    jmp _end
    
_end:
    int 20h

file_name  DB 'text.txt', 0


code_seg ends
end start