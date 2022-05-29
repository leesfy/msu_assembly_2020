%include "io.inc"

section .data
    numb dd 2011

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    GET_UDEC 4, ebx
    GET_UDEC 4, ecx
    GET_UDEC 4, eax
    xor edx, edx
    div dword[numb]
    mov eax, edx
    .L:
    test ecx, ecx
    jz .R
    mul eax
    push ecx
    push eax
    push ebx
    cmp ebx, 2
    jne .Y
    call vers2
    jmp .U
    .Y:
    call vers
    .U:
    add esp, 8
    pop ecx
    xor edx, edx
    div dword[numb]
    mov eax, edx
    dec ecx
    jmp .L
    .R:
    PRINT_UDEC 4, eax
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
vers:
    push ebp
    mov ebp, esp
    push edi
    push ecx
    push ebx
    push esi
    xor edi, edi
    xor esi, esi
    mov ecx, dword[ebp + 8]
    mov eax, dword[ebp + 12]
    .T:
    test eax, eax
    jz .end1
    xor edx, edx
    div ecx
    push edx
    inc edi
    jmp .T
    .end1:
    xor ebx, ebx
    mov esi, 1
    .T2:
    test edi, edi
    jz .end2
    pop eax
    mul esi
    add ebx, eax
    imul esi, ecx
    dec edi
    jmp .T2
    .end2:
    mov eax, ebx
    pop esi
    pop ebx
    pop ecx
    pop edi
    mov esp, ebp
    pop ebp
    ret
    
vers2:
    push ebp
    mov ebp, esp
    push edi
    push ecx
    push ebx
    push esi
    xor edi, edi
    xor esi, esi
    mov ecx, dword[ebp + 8]
    mov eax, dword[ebp + 12]
    .T3:
    test eax, eax
    jz .end3
    xor edx, edx
    shr eax, 1
    adc edx, 0
    push edx
    inc edi
    jmp .T3
    .end3:
    xor ebx, ebx
    xor eax, eax
    mov esi, edi
    shl esi, 2
    .T4:
    test  edi, edi
    je .end4
    mov ebx, dword[esp + 4*edi - 4]
    or eax, ebx
    shl eax, 1
    dec edi
    jmp .T4
    .end4:
    shr eax, 1
    add esp, esi
    pop esi
    pop ebx
    pop ecx
    pop edi
    mov esp, ebp
    pop ebp
    ret
