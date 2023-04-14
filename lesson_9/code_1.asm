code_seg segment
ASSUME CS:CODE_SEG,DS:code_seg,ES:code_seg
org 100h
start:
jmp begin

INCLUDE macrolib.asm

begin:
    print_letter "A"
    start_new_line
    print_mes "BBBBBBBBBBBBBB"

    int 20h

code_seg ends
end start