section .bss
buffer: resb 2048 ; A 2 KB byte buffer used for read

section .data
buflen: dw 2048 ; Size of our buffer to be used for read

section .text
global _start
_start:
; open(char *path, int flags, mode_t mode);

; Get our command line arguments.
pop ebx ; argc
pop ebx ; argv[0] (executable name)
pop ebx ; argv[1] (desired file name)
mov eax, 0x05 ; syscall number for open
xor ecx, ecx ; O_RDONLY = 0
xor edx, edx ; Mode is ignored when O_CREAT isn't specified
int 0x80 ; Call the kernel
test eax, eax ; Check the output of open()
jns file_read ; If the sign flag is set (positive) we can begin reading the file

; = If the output is negative, then open failed. So we should exit
exit:
mov eax, 0x01 ; 0x01 = syscall for exit
xor ebx, ebx ; makes ebx technically set to zero
int 0x80

; = Begin reading the file

file_read:
; read(int fd, void *buf, size_t count);
mov ebx, eax ; Move our file descriptor into ebx
mov eax, 0x03 ; syscall for read = 3
mov ecx, buffer ; Our 2kb byte buffer
mov edx, buflen ; The size of our buffer
int 0x80
test eax, eax ; Check for errors / EOF
jz file_out ; If EOF, then write our buffer out.
js exit ; If read failed, we exit.
; Didn't read the whole file, so just output what we got and be done with it.
; ^ This is blah and needs to be updated when I find out how

file_out:
; write(int fd, void *buf, size_t count);
mov edx, eax ; read returns amount of bytes read
mov eax, 0x04 ; syscall write = 4
mov ebx, 0x01 ; STDOUT = 1
mov ecx, buffer ; Move our buffer into the arguments
int 0x80
jmp exit ;