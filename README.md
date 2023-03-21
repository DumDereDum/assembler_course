# assembler_cource

## Desription:
[lesson_1/code_1](https://github.com/DumDereDum/assembler_cource/blob/main/lesson_1/code_1.asm) - base assembler language functions

[lesson_1/code_1](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_1/code_2.asm) - base assembler language print functions

[lesson_2/code_1](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_2/code_1.asm) - more complex example of print functions

[lesson_2/code_2](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_2/code_2.asm) - print of BX register

[lesson_2/code_3](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_2/code_3.asm) - more complex print of BX register

[lesson_2/horror](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_2/horror.asm) - example of segmentation (for curious)

[lesson_3/code_1](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_3/code_1.asm) - get string from comand line (example of `macro` and `proc`)

[lesson_3/code_2](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_3/code_2.asm) - print PSP

[lesson_4/code_1](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_4/code_2.asm) - check avalibility of file

[lesson_4/code_2](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_4/code_2.asm) - try to print and append file content

[lesson_4/extra](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_4/extra.asm) - work with `[...]` extentions

[lesson_5/code_1](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_5/code_1.asm) - create our own base interuption int65

[lesson_5/code_2](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_5/code_2.asm) - append timer interuption for printing 'A' ~18 times per second

[lesson_6/code_1](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_6/code_1.asm) - read and print file content with places for individual work

[lesson_7/code_1](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_7/code_1.asm) - resident keyboard click handler, print smth after pressing `esc` (example of int10h)

## Home(Class)Works
1. Merge two files: [lesson_3/code_1](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_3/code_1.asm) and [lesson_4/code_1](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_4/code_2.asm), that means that you are able to write file name and check is it avaliable. !NB Prohibit to use [lesson_4/code_2](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_4/code_2.asm)
2. Make your own PSP print
3. Update [lesson_6/code_1](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_6/code_1.asm) by creating your pring functions which fills full screen (25x80 signs) and move in file by using any two keys. Example linux finction `cat <file> | less`
4. Take file [lesson_5/code_2](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_5/code_2.asm) and make print 1 sign in 1 second
5. Take file [lesson_7/code_1](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_7/code_1.asm) and make any changes with color, size and message, additionaly return cursor in lower (bottom) line
6. Take file [lesson_7/code_1](https://github.com/DumDereDum/assembler_cource/tree/main/lesson_7/code_1.asm) and make game:
* Game starts after tressing `Enter` and `@` apears in the midn of clean screen
* `W` `A` `S` `D` for movements
* `Esc` for exit
7. Continue of ex.6:
* Create walls `#`
* Color `@` and `#` in 3 different colors (example: reb, blue, green)
* Make than character `@` pass throw only walls which have the same color as him 




