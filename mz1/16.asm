%include "io.inc"

section .bss
    a11 resd 1
    a12 resd 1
    a21 resd 1
    a22 resd 1
    b1 resd 1
    b2 resd 1
    tempy1 resd 1
    tempy2 resd 1
    tempx1 resd 1
    tempx2 resd 1
    ansx resd 1
    ansy resd 1
    
section .text
global CMAIN
CMAIN:
    GET_UDEC 4, [a11]
    GET_UDEC 4, [a12]
    GET_UDEC 4, [a21]
    GET_UDEC 4, [a22]
    GET_UDEC 4, [b1]
    GET_UDEC 4, [b2]
    
    mov eax, dword[b1]
    and eax, dword[a21]
    xor eax, dword[b2]
    mov dword[tempy1], eax
    
    mov eax, dword[b1]
    mov dword[tempy2], eax
    
    mov ebx, dword[a11]
    not ebx
    and eax, ebx
    mov ecx, dword[tempy1]
    and ecx, dword[a11]
    xor eax, ecx
    mov edx, dword[a11]
    or edx, dword[a12]
    not edx
    mov ecx, dword[a21]
    or ecx, dword[b1]
    not ecx
    and edx, ecx
    and edx, dword[a22]
    and edx, dword[b2]
    xor eax, edx
    mov dword[ansy], eax
    
    mov eax, dword[tempy1]
    and eax, dword[a12]
    xor eax, dword[b1]
    mov dword[tempx1], eax
    
    mov eax, dword[tempy2]
    and eax, dword[a22]
    xor eax, dword[b2]
    mov dword[tempx2], eax
    
    and ebx, dword[tempx2]
    mov eax, dword[a11]
    and eax, dword[tempx1]
    xor eax, ebx
    mov dword[ansx], eax

    PRINT_UDEC 4, [ansx]
    PRINT_CHAR ' '
    PRINT_UDEC 4, [ansy]  
    xor eax, eax
    ret
