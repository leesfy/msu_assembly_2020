%include "io.inc"

section .text
global CMAIN
CMAIN:
    push ebp
    mov ebp, esp
    xor ecx, ecx
    push ecx
    .L:
    GET_DEC 4, eax
    test eax, eax
    jz .R
    push eax
    inc ecx
    jmp .L
    .R:
    mov dword[ebp-4], ecx
    push 0
    call foo
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
    
foo:
    mov edx, dword[ebp-4]
    mov eax, edx
    neg eax
    mov ecx, dword[ebp + 4*eax - 8]
    test edx, 1
    jz .T
    
    shr edx, 1
    inc edx
    inc ecx
    cmp ecx, edx
    jg .finish
    mov eax, ecx
    neg eax
    PRINT_DEC 4, [ebp + 4*2*eax]
    NEWLINE
    dec edx
    shl edx, 1
    inc edx
    mov eax, edx
    neg eax
    mov dword[ebp + 4*eax - 8], ecx
    call foo
    mov edx, dword[ebp-4]
    mov eax, edx
    neg eax
    mov ecx, dword[ebp + 4*eax - 8]
    cmp ecx, 1
    je .finish
    mov eax, ecx
    neg eax
    PRINT_DEC 4, [ebp + 8*eax + 4]
    NEWLINE
    dec ecx
    mov eax, edx
    neg eax
    mov dword[ebp + 4*eax - 8], ecx
    jmp .finish
    
    .T:
    shr edx, 1
    inc ecx
    cmp ecx, edx
    jg .finish
    mov eax, ecx
    neg eax
    PRINT_DEC 4, [ebp + 4*2*eax]
    NEWLINE
    shl edx, 1
    mov eax, edx
    neg eax
    mov dword[ebp + 4*eax - 8], ecx
    call foo
    mov edx, dword[ebp-4]
    mov eax, edx
    neg eax
    mov ecx, dword[ebp + 4*eax - 8]
    mov eax, ecx
    neg eax
    PRINT_DEC 4, [ebp + 8*eax - 4]
    NEWLINE
    dec ecx
    mov eax, edx
    neg eax
    mov dword[ebp + 4*eax - 8], ecx
    .finish:  
    ret
