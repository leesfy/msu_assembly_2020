%include "io.inc"

section .data
    a times 32 dd 0
    b times 32 dd 0
    c times 65 dd 0
    d times 65 dd 0
    f times 131 dd 0
    ten dd 10

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    xor esi, esi
    GET_DEC 4, eax
    cmp eax, 0
    jg .N
    inc esi
    neg eax
    .N:
    push eax
    push a
    call cpy
    add esp, 8
    GET_DEC 4, ebx
    cmp ebx, 0
    jg .B
    inc esi
    neg ebx
    .B:
    push ebx
    push b
    call cpy
    add esp, 8
    GET_DEC 4, ecx
    cmp ecx, 0
    jg .V
    inc esi
    neg ecx
    .V:
    push ecx
    push c
    call cpy
    add esp, 8
    push a
    push b
    push d
    push 32
    call mult
    add esp, 16
    push d
    push c
    push f
    push 65
    call mult
    add esp, 16
    xor edi, edi
    mov edi, 130
    .K:
    mov eax, dword[f + 4*edi]
    test eax, eax
    jnz .ex
    dec edi
    jmp .K
    .ex:
    test esi, 1
    jz .Loop
    PRINT_CHAR '-'
    .Loop:
    cmp edi, 0
    jl .ex2
    mov eax, dword[f + 4*edi]
    PRINT_DEC 4, eax
    dec edi
    jmp .Loop
    .ex2:
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
    
cpy:
    push ebp
    mov ebp, esp
    push edi
    push ebx
    xor edi, edi
    mov ebx, dword[ebp + 8]
    mov eax, dword[ebp + 12]
    .T:
    test eax, eax
    jz .end1
    xor edx, edx
    div dword[ten]
    mov dword[ebx + 4*edi], edx
    inc edi
    jmp .T
    .end1:
    pop ebx
    pop edi
    mov esp, ebp
    pop ebp
    ret
    
    
mult:
    push ebp
    mov ebp, esp
    push edi
    push esi
    push ebx
    mov ecx, dword[ebp + 8]
    mov eax, dword[ebp + 12]
    mov ebx, dword[ebp + 16]
    mov edx, dword[ebp + 20]
    xor esi, esi
    xor edi, edi
    .cyc1:
    cmp esi, ecx
    jge .finish1
    .cyc2:
    cmp edi, ecx
    jge .finish2
    push eax
    mov eax, dword[edx + 4*edi]
    push edx
    mul dword[ebx + 4*esi]
    mov edx, eax
    mov eax, dword[esp + 4]
    push esi
    add esi, edi
    add dword[eax + 4*esi], edx
    pop esi
    pop edx
    add esp, 4
    inc edi
    jmp .cyc2
    .finish2:
    xor edi, edi
    inc esi
    jmp .cyc1
    
    .finish1:
    shl ecx, 1
    xor esi, esi
    inc ecx
    .R:
    cmp esi, ecx
    jge .end
    push eax
    mov eax, dword[eax+4*esi]
    xor edx, edx
    div dword[ten]
    mov edi, eax
    pop eax
    mov dword[eax + 4*esi], edx
    add dword[eax+4*esi +4], edi
    inc esi
    jmp .R
    .end:
    xor edi, edi
    .end2:
    pop ebx
    pop esi
    pop edi
    mov esp, ebp
    pop ebp
    ret
