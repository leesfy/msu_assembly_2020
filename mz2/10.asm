%include "io.inc"

section .bss
    n resd 1
    ntr resd 1

section .data
    max dd 1

section .text
global CMAIN
CMAIN:
    GET_DEC 4, eax
    mov dword[n], eax
    mov ecx, 2
    cdq
    div ecx
    test edx, edx
    jnz .test2
    mov dword[max], eax
    jmp .finish
    .test2:
        mov ecx, 3
        mov eax, dword[n]
        cdq
        div ecx
        mov dword[ntr], eax
        test edx, edx
        mov ecx, 5
        jnz .L
        mov dword[max], eax
        jmp .finish
    .L:
        xor edx, edx
        cmp ecx, dword[ntr]
        jge .finish
        mov eax, dword[n]
        cdq
        div ecx
        test edx, edx
        jnz .T
        mov dword[max], ecx
    .T:
        add ecx, 2
        jmp .L
    .finish:
        PRINT_DEC 4, [max]
    xor eax, eax
    ret
