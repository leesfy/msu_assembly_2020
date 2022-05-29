%include "io.inc"  

global CMAIN
CMAIN:
    GET_CHAR eax
    GET_CHAR ebx
    GET_CHAR ecx
    GET_CHAR ecx
    GET_CHAR edx
    sub eax, ecx
    sub ebx, edx
    xor ecx, ecx
    xor edx, edx
    mov ecx, eax
    mov edx, ebx
    sar ecx, 31
    sar edx, 31
    xor eax, ecx
    xor ebx, edx
    neg ecx
    neg edx
    add eax, ecx
    add ebx, edx
    add eax, ebx
    PRINT_DEC 4, eax
    xor eax, eax
    ret
