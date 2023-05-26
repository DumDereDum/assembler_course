code_seg segment
ASSUME CS:CODE_SEG,DS:code_seg,ES:code_seg
org 100h
start:
jmp begin

INCLUDE macrolib.asm

data struc
    mes1   DB "A"
    mes2   DB "BBBBBBBBBBBBBB"
    end    DB '$'
data ends

begin:

    _data data <>
    print_letter _data.mes1
    start_new_line
    print_mes1 _data.mes2

    int 20h

code_seg ends
end start