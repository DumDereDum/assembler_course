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
print_buffer_hex macro buff
    push SI
    push AX
    push CX
    
    mov SI, offset buff
    mov CX, Len_mem
    call print_buffer_hex_cycle

    pop CX
    pop AX
    pop SI
endm
;=====================================================
print_SI macro 
    push SI
    mov BX, SI
    call print_byte
    print_letter Space
    print_letter Colon
    print_letter Space
    pop SI
endm
;=====================================================
start:
    mov CX, PSP_lines_to_print
    mov SI, PSP_start
    _cycle_psp:
        print_SI
        print_buffer_hex ES:SI
        add SI, PSP_line_len
        print_letter LF
        print_letter CR
    loop _cycle_psp
    int 20h
;=====================================================
print_hex proc near
    push AX
    and DL,0Fh
    add DL,30h
    cmp DL,3Ah
    jl $print
    add DL,07h
    $print:
    mov AH, 02h
    int 21h
    pop AX
    ret
print_hex endp
;=====================================================
print_byte proc near
    push DX
    mov DL, BL
    rcr DL, 4
    call print_hex
    mov DL, BL
    call print_hex
    print_letter Space
    pop DX
    ret
print_byte endp
;=====================================================
print_buffer_hex_cycle proc near
    _cycle_hex: 
        mov BX, [SI]
        call print_byte
        inc SI
        mov BX, [SI]
        call print_byte
        inc SI
        print_letter Space
    loop _cycle_hex
    ret
print_buffer_hex_cycle endp
;=====================================================

    LF      EQU 0Ah   ; 0Ah - move curr line down
    CR      EQU 0Dh   ; 0Dh - move curr position on line to start 
    Space   EQU 20h   ; 20h - sign of space ' '
    Colon   EQU 3Ah   ; 3Ah - sign of colon ':'
    Len_mem EQU 08h   ; 08h - len of words (2byte) in memory
    
    PSP_start          EQU 50h ; 80h = 128
    PSP_lines_to_print EQU 10h ; 10h = 16
    PSP_line_len       EQU 10h ; 10h = 16

;=====================================================

code_seg ends
end start