%include "io.inc"

global CMAIN
CMAIN:
    GET_HEX 4, eax
    GET_HEX 4, ebx
    GET_HEX 4, ecx
    AND eax, ecx
    AND ecx, ebx
    XOR eax, ecx
    XOR eax, ebx
    PRINT_HEX 4, eax
    xor eax, eax
    ret
