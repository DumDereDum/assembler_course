# assembler_cource

## Module 1

### Desription:
[lesson_01/code_1](https://github.com/DumDereDum/assembler_cource/blob/main/lesson_01/code_1.asm) - base assembler language functions

[lesson_01/code_2](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_01/code_2.asm) - base assembler language print functions

[lesson_02/code_1](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_02/code_1.asm) - more complex example of print functions

[lesson_02/code_2](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_02/code_2.asm) - print of BX register

[lesson_02/code_3](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_02/code_3.asm) - more complex print of BX register

[lesson_02/horror](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_02/horror.asm) - example of segmentation (for curious)

[lesson_03/code_1](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_03/code_1.asm) - get string from comand line (example of `macro` and `proc`)

[lesson_03/code_2](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_03/code_2.asm) - print PSP

[lesson_04/code_1](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_04/code_2.asm) - check avalibility of file

[lesson_04/code_2](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_04/code_2.asm) - try to print and append file content

[lesson_04/extra](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_04/extra.asm) - work with `[...]` extentions

[lesson_05/code_1](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_05/code_1.asm) - create our own base interuption int65

[lesson_05/code_2](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_05/code_2.asm) - append timer interuption for printing 'A' ~18 times per second

[lesson_06/code_1](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_06/code_1.asm) - read and print file content with places for individual work

[lesson_07/code_1](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_07/code_1.asm) - resident keyboard click handler, print smth after pressing `esc` (example of int10h)

[lesson_08/code_1](https://github.com/DumDereDum/assembler_cource/blob/main/lesson_08/code_1.asm) - example of TSR (resident) programm


### Home(Class)Works
1. Merge two codes: [lesson_03/code_1](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_03/code_1.asm) and [lesson_04/code_1](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_04/code_1.asm), that means that you are able to write file name and check is it avaliable. !NB Prohibit to use [lesson_04/code_2](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_04/code_2.asm)
2. Make your own PSP print
3. Update [lesson_06/code_1](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_06/code_1.asm) by creating your pring functions which fills full screen (25x80 signs) and move in file by using any two keys. Example linux finction `cat <file> | less`
4. Take file [lesson_05/code_2](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_05/code_2.asm) and make print 1 sign in 1 second
5. Take file [lesson_07/code_1](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_07/code_1.asm) and make any changes with color, size and message, additionaly return cursor in lower (bottom) line
6. Take file [lesson_07/code_1](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_07/code_1.asm) and make game:
* Game starts after tressing `Enter` and `@` apears in the midn of clean screen
* `W` `A` `S` `D` for movements
* `Esc` for exit
7. Continue of ex.6:
* Create walls `#`
* Color `@` and `#` in 3 different colors (example: reb, blue, green)
* Make than character `@` pass throw only walls which have the same color as him 


## Module 2

### Desription:

[lesson_09/code_1](https://github.com/DumDereDum/assembler_cource/blob/main/lesson_09/code_1.asm) - 1st example of work with include file

[lesson_09/code_2](https://github.com/DumDereDum/assembler_cource/blob/main/lesson_09/code_2.asm) - 2st example of work with include file

[lesson_09/macrolib](https://github.com/DumDereDum/assembler_cource/blob/main/lesson_09/macrolib.asm) - example of include file

[lesson_10/code_1](https://github.com/DumDereDum/assembler_cource/blob/main/lesson_10/code_1.asm) - find files in dir by simple regular expression

[lesson_10/code_2](https://github.com/DumDereDum/assembler_cource/blob/main/lesson_10/code_2.asm) - base example of work with nasm

[lesson_11/code_1](https://github.com/DumDereDum/assembler_cource/blob/main/lesson_11/code_1.asm) - print RBX register

[lesson_12/main.c](https://github.com/DumDereDum/assembler_cource/blob/main/lesson_12/main.c) - examples of assempler inplaces in C language

[lesson_13/code_1](https://github.com/DumDereDum/assembler_cource/blob/main/lesson_13/code_1.asm) - print of [text.txt](https://github.com/DumDereDum/assembler_cource/blob/main/lesson_13/text.txt) file


### Home(Class)Works

1. Take any code and separete:
* macro in file `code_macro.asm` 
* proc in file `code_proc.asm` 
* data in file `code_data.asm`

And then include them all in file `main.asm` and it should work :)

2. Change code [lesson_11/code_1](https://github.com/DumDereDum/assembler_cource/blob/main/lesson_11/code_1.asm) for new way of print old: `111100002222EEEE...` -> new: `1111 0000 2222 EEEE ...`, so you should separate every 4 bytes

3. ( ͡° ͜ʖ ͡°)

4. Change code [lesson_13/code_1](https://github.com/DumDereDum/assembler_cource/blob/main/lesson_13/code_1.asm) for writing data from file to new file (name of this file could be hardcode)

5. Make code on nasm, which add float number. !NB Prohibit to use `fadd` and similar fuctions

6. Take [snake game](https://github.com/NikitaIvanovV/snake-asm) and make changes:
* remove tail of snake, keep only head
* remove sliding, so after press `WASD` snake make only one movement