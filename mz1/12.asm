%include "io.inc"

section .data 
    arr1 db "A23456789TJQK"
    arr2 db "SCDH"
    t dd 13    

global CMAIN
CMAIN:
    GET_DEC 4, eax
    mov ebx, eax
    xor edx, edx
    div dword[t]
    PRINT_CHAR [arr1 + edx]
    XOR edx, edx
    mov eax, ebx
    sub eax, 1
    div dword[t]
    PRINT_CHAR [arr2 + eax]
    xor eax, eax
    ret
