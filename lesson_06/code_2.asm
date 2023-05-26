code_seg segment
assume cs:code_seg,ds:code_seg,ss:code_seg
org 100h

print_letter macro letter
    push AX
    push DX
    
    mov DL, letter
    mov AH, 02
    int 21h
    
    pop DX
    pop AX
endm

start:
    mov ah, 01h
    int 16h
    call print_reg
    jmp start

    int 20h                         
;-----------------------------------
print_reg proc
    mov DL, AH    
    call print_byte
    mov DL, AL    
    call print_byte 
    print_letter 0Dh
    print_letter 0Ah
endp
;-----------------------------------
print_byte proc
      push DX            ; push DX to stack
      shr DL, 4          ; shift DL on 4 bit (save only hight bits)
                         ; 11111111 -> 01111111 
                         ; 11111111 -> 00111111 
                         ; 11111111 -> 00011111 
                         ; 11111111 -> 00001111 
      mov AH, 02H
      call print_tetrada
      pop DX             ; extract DX from stack
      and DL,0Fh         ; save only low 4 bits
                         ;     11111111
                         ; AND 00001111
                         ;   = 00001111
      call print_tetrada
      ret
endp
;-----------------------------------
print_tetrada proc
      add DL, 030H ; DL + 030h -> ASCII numder [0-9]
      cmp DL, 03AH ; if DL ASCII number
      jb print     ; print
                   ; else
      add DL, 07H  ; DL + 030h + 07h -> ASCII letter[A-Z]
      print:       ; print
      int 21H
      ret
endp
ret

code_seg ends
end start