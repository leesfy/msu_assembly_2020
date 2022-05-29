%include "io.inc"

section .bss
    t resd 1 
    
section .text
global CMAIN
CMAIN:
    GET_DEC 4, eax
    GET_DEC 4, ebx
    GET_DEC 4, ecx
    GET_DEC 4, edx
    GET_DEC 4, t
    imul ecx, dword[t]
    imul edx, dword[t]
    add eax, ecx
    add ebx, edx
    imul eax, dword[t]
    imul ebx, dword[t]
    PRINT_DEC 4, EAX
    PRINT_CHAR  ' '
    PRINT_DEC 4, EBX
    NEWLINE
    xor eax, eax
    ret
