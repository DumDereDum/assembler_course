#!/bin/bash
#sudo apt install gcc-multilib
nasm -f elf32 $1.asm -o $1.o
gcc -g -m32 $1.o -o $1
./$1