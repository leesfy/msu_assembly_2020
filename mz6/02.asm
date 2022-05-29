%include "io.inc"

section .data
inp1 db "%1000s", 0
outp1 db "1 2", 0
outp2 db "2 1", 0
outp3 db "0", 0


section .bss
str1 resb 1001
str2 resb 1001

section .text
global CMAIN
CEXTERN strlen
CEXTERN strstr

CMAIN:
    push ebp
    mov ebp, esp
    sub esp, 8
    and esp, ~15
    sub esp, 8
    push str1
    push inp1
    call scanf
    add esp, 8
    push str2
    push inp1
    call scanf
    add esp, 8
    push str2
    push str1
    call strstr
    test eax, eax
    jz .M
    push outp2
    call printf
    jmp .finish
.M:
    add esp, 8
    push str1
    push str2
    call strstr
    test eax, eax
    jz .end1
    push outp1
    call printf
    jmp .finish
.end1:
    push outp3
    call printf
    jmp .finish
.finish:
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
