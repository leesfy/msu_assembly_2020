%include "io.inc"

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    GET_UDEC 4, eax
    GET_UDEC 4, ecx
    .T:
    push eax
    push ecx
    call check
    pop ecx
    pop ebx
    test eax, eax
    jnz .finish
    mov eax, ebx
    inc eax
    jmp .T
    .finish:
    PRINT_UDEC 4, ebx
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
check:
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
    jz .Q
    xor edx, edx
    div ecx
    push edx
    inc edi
    jmp .T
    .Q:
    test edi, 1
    jz .cond3
    inc edi
    push 0
    .cond3:
    shr edi, 1
    xor ecx, ecx
    xor esi, esi
    .cyc3:
    cmp ecx, edi
    jge .cond4
    pop eax
    add esi, eax
    inc ecx
    jmp .cyc3
    .cond4:
    xor ebx, ebx
    xor ecx, ecx
    .cyc4:
    cmp ecx, edi
    jge .end
    pop eax
    add ebx, eax
    inc ecx
    jmp .cyc4
    .end:
    cmp esi, ebx
    je .finish2
    xor eax, eax
    jmp .last
    .finish2:
    mov eax, dword[ebp + 12]
    .last:
    test edi, 1
    jnz .last2
    pop edx
    .last2:
    pop esi
    pop ebx
    pop ecx
    pop edi
    mov esp, ebp
    pop ebp
    ret
