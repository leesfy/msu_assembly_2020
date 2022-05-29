%include "io.inc"

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    GET_UDEC 4, ecx
    .L:
    test ecx, ecx
    jz .W
    GET_UDEC 4, eax
    push ecx
    push eax
    call check
    add esp, 4
    pop ecx
    dec ecx
    jmp .L
    .W:
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
check:
    push ebp
    mov ebp, esp
    push esi
    xor ecx, ecx
    xor edx, edx
    xor esi, esi
    mov eax, dword[ebp + 8]
    .T:
    test eax, eax
    jz .Y
    test esi, 1
    jz .S
    test eax, 1
    jz .M
    inc edx
    jmp .M
    .S:
    test eax, 1
    jz .M
    inc ecx
    .M:
    shr eax, 1
    inc esi
    jmp .T
    .Y:
    cmp  ecx, edx
    jg .E
    je .finish1
    sub edx, ecx
    .cmp1:
    cmp edx, 0
    je .finish1
    jl .finish2
    sub edx, 3
    jmp .cmp1
    .E:
    sub ecx, edx
    .cmp2:
    cmp ecx, 0
    je .finish1
    jl .finish2
    sub ecx, 3
    jmp .cmp2
    .finish1:
    PRINT_STRING "YES"
    NEWLINE
    jmp .end
    .finish2:
    PRINT_STRING "NO"
    NEWLINE
    .end:
    pop esi
    mov esp, ebp
    pop ebp
    ret
