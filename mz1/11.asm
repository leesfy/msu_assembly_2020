%include "io.inc"
   
global CMAIN
CMAIN:
    GET_CHAR eax
    GET_CHAR ebx
    mov ecx, 2
    sub eax, 'H'
    sub ebx, '8'
    NEG eax
    NEG ebx
    mul ebx
    xor edx, edx
    DIV ecx
    PRINT_DEC 4, eax
    xor eax, eax
    ret
