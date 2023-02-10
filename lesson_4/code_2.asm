code_seg segment
ASSUME CS:CODE_SEG,DS:code_seg,ES:code_seg
; org 80h
;tail DB 128 dup(0)
org 100h
;
CR EQU 13
LF EQU 10
Space EQU 20h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_letter macro letter
    push AX
    push DX
    mov DL, letter
    mov AH, 02
    int 21h
    pop DX
    pop AX
endm
PRINT_CRLF macro
    push AX
    push DX
    mov DL,13
    mov AH,02
    int 21h ; print CR
    mov DL,10
    mov AH,02
    int 21h ; print LF
    pop DX
    pop AX
ENDm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Print_Word macro src ; выводит на экран источник src в hex виде
local next, print_DL, print_hex, print_
    ;CR EQU 13
    ;LF EQU 10
    push AX
    push BX
    push CX
    push DX
    ;
    ;
    mov BX, src
    mov AH,02
    mov DL,BH
    ;rcr DL,4
    call print_DL
    ;mov DL,BH
    ;call print_hex
    ;
    mov DL,BL
    ;rcr DL,4
    call print_DL
    ;mov DL,BL
    ;call print_hex
    ;
    pop DX
    pop CX
    pop BX
    pop AX
    jmp next
    ;
    ;
    print_DL proc near
    push DX
    rcr DL,4
    call print_hex
    ;mov DL,BH
    pop DX
    call print_hex
    ret
    print_DL endp
    ;
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
    ;
    next:
endm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ReadFile macro Handler, Buffer, Counter, RealRead
    local read_error, nx,m1
    ;
    ; RealRead number of bytes actually read
    ;
    clc
    push ax
    MOV BX, Handler ; }
    MOV CX, Counter ; number reading bytes
    ;} for READ_FILE
    LEA DX, Buffer
    MOV AH,3FH ; function - read file
    INT 21H ; read file
    JnC m1
    jmp read_error
    m1:
    mov RealRead, AX
    ; PRINT_CRLF
    ; print_mes ' RealRead = '
    ; print_word AX
    jmp nx
    read_error:
    PRINT_CRLF
    print_mes ' ** ReadError '
    print_word AX
    nx: pop ax
ENDm
;====================================================================
WriteFile macro Handler, Buffer, Counter, RealWrite
    local Write_error, m2,m1
    ;
    ; RealWrite number of bytes actually Write
    ;
    clc
    push ax
    MOV BX, Handler ; }
    MOV CX, Counter ; number Writeing bytes
    ;} for Write_FILE
    LEA DX, Buffer
    MOV AH,40H ; function - Write file
    INT 21H ; Write file
    JnC m1
    jmp Write_error
    m1:
    mov RealWrite, AX
    ; PRINT_CRLF
    ; print_mes ' RealWrite = '
    ; print_word AX
    jmp m2
    Write_error:
    PRINT_CRLF
    print_mes ' ** WriteError '
    ; print_word AX
    m2: pop ax
ENDm
;====================================================================
start:
    print_letter CR
    print_letter LF
    ;------- check string of parameters -------------------------
    mov si, 80h ; addres of length parameter in psp
    mov al, byte ptr[si] ; is it 0 in buffer?
    cmp AL, 0
    jne cont4 ; yes
    ;---------------------------------------------------------------------
    ; print_mes 'not parameters' ; not parameters
    ; program was run without parameters
    ;---------------!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!------------
    print_mes 'Input File Name > '
    mov AH, 0Ah
    mov DX, offset FileName
    int 21h
    xor BH, BH
    mov BL, FileName[1]
    mov FileName[BX+2], 0
    ;
    mov AX, 3D02h ; Open file for read/write
    mov DX, offset FileName+2
    int 21h
    jc m
    jmp openOK
    m:
    print_letter CR
    print_letter LF
    print_mes 'openERR'
    int 20h
    print_letter CR
    int 20h
    ;---------------------------------------------------------------------
    cont4:
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
    ;--------------------------------------------------------------------
    mov AX, 3D02h ; Open file for read/write
    mov DX, DI
    int 21h
    jnc openOK
    print_letter CR
    print_letter LF
    print_mes 'openERR'
    int 20h
;=====================================================================
openOK:
    mov handler, AX
    print_letter CR
    print_letter LF
    ;print_mes 'openOK'
    ; read file
cycle:
    ReadFile handler, Bufin, 2048, RealRead
    cmp RealRead,2048
    je gowr
    jmp gohome
gowr:
    WriteFile 1, Bufin, 2048, RealWrite
    jmp cycle
gohome:
    WriteFile 1, Bufin, RealRead, RealWrite
    mov AX, 4C00h
    int 21h
;
print_hex proc near
    and DL,0Fh
    add DL,30h
    cmp DL,3Ah
    jl $print
    add DL,07h
    $print:
    int 21H
    ret
print_hex endp
;
print_reg_AX proc near
    push AX
    push BX
    push CX
    push DX
    ;
    mov BX, AX
    mov AH,02
    mov DL,BH
    rcr DL,4
    call print_hex
    mov DL,BH
    call print_hex
    mov DL,BL
    rcr DL,4
    call print_hex
    mov DL,BL
    call print_hex
    pop DX
    pop CX
    pop BX
    pop AX
    ret
print_reg_AX endp
;
print_reg_BX proc near
    push AX
    mov AX, BX
    call print_reg_AX
    pop AX
    ret
print_reg_BX endp
;
    handler DW ?
    RealRead DW ?
    RealWrite DW ?
    bufin DB 2048 dup (?) ; размер буфера 2048 только для
    ;примера, желательно его сделать больше, например, 20Кб.
    FileName DB 14,0,14 dup (0)

code_seg ends
end start