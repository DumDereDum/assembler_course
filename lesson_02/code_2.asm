org 100h
      mov BX, 0AF51h
      mov DL, BH     ; DL = AF
      call print_byte
      mov DL, BL     ; DL = 51
      call print_byte
      int 20H
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


