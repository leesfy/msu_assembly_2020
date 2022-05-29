%include "io.inc"

section .data
    maxb dd 0

section .bss
    n resd 1
    k resd 1
    kstart resd 1
    temp resd 1
    temp2 resd 1
    res resd 1
    i resd 1
    j resd 1

section .text
global CMAIN
CMAIN:
    GET_DEC 4, [n]
    GET_DEC 4, [k]
    mov eax, dword[k]
    mov dword[kstart], eax
    xor ecx, ecx
    mov eax, dword[n]
    .L:
        cmp ecx, 31
        jg .T
        shr eax, 1
        inc ecx
        test eax, 1
        jz .L
        mov dword[maxb], ecx
        jmp .L
    .T: 
    mov ebx, dword[k]
    mov edx, dword[maxb]
    cmp edx, ebx
    jl .finish
    inc ebx
    call cform
    mov dword[res], eax
    
    mov edx, dword[maxb]
    mov eax, dword[n]
    dec edx
    call findb
    mov dword[j], eax
    mov dword[i], eax
    
    mov eax, dword[k]
    mov ebx, dword[maxb]
    sub ebx, dword[i]
    sub ebx, 1
    sub eax, ebx
    mov dword[k], eax
    .U:
    cmp dword[j], -1
    je .finish
    
    mov edx, dword[j]
    mov dword[i], edx
    dec edx
    mov eax, dword[n]
    call findb
    mov dword[j], eax
    
    mov ebx, dword[k]
    dec ebx
    mov edx, dword[i]
    call cform
    add eax, dword[res]
    mov dword[res], eax
    
    cmp dword[j], -1
    je .finish
    mov eax, dword[k]
    mov ebx, dword[i]
    sub ebx, dword[j]
    sub ebx, 1
    sub eax, ebx
    mov dword[k], eax
    
    jmp .U
    
    .finish:
    xor ecx, ecx
    xor edx, edx
    mov ebx, dword[maxb]
    mov eax, dword[n]
    .S:
        cmp ecx, ebx
        jg .A
        test eax, 1
        jnz .D
        inc edx
    .D:
        shr eax, 1
        inc ecx
        jmp .S
    
    .A:
        cmp edx, dword[kstart]
        jne .G
        inc dword[res]
    .G:
    PRINT_DEC 4, [res]
     xor eax, eax
    ret

cform:
    cmp ebx, edx
    jg F
    cmp ebx, 0
    jl F
    je L
    cmp edx, 0
    jl F
    je L
    cmp ebx, edx
    je L
    mov dword[temp], edx
    mov edi, ebx
    mov eax, ebx
    inc eax
    mov ebx, eax
    inc ebx
    mov ecx, ebx
    sub ecx, edi
    mov edi, eax
    N:
    cmp edi, dword[temp]
    jge M
    mul ebx
    div ecx
    inc edi
    inc ebx
    inc ecx
    jmp N
    L:
    mov eax, 1
    ret
    M:
    ret
    F:
    xor eax, eax
    ret 
    
findb:
    xor ecx, ecx
    mov ebx, -1
    W:
    cmp ecx, edx
    jg E
    test eax, 1
    jz Y
    mov ebx, ecx
    Y:
    shr eax, 1
    inc ecx
    jmp W
    E:
    mov eax, ebx
    ret
