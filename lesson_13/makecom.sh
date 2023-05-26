#!/bin/bash
nasm -g -l $1.list -felf32 $1.asm
ld -m elf_i386 $1.o --output=$1.out
./$1.out $2 $3