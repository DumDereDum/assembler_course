code_seg segment
ASSUME CS:CODE_SEG,DS:code_seg,ES:code_seg
org 100h
;=====================================================
print_letter macro letter
    push AX
    push DX
    mov DL, letter
    mov AH, 02h
    int 21h
    pop DX
    pop AX
endm
;=====================================================
print_row macro buff
local _cycle
    push AX
    push CX
    push DX
    push SI

    mov SI, offset buff
    mov CX, len
    _cycle:
        print_letter [SI]
        inc SI 
    loop _cycle
    print_letter LF
    print_letter CR

    pop SI
    pop DX
    pop CX
    pop AX
endm
;=====================================================
start:
    print_row text_1
    print_row text_2

    print_letter LF
    print_letter CR

    mov SI, offset text_1
    mov DX, offset text_2
    mov CX, len
    _cycle:
        ; https://studfile.net/preview/2261910/page:13/
        ; RULE: if 1st is [], then 2nd should be reg or value
        ;       if 2nd is [], then 1sf should be reg
        mov [DX], [SI]
        inc SI 
        inc DX
    loop _cycle

    print_row text_1
    print_row text_2

    int 20h
;=====================================================
len     EQU 09h
text_1  DB "123456789"
text_2  DB "000000000"

LF      EQU 0Ah   ; 0Ah - move curr line down
CR      EQU 0Dh   ; 0Dh - move curr position on line to start 
Space   EQU 20h   ; 20h - sign of space ' '
;=====================================================   

code_seg ends
end start