%include "io.inc"

section .text
global CMAIN
CMAIN:
    xor ecx, ecx
    GET_UDEC 4, eax
    .L:
        test eax, eax
        jz .R
        test eax, 1
        jz .T
        INC ECX
        
        
    .T: 
    shr eax, 1
    jmp .L
    .R:
    PRINT_UDEC 4, ECX
    xor eax, eax
    ret
