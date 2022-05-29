%include "io.inc"

section .data
inp1 db "%s", 0
inp2 db "%d %d", 0 
outp1 db "%-*s", 0
outp2 db "%*d", 0 
outp3 db "%c", 0
max1 dd 0
max2 dd 0
max3 dd 0
pipe db "|", 0


section .bss
arr resd 250000
str1 resd 1000000

section .text
global CMAIN
CEXTERN malloc
CEXTERN calloc
CEXTERN strcmp
CEXTERN strncpy
CEXTERN strlen
CEXTERN qsort
CEXTERN free

CMAIN:
    push ebp
    mov ebp, esp
    sub esp, 8
    and esp, ~15
    xor ecx, ecx
.start:
    push ecx
    sub esp, 4
    push str1
    push inp1
    call scanf
    cmp eax, -1
    je .endc
    add esp, 12
    pop ecx
    mov eax, ecx
    shl eax, 2
    lea ebx, [arr + eax]
    push ecx
    sub esp, 8
    push str1
    call strlen
    cmp eax, dword[max1]
    jle .W
    mov dword[max1], eax
.W:
    add eax, 8
    add esp, 4
    push eax
    call malloc
    mov dword[ebx], eax
    mov ebx, dword[ebx]
    pop eax
    sub eax, 8
    add esp, 4
    push eax
    push 1
    call calloc
    mov dword[ebx], eax
    add esp, 4
    pop eax
    add esp, 4
    push eax
    push str1
    push dword[ebx]
    call strncpy
    add esp, 12
    lea eax, [ebx + 8]
    push eax
    lea eax, [ebx + 4]
    push eax
    push inp2
    call scanf
    add esp, 4
    push dword[ebx + 4]
    call lennum
    add esp, 4
    cmp eax, dword[max2]
    jle .R
    mov dword[max2], eax
.R:
    push dword[ebx + 8]
    call lennum
    add esp, 4
    cmp eax, dword[max3]
    jle .T
    mov dword[max3], eax
.T:
    add esp, 8
    pop ecx
    inc ecx
    jmp .start
.endc: 
    add esp, 12
    pop ecx
    push comp
    push 4
    push ecx
    push arr
    call qsort
    add esp, 4
    pop ecx
    add esp, 8
    xor edx, edx
.Y:
    cmp edx, ecx
    jge .U
    mov eax, edx
    shl eax, 2
    mov eax, dword[arr + eax]
    push ecx
    push edx
    push eax
    sub esp, 8
    push dword[eax]
    push dword[max1]
    push outp1
    call printf
    add esp, 4
    push pipe
    call printf
    mov eax, dword[esp + 20]
    add esp, 12
    push dword[eax + 4]
    push dword[max2]
    push outp2
    call printf
    add esp, 4
    push pipe
    call printf
    mov eax, dword[esp + 20]
    add esp, 12
    push dword[eax + 8]
    push dword[max3]
    push outp2
    call printf
    add esp, 8
    push 0xA
    push outp3
    call printf
    add esp, 24
    pop edx
    pop ecx
    inc edx
    jmp .Y
.U:
    xor edx, edx
    
.fr:
    cmp edx, ecx 
    jge .finish
    mov eax, edx
    shl eax, 2
    mov eax, dword[arr + eax]
    sub esp, 4
    push edx
    push ecx
    push dword[eax]
    call free
    add esp, 4
    pop ecx
    pop edx
    inc edx
    jmp .fr
.finish:
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
    
    
    
lennum:
    push ebp
    mov ebp, esp
    mov ecx, dword[ebp + 8]
    cmp ecx, 9
    jg .G2
    mov eax, 1
    jmp .endlen
.G2:
    cmp ecx, 99
    jg .G3
    mov eax, 2
    jmp .endlen
.G3:    
    cmp ecx, 999
    jg .G4
    mov eax, 3
    jmp .endlen
.G4:
    cmp ecx, 9999
    jg .G5
    mov eax, 4
    jmp .endlen
.G5:
    mov eax, 5    
.endlen:
    mov esp, ebp
    pop ebp
    ret
    
    
    
comp:
    push ebp
    push ebx
    mov ebp, esp
    mov eax, dword[ebp + 12]
    mov ecx, dword[ebp + 16]
    mov eax, dword[eax]
    mov ecx, dword[ecx]
    mov ebx, dword[eax + 8]
    mov edx, dword[ecx + 8]
    cmp ebx, edx
    jl .endgr
    jg .endless
    mov ebx, dword[eax + 4]
    mov edx, dword[ecx + 4]
    cmp ebx, edx
    jl .endless
    jg .endgr
    mov ebx, dword[eax]
    mov edx, dword[ecx]
    sub esp, 12
    push ebx
    push edx
    call strcmp
    add esp, 12
    neg eax
    jmp .endcmp    
.endless:
    mov eax, -1
    jmp .endcmp
.endgr:
    mov eax, 1
.endcmp:
    mov esp, ebp
    pop ebx
    pop ebp
    ret
