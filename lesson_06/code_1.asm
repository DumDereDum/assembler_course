code_seg segment
ASSUME CS:CODE_SEG,DS:code_seg,ES:code_seg
org 100h
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
    
    mov DL, CR
    mov AH, 02h
    int 21h
    mov DL, LF
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
Print_Word macro src
local print_DL, print_hex, print_
; Print 2 bytes
;---------------------------------------------------------------------
    print_DL proc near
        push DX
        rcr DL,4
        call print_hex
        pop DX
        call print_hex
        ret
    print_DL endp
;---------------------------------------------------------------------
    print_hex proc near
        and DL, 0Fh
        add DL, 30h
        cmp DL, 3Ah
        jl print_
        add DL, 07h
        print_:
        int 21H
        ret
    print_hex endp
;---------------------------------------------------------------------
    push AX
    push BX
    push CX
    push DX

    mov BX, src
    mov AH, 02h
    mov DL, BH
    call print_DL
 
    mov DL, BL
    call print_DL
 
    pop DX
    pop CX
    pop BX
    pop AX
endm
;=====================================================================
ReadFile macro Handler, Buffer, Counter, RealRead
local read_error, nx,m1
    push AX

    clc             ; clear CF flag
    mov BX, Handler ; id
    mov CX, Counter ; number of bytes for read
    lea DX, Buffer
    mov AH, 3Fh     ; function - read file
    int 21h         ; read file
    jnc m1          ; if CF == 0 jmp to m1
    jmp read_error  ; CF = 1, AX = 05h if no permition
                    ;         AX = 06h if incorect id in DX 
    m1:
        mov RealRead, AX    ; AX - number of read bytes
        jmp nx
    read_error:
        start_new_line
        print_mes ' * ReadError * '
        print_word AX       ; print the reason of error
    nx: 
        pop AX
endm
;====================================================================
start:
    print_letter CR
    print_letter LF
;------- check string of parameters -------------------------
    mov si, 80h          ; addres of length parameter in psp
    mov al, byte ptr[si] ; is it 0 in buffer?
    cmp AL, 0
    jne read_file_name_psp ; if parametr exist jmp cont4
;---------------------------------------------------------------------
; print_mes 'not parameters' ; not parameters
; program was run without parameters
;---------------!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!------------
    ask_for_file_name:
        print_mes 'Input File Name > '
        mov AH, 0Ah
        mov DX, offset FileName
        int 21h
        xor BH, BH
        mov BL, FileName[1]
        mov FileName[BX+2], 0
        mov DX, offset FileName+2
        jmp open_file
;---------------------------------------------------------------------
    read_file_name_psp:
        xor BH, BH
        ;mov BL, tail[0]
        ;mov tail[BX+1], 0
        mov BL, ES:[80h] ; а вот так -> mov BL, [80h]нельзя!!!!
        mov byte ptr [BX+81h], 0
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        mov CL, ES:80h ; Длина хвоста в PSP
        xor CH, CH ; CX=CL= длина хвоста
        cld ; DF=0 - флаг направления вперед
        mov DI, 81h ; ES:DI-> начало хвоста в PSP
        mov AL,' ' ; Уберем пробелы из начала хвоста
        repe scasb ; Сканируем хвост пока пробелы
        ; AL - (ES:DI) -> флаги процессора
        ; повторять пока элементы равны
        dec DI ; DI-> на первый символ после пробелов
        mov DX, DI
;--------------------------------------------------------------------
    open_file:
        mov AX, 3D02h ; Open file for read/write
        int 21h
        jnc openOK
        start_new_line
        print_mes ' * OpenError * '
        jmp _end
    openOK:
        mov handler, AX ; file id
        start_new_line
    cycle:
        ReadFile handler, bufin, buffer_len, RealRead
;block for replacement
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        mov AH, 09h
        mov DX, offset buff_test
        int 21h
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    read_key:
        xor AX, AX
        mov AH, 01h
        int 21h
        cmp AL, 1Bh ; ESC key
        je  _end
;block for replacement
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        jmp read_key
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    _end:
        int 20h
;=====================================================================
print_hex proc near
    and DL, 0Fh
    add DL, 30h
    cmp DL, 3Ah
    jl _print
    add DL, 07h
    _print:
        int 21H
    ret
print_hex endp
;=====================================================================
print_reg_AX proc near
    push AX
    push BX
    push CX
    push DX

    mov BX, AX
    mov AH, 02h
    mov DL, BH
    rcr DL, 04h   ; recursive shift
    call print_hex
    mov DL, BH
    call print_hex
    mov DL, BL
    rcr DL, 04h
    call print_hex
    mov DL, BL
    call print_hex

    pop DX
    pop CX
    pop BX
    pop AX
    ret
print_reg_AX endp
;=====================================================================
print_reg_BX proc near
    push AX
    
    mov AX, BX
    call print_reg_AX
    
    pop AX
    ret
print_reg_BX endp
;=====================================================================
    CR      EQU 0Dh
    LF      EQU 0Ah
    Space   EQU 20h

    handler     DW ?
    RealRead    DW ?
    RealWrite   DW ?
    buffer_len  EQU 2048    ; try 5 instead of 2048
    bufin       DB buffer_len dup (?), "$" ; max 20Kb
    buff_test   DB "123456789A123456789A123456789A123456789A123456789A123456789A123456789A123456789A$"
    FileName    DB 14,0,14 dup (0)
;=====================================================================
code_seg ends
end start