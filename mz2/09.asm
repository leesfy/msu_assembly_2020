%include "io.inc"

section .bss
    x1 resd 1
    y1 resd 1
    x2 resd 1
    y2 resd 1
    x3 resd 1
    y3 resd 1
    x4 resd 1
    y4 resd 1
    xp resd 1
    yp resd 1
    xmin resd 1
    xmax resd 1
    ymin resd 1
    ymax resd 1

section .text
global CMAIN
CMAIN:
    GET_DEC 4, [x1]
    GET_DEC 4, [y1]
    GET_DEC 4, [x2]
    GET_DEC 4, [y2]
    GET_DEC 4, [x3]
    GET_DEC 4, [y3]
    GET_DEC 4, [x4]
    GET_DEC 4, [y4]
    GET_DEC 4, [xp]
    GET_DEC 4, [yp]
    mov ebx, dword[x1]
    mov ecx, dword[x2]
    call min
    mov edx, eax
    mov ebx, dword[x3]
    mov ecx, dword[x4]
    call min
    mov ebx, eax
    mov ecx, edx
    call min
    mov dword[xmin], eax
    
    mov ebx, dword[x1]
    mov ecx, dword[x2]
    call max
    mov edx, eax
    mov ebx, dword[x3]
    mov ecx, dword[x4]
    call max
    mov ebx, eax
    mov ecx, edx
    call max
    mov dword[xmax], eax
    
    mov ebx, dword[y1]
    mov ecx, dword[y2]
    call min
    mov edx, eax
    mov ebx, dword[y3]
    mov ecx, dword[y4]
    call min
    mov ebx, eax
    mov ecx, edx
    call min
    mov dword[ymin], eax
    
    mov ebx, dword[y1]
    mov ecx, dword[y2]
    call max
    mov edx, eax
    mov ebx, dword[y3]
    mov ecx, dword[y4]
    call max
    mov ebx, eax
    mov ecx, edx
    call max
    mov dword[ymax], eax
    
    mov eax, dword[xp]
    cmp eax, dword[xmin]
    jle .P
    cmp eax, dword[xmax]
    jge .P
    mov eax, dword[yp]
    cmp eax, dword[ymin]
    jle .P
    cmp eax, dword[ymax]
    jge .P
    .finish:
        PRINT_STRING "YES"
        jmp .W
    .P:
        PRINT_STRING "NO"
        jmp .W
    .W:
    xor eax, eax
    ret
    
 min:
    cmp ebx, ecx
    jl L
    mov eax, ecx
    jmp T
    L:
    mov eax, ebx
    T:
    ret
    
max:
    cmp ebx, ecx
    jg R
    mov eax, ecx
    jmp Q
    R:
    mov eax, ebx
    Q:
    ret
