code_seg segment
      ASSUME CS: code_seg,DS:code_seg,ES:code_seg
      org 100h
start:
      mov BX, 0F21Bh
      mov AL, BH             ; save first part of register
      mov SI, offset OutByte ; set pointer on start of our line
      call ascii_byte
      mov AL, BL             ; save second part of register
      call ascii_byte
      mov AH,09h             ; code for print string
      mov DX, offset OutByte ; pointer on start of our Byte string
      int 21h                ; interuption for print
int 20h

ascii_byte proc
      push AX    ; save AX in stack
      shr AL,4   ; shift AL on 4 bit (save only hight bits)
                 ; 11111111 -> 01111111 
                 ; 11111111 -> 00111111 
                 ; 11111111 -> 00011111 
                 ; 11111111 -> 00001111       
      call ascii_tetr
      pop AX     ; extract AX from stack
      call ascii_tetr
      ret
endp

ascii_tetr proc
      push BX     ; save BX in stack
      and AL, 0Fh ; save only low 4 bits
                  ;     11111111
                  ; AND 00001111
                  ;   = 00001111 
      mov bx, offset lookupTable
      xlat ; make recoding bite which located in AL according to table in BX
           ; we have number in register
           ;   0   1   2   3   4   5   6   7   8   9   A   B   C   D   E   F
           ; which should correspont to idexes in table lookupTable 
           ; 30h,31h,32h,33h,34h,35h,36h,37h,38h,39h,41h,42h,43h,44h,45h,46h
           ; so it translates from imdexes to ASCII codes
      mov byte ptr [SI], AL ; save letter in OutByte
      inc SI   ; increment SI for saving next bit in future
      pop BX   ; extract BX from stack
      ret
endp

lookupTable db 30h,31h,32h,33h,34h,35h,36h,37h,38h,39h ; 0-9
            db 41h,42h,43h,44h,45h,46h ; A-F
OutByte DB ?,?,?,?,'$' ; NULL, NULL, NULL, NULL, $ 

code_seg ends

end start


