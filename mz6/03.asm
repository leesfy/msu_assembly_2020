%include "io.inc"

section .data
inp1 db "%100s", 0
outp db "%.*s", 0
outp1 db "%c", 0

section .bss
str1 resb 101
str2 resb 101

section .text
global CMAIN
CEXTERN strlen
CEXTERN strstr

CMAIN:
    push ebp
    mov ebp, esp
    sub esp, 8
    and esp, ~15
    sub esp, 8
    push str1
    push inp1
    call scanf
    add esp, 8
    push str2
    push inp1
    call scanf
    mov dword[esp], str1
    call strlen
    mov dword[ebp - 4], eax
    mov dword[esp], str2
    call strlen
    mov dword[ebp - 8], eax
    add esp, 8
    push str2
    push str1
    call strstr
    test eax, eax
    jz .M
    mov ebx, eax
    sub esp, 4
    push str1
    sub ebx, str1
    push ebx
    push outp
    call printf
    add esp, 8
    push '['
    push outp1
    call printf
    add esp, 12
    push str2
    push dword[ebp - 8]
    push outp
    call printf
    add esp, 8
    push ']'
    push outp1
    call printf
    add esp, 12
    mov eax, str1
    add eax, ebx
    add eax, dword[ebp - 8]
    push eax
    mov ecx, dword[ebp - 4]
    sub ecx, dword[ebp - 8]
    sub ecx, ebx
    push ecx
    push outp
    call printf
    jmp .finish
.M:
    add esp, 8
    push str1
    push str2
    call strstr
    test eax, eax
    jz .end1
    mov ebx, eax
    sub esp, 4
    push str2
    sub ebx, str2
    push ebx
    push outp
    call printf
    add esp, 8
    push '['
    push outp1
    call printf
    add esp, 12
    push str1
    push dword[ebp - 4]
    push outp
    call printf
    add esp, 8
    push ']'
    push outp1
    call printf
    add esp, 12
    mov eax, str2
    add eax, ebx
    add eax, dword[ebp - 4]
    push eax
    mov ecx, dword[ebp - 8]
    sub ecx, dword[ebp - 4]
    sub ecx, ebx
    push ecx
    push outp
    call printf
    jmp .finish
.end1:
    sub esp, 4
    push str1
    push dword[ebp - 4]
    push outp
    call printf
    jmp .finish
.finish:
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
