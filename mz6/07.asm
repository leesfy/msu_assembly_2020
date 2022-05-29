%include "io.inc"

section .data
inp1 db "%10s", 0
inp2 db "%d", 0
el dd 11

section .bss
str1 resb 5500
str2 resb 11

section .text
global CMAIN
CEXTERN strncmp
CEXTERN strncpy

CMAIN:
    push ebp
    mov ebp, esp
    sub esp, 8
    and esp, ~15
    sub esp, 8
    lea ecx, [ebp - 4]
    push ecx
    push inp2
    call scanf
    mov ecx, dword[ebp - 4]
    add esp, 16
    xor edx, edx
    xor esi, esi
.L:    
    cmp ecx, edx
    jz .finish
    push ecx
    push edx
    push str2
    push inp1
    call scanf
    sub esp, 4
    xor edi, edi
    mov ebx, 1
.T:
    cmp edi, esi
    jz .P
    mov eax, edi
    xor edx, edx
    mul dword[el]
    lea eax, [str1 + eax]
    push 11
    push eax
    push str2
    call strncmp
    add esp, 12
    test eax, eax
    jnz .K
    xor ebx, ebx
.K:
    inc edi
    jmp .T
.P:
    test ebx, ebx
    jz .end1
    mov eax, esi
    xor edx, edx
    mul dword[el]
    lea eax, [str1 + eax]
    push 11
    push str2
    push eax
    call strncpy
    add esp, 12
    inc esi
.end1:
    add esp, 12
    pop edx
    pop ecx
    inc edx
    jmp .L
       
.finish:
    sub esp, 8
    push esi
    push inp2
    call printf
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
