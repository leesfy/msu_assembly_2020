%include "io.inc"

section .rodata
fin db "input.bin", 0
fout db "output.bin", 0
rb db "rb", 0
wb db "wb", 0
outp db "%d", 0

section .data
one dd 1

section .bss
arr resd 1048576

section .text
global CMAIN
CEXTERN fopen
CEXTERN fclose
CEXTERN fread
CEXTERN fwrite

CMAIN:
    push ebp
    mov ebp, esp
    sub esp, 8
    and esp, ~15
    sub esp, 8
    push rb
    push fin
    call fopen
    add esp, 4
    mov dword[ebp-4], eax
    xor ecx, ecx
.T:
    mov eax, ecx
    shl eax, 2
    lea eax, [arr + eax]
    push ecx
    push dword[ebp - 4]
    push 1
    push 4
    push eax
    call fread
    add esp, 16
    pop ecx
    cmp eax, 1
    jne .R
    inc ecx
    jmp .T
.R:
    ;PRINT_DEC 4, ECX
    ;NEWLINE
    add esp, 4
    push ecx
    push dword[ebp-4]
    call fclose
    sub esp, 8
    push wb
    push fout
    call fopen
    mov dword[ebp-4], eax
    add esp, 20
    pop ecx
    xor eax, eax
    xor esi, esi
    cmp ecx, 1
    cmovg eax, dword[one]
    mov ebx, dword[arr]
    cmp ebx, dword[arr + 4]
    cmovg esi, dword[one]
    and eax, esi
    ;PRINT_DEC 4, eax
    ;NEWLINE
    test eax, eax
    jz .W
    push ecx
    push arr
    call decr
    push dword[ebp - 4]
    push 1
    push 4
    mov dword[one], eax
    push one
    call fwrite
    jmp .finish
.W:
    push ecx
    push arr
    call incr
    push dword[ebp - 4]
    push 1
    push 4
    mov dword[one], eax
    push one
    call fwrite
.finish:
    xor eax, eax
    add esp, 4
    push dword[ebp-4]
    call fclose
    mov esp, ebp 
    pop ebp
    ret
    
   
incr:
    push ebp
    push ebx
    push esi
    push edi
    mov ebp, esp
    mov ecx, dword[ebp + 12]
    mov ebx, dword[ebp + 8]
    mov eax, 1
    xor esi, esi
.Q:
    mov ebx, dword[ebp + 8]
    mov edi, esi
    shl edi, 1
    inc edi
    cmp edi, ecx
    jge .end1
    mov edx, dword[ebx + 4 * edi]
    push edi
    xor edi, edi
    mov ebx, dword[ebx + 4 * esi]
    cmp edx, ebx
    cmovge edi, dword[one]
    and eax, edi
    pop edi
    inc edi
    cmp edi, ecx
    jge .Y
    mov ebx, dword[ebp + 8]
    mov edx, dword[ebx + 4 * edi]
    push edi
    xor edi, edi
    mov ebx, dword[ebx + 4 * esi]
    cmp edx, ebx
    cmovge edi, dword[one]
    and eax, edi
    pop edi
.Y:   
    inc esi
    jmp .Q
.end1:    
    mov esp, ebp
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    
    
decr:
    push ebp
    mov ebp, esp
    
    mov ecx, dword[ebp + 12]
    mov ebx, dword[ebp + 8]
    mov eax, 1
    xor esi, esi
.P:
    mov ebx, dword[ebp + 8]
    mov edi, esi
    shl edi, 1
    inc edi
    cmp edi, ecx
    jge .end2
    mov edx, dword[ebx + 4 * edi]
    push edi
    xor edi, edi
    mov ebx, dword[ebx + 4 * esi]
    cmp edx, ebx
    cmovle edi, dword[one]
    and eax, edi
    pop edi
    inc edi
    cmp edi, ecx
    jge .U
    mov ebx, dword[ebp + 8]
    mov edx, dword[ebx + 4 * edi]
    push edi
    xor edi, edi
    mov ebx, dword[ebx + 4 * esi]
    cmp edx, ebx
    cmovle edi, dword[one]
    and eax, edi
    pop edi
.U:   
    inc esi
    jmp .P
.end2:
    cmp eax, 1
    jne .finish2
    neg eax
.finish2:    
    mov esp, ebp
    pop ebp
    ret
