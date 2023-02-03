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
    mov CX, Len_buff
    call print_buffer_hex_cycle
    print_letter CR
    print_letter LF

    pop CX
    pop AX
    pop SI
endm;=====================================================
print_buffer_letters macro buff
    push SI
    push AX
    push CX

    mov SI, offset buff
    inc SI
    xor CX, CX
    mov CL, byte ptr [SI]
    inc SI
    call print_buffer_cycle
    print_letter CR
    print_letter LF

    pop CX
    pop AX
    pop SI
endm
;=====================================================

;=====================================================
read_buffer macro buff
    push AX
    mov AH, 0Ah
    mov DX, offset file_name
    int 21h
    print_letter CR
    print_letter LF
    pop AX
endm
;=====================================================
start:
    print_buffer_hex file_name
    read_buffer file_name
    print_buffer_hex file_name
    print_buffer_letters file_name
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
        mov BL, byte ptr [SI]
        call print_byte
        inc SI
    loop _cycle_hex
    ret
print_buffer_hex_cycle endp
;=====================================================
print_buffer_cycle proc near
    _cycle_letter: 
        print_letter [SI]
        inc SI
    loop _cycle_letter
    ret
print_buffer_cycle endp
;=====================================================
    ; got error "data below initial cs:ip defined"
    ; fix by replacing data part from start to end 
    LF    EQU 0Ah   ; 0Ah - move curr line down
    CR    EQU 0Dh   ; 0Dh - move curr position on line to start 
    Space EQU 20h   ; 20h - sign of space ' '
    
    Max_len  EQU 0Eh   ; 0Eh = 14 
    Len_buff EQU 10h   ; 10h = 16
    
    file_name DB Max_len, 00h, 14 dup (Space)    ; fill line with 'Space' 14 times
    ; [max] [len] [20h, 20h, 20h, 20h, 20h, 20h, 20h, 20h]
;=====================================================

code_seg ends
end start