%include "io.inc"
 
section .data
    inp1 db "%u ", 0
    outp1 db "0x%08X", 0xA, 0

section .bss
    num resd 1
 
section .text 
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    sub esp, 8
    and esp, ~15
    sub esp, 8
.Q:
    push num
    push inp1
    call scanf
    cmp eax, -1
    je .finish
    add esp, 8
    push dword[num]
    push outp1
    call printf
    add esp, 8
    jmp .Q
.finish:
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
