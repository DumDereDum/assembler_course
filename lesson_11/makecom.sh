#!/bin/bash
nasm -felf64 $1.asm
ld $1.o --output=$1.out
./$1.out $2 $3