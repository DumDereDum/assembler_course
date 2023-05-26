org 100h
      mov AH, 02h
      mov CX, 12  
; or
;      mov CX, msg_len      
      mov SI, offset msg
nxt: 
      mov DL, [SI]
      inc SI
      int 21h
      loop nxt
int 20h

msg DB 'Hello world!'  
msg_len EQU $-msg
