code_seg segment
assume cs:code_seg,ds:code_seg,ss:code_seg
org 100h
;================================================================
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
;===================================================================
start:        

    ;xor AX, AX
    ;mov ES, AX
    ;mov ES:65h*4, offset new_65h
    ;mov ES:65h*4+2,CS
    
    mov BX,65h
    shl BX,2
    mov ES:[BX],offset new_65h
    mov ES:[BX+2],DS
    
    int 65h

    int 20h

;===================================================================
new_65h proc far
    print_mes "hello world!"
    iret
new_65h endp
;===================================================================
code_seg ends
end start