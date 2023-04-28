; https://cs.lmu.edu/~ray/notes/nasmtutorial/
; https://stackoverflow.com/questions/15124440/difference-between-section-and-segment-in-nasm

    global    _start

    section   .data
letters: db "0123456789ABCDEF"

    section   .text
%macro _pop_4 4
    pop       %4
    pop       %3
    pop       %2
    pop       %1
%endmacro

%macro print_char 1
    push      rax
    push      rdi
    push      rsi
    push      rdx

    mov       rax, 1
    mov       rdi, 1
    mov       rsi, letters
    add       rsi, %1
    mov       rdx, 1
    syscall
    _pop_4 rax, rdi, rsi, rdx
%endmacro

print_BX:
    mov       rcx, 16
    mov       rdx, rbx
    push rbx
    xor rbx, rbx
    _loop:        
        rol   rdx, 04h
        push rdx
        and   rdx, 000Fh
        
        push  rcx
        print_char rdx
        pop   rcx 
        pop rdx

        loop _loop
    pop rbx
    ret

    section   .text
_start:   
    ;print_char 03h
    ;print_char 0Fh

    mov       rbx, 0F12345AEh
    ;mov       rbx, 0F0F0Fh
    ;mov       rbx, 0FFFFFFFFh
    call print_BX

end: 
    mov       rax, 60
    xor       rdi, rdi
    syscall

