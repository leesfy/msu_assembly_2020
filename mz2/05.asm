%include "io.inc"

section .bss
    t resd 1
   new resd 1
 
section .data
   max dd 0
   templen dd 1

section .text
global CMAIN
CMAIN:
    GET_UDEC 4, ecx
    test ecx, ecx
    je .final 
    GET_UDEC 4, [t]
    dec ecx 
    .L:
        test ecx, ecx
        jle .R
        GET_UDEC 4, [new]
        mov ebx, dword[t]
        cmp dword[new], ebx
        jle .T
        inc dword[templen]
        jmp .Y
    .T:
       mov ebx, dword[max]
       cmp dword[templen], ebx
       jle .Q
       mov edx, dword[templen]
       mov dword[max], edx
    .Q:
       mov dword[templen], 1
    .Y:   
       mov edx, dword[new]
       mov dword[t], edx 
       dec ecx
       jmp .L
    .R:    
        mov ebx, dword[max]
        cmp dword[templen], ebx
        jle .final
        mov edx, dword[templen]
        mov dword[max], edx
    .final:    
        PRINT_DEC 4, [max] 
    xor eax, eax
    ret
