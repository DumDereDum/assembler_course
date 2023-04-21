;http://www.codenet.ru/progr/dos/dos_0033.php
;http://www.codenet.ru/progr/dos/dos_0018.php
;http://www.codenet.ru/progr/dos/dos_0081.php
;http://www.codenet.ru/progr/dos/int_0026.php

code_seg segment
ASSUME CS:CODE_SEG,DS:code_seg,ES:code_seg
org 100h
start:
jmp begin

INCLUDE macrolib.asm

dta struc
    wild_card DB 15h dup(?)
    attrib    DB ?
    file_time DW ?
    file_date DW ?
    file_size DW 2 dup(?)
    file_name DB 12 dup(?)
dta ends

struc_for_0Ah_Func struc
    max_lenght  DB 14 
    real_lenght DB ?
    text		DB 12 dup(?)
struc_for_0Ah_Func ends

my_DTA dta <>
buffer struc_for_0Ah_Func <>

point DB 0FFh
dname DB 10 dup (?)
flag  DW 0
SPACE equ 20h

begin:

;=======================================================================
    mov	AH,		1Ah
    mov	DX,		offset my_DTA
    int	21h
;=======================================================================
    print_mes	'Print directory. Please input template : '
    mov AH,	0Ah
    mov	DX,	offset	buffer
    int	21h
    mov BL,	buffer.real_lenght
    xor	BH,	BH
    mov SI,	offset buffer.text
    mov byte ptr[BX][SI], 0
    mov	CX,	BX
    inc CX
    mov	DI,	offset	dname
    cld
    rep	movsb
    start_new_line
start_searh:
    mov AH,4Eh
    xor CX,	CX
    mov DX, offset dname
next_search:
    int 21h
    jnc gogo 
    jmp nofiles
gogo:      
    inc	flag
    mov	CX,	8		
    mov SI, offset my_DTA.file_name
print_name:
    lodsb       ; print name
    cmp AL,	'.'	; asciiZ? end of name?
    je	ps	    ; if AL = 0, goto print_space
    mov AH, 02	; if AL != 0, print current char
    mov DL, AL
    int 21h
    dec CX
    jmp	print_name
ps:			
    mov DL,	SPACE
    int	21h 
    cmp	CX,	0
    je	print_ext	
print_space:			
    mov 	DL, 	SPACE
    int 	21h 	
    loop print_space
print_ext:
    lodsb	; print name
    cmp AL,	0		; asciiZ? end of name?
    je	nxt_search 	; if AL = 0, goto print_space
    mov AH, 02		; if AL != 0, print current char
    mov DL, AL
    int 21h 
    jmp print_ext
nxt_search:			
    mov     AH,4Fh
    jmp 	next_search
nofiles:
    cmp 	flag,	0
    jne		vse
    print_mes 'no files'
vse:		
    start_new_line
    int 20h

code_seg ends
end start