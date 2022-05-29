%include "io.inc"

section .data
fin db "data.in", 0
rf db "r", 0
inp db "%u", 0
outp db "%d", 0

section .bss
numb resd 1

section .text
global CMAIN
CEXTERN fopen
CEXTERN fclose
CEXTERN fscanf
CEXTERN fprintf

CMAIN:
    push ebp
    mov ebp, esp
    sub esp, 8
    and esp, ~15
    sub esp, 8
    push rf
    push fin
    call fopen
    mov dword[ebp - 4], eax
    xor ebx, ebx
    add esp, 12
.Q:
    push numb
    push inp
    push dword[ebp - 4]
    call fscanf
    add esp, 12
    cmp eax, -1
    je .finish
    inc ebx
    jmp .Q
.finish:
    sub esp, 4
    push ebx
    push outp
    call printf
    add esp, 4
    push dword[ebp - 4]
    call fclose
    mov esp, ebp
    pop ebp
    ret
