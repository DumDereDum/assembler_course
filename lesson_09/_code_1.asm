.286
CODE_SEG	SEGMENT
        ASSUME  CS:CODE_SEG,DS:code_seg
		ORG	100H
START:
jmp begin
IF1					    ;
 	INCLUDE macrolib.asm	; macro library
ENDIF
;=============================================================	
;   ¯à¥€¥«¥­š¥ áâàãªâãàë
dta         struc
wild_card   DB      15h dup(?)
attrib      DB      ?
file_time   DW      ?
file_date   DW      ?
file_size   DW      2 dup(?)
file_name   DB      12  dup(?)
dta         ends
;
struc_for_0Ah_Func         struc
max_lenght   	DB      14 
real_lenght     DB      ?
text		   	DB      12  dup(?)
struc_for_0Ah_Func          ends
my_DTA		dta <>
buffer struc_for_0Ah_Func <>
;
point      DB      0FFh
dname       DB      10 dup (?)
;
flag		DW		0
begin:

;=======================================================================
			mov	AH,		1Ah
			mov	DX,		offset my_DTA
			int	21h
;=======================================================================
			mov 	BL,		ES:[80h]       	; tail in PSP
			cmp 	BL,		0            	; tail=0?
			jne  	prod			   		; yes, run without parameters
			jmp 	without_param							
prod:		xor		BH,		BH					; run with parameters
			;mov		BL, 	ES:[80h]			;    
			mov	byte ptr [BX+81h],	0		; asciiZ!
;---------------------------------------------------------------
			mov 	CL,		BL    			; lenght of tail
			xor 	CH,		CH       		; CX=CL= lenght of tail
			push	CX
			cld             				; DF=0 - ä« £ ­ ¯à ¢«¥­šï ¢¯¥à¥€
			mov 	DI, 	81h     		; ES:DI-> ­ ç «® å¢®áâ  ¢ PSP
			mov 	AL,		' '        		; ¡¥à¥¬ ¯à®¡¥«ë š§ ­ ç «  å¢®áâ 
repe    	scasb   						; scan tail until space
			dec 	DI        					; DI-> first char after space
			mov		SI,		DI	
			mov		DI,	offset   dname
			
			pop		CX
			inc		CX
			inc		CX
			print_CRLF
			print_all_reg
rep			movsb
;;;
print_CRLF
print_field 123,153
			jmp start_searh
;=======================================================================
without_param:
print_mes	'Print directory. Please input template : '
		mov		AH,		0Ah
		mov		DX,		offset	buffer
		int		21h
		mov 	BL,		buffer.real_lenght
		xor		BH,		BH
		mov 	SI, 	offset buffer.text
		mov byte ptr	[BX][SI],	0
		mov		CX,		BX
		inc 	CX
		mov		DI,		offset	dname
		cld
rep		movsb
print_CRLF
;=======================================================================
start_searh:
            mov     AH,4Eh
        ;    mov     CX,8
			xor 	CX,	CX
            mov     DX,offset   dname
next_search:
			int     21h
            jnc     gogo 
			jmp nofiles
;
gogo:      inc		flag
			mov		CX,		8		; max of file name
			mov 	SI, offset my_DTA.file_name
print_name:
			lodsb					; print name
			cmp 	AL,		'.'		; asciiZ? end of name?
			je		ps				; if AL = 0, goto print_space
			mov 	AH, 	02		; if AL != 0, print current char
			mov 	DL, 	AL
			int 	21h 			
			dec     CX
			jmp	print_name

ps:			mov 	DL, 	SPACE
			int 	21h 
			cmp 	CX,		0
			je		print_ext	
print_space:			
			mov 	DL, 	SPACE
			int 	21h 	
			loop print_space
			; print file extension
print_ext:
			lodsb					; print name
			cmp 	AL,		0		; asciiZ? end of name?
			je		nxt_search 	; if AL = 0, goto print_space
			mov 	AH, 	02		; if AL != 0, print current char
			mov 	DL, 	AL
			int 	21h 
			jmp print_ext
		;	
nxt_search:			
print_CRLF
			mov     AH,4Fh
			jmp 	next_search
nofiles:
			cmp 	flag,	0
			jne		vse
            print_mes 'no files'
vse:		
print_CRLF
print_word_dec		flag, '  files'
;print_mes '  files'
			int     20h
CODE_SEG    ENDS
        END START