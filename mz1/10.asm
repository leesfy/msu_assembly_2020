%include "io.inc"

section .data
    t dd 2

section .text
global CMAIN
CMAIN:
    GET_DEC 4, eax
    GET_DEC 4, ebx
    xor edx, edx
    div dword[t]
    xor edx, 1
    imul eax, 83
    imul edx, 42
    sub eax, edx
    add eax, ebx
    PRINT_DEC 4, eax
    xor eax, eax
    ret
