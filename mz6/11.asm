%include "io.inc"

section .data
fin db "input.txt", 0
fout db "output.txt", 0
rf db "r", 0
wf db "w", 0
inp db "%d %d", 0
outp db "%d ", 0

section .bss
n resd 1
m resd 1
a resd 1
b resd 1

section .text
global CMAIN
CEXTERN calloc
CEXTERN malloc
CEXTERN free
CEXTERN fopen
CEXTERN fclose
CEXTERN fscanf
CEXTERN fprintf

CMAIN:
    push ebp
    mov ebp, esp
    sub esp, 8
    and esp, ~15
    sub esp, 8
    push rf
    push fin
    call fopen
    mov dword[ebp - 4], eax
    add esp, 16
    push m
    push n
    push inp
    push dword[ebp - 4]
    call fscanf
    add esp, 8
    mov eax, dword[n]
    inc eax
    push 12
    push eax
    call calloc
    mov dword[ebp - 8], eax
    mov ecx, 1
.Q:
    cmp ecx, dword[n]
    jg .W
    mov eax, dword[ebp - 8]  ; arr
    mov eax, dword[eax + 4]  ; arr[1]
    test eax, eax
    jz .E
    push ecx
    push 12
    call malloc
    add esp, 4
    pop ecx
    mov ebx, dword[ebp - 8]  ; arr
    mov esi, ecx
    dec esi
    shl esi, 2    ; esi = 4*(i - 1)
    mov ebx, dword[ebx + esi]  ; arr[i - 1]
    mov dword[ebx + 4], eax    ; *(arr[i - 1] + 4) = arr[i - 1]->next = malloc(struct)
    mov ebx, dword[ebx + 4]    ; arr[i - 1]->next
    mov dword[ebx], ecx        ; arr[i - 1]->next->data = i
    mov dword[ebx + 4], 0      ; arr[i - 1]->next->next = NULL
    mov edi, dword[ebp - 8]    ; arr
    mov edi, dword[edi + esi]  ; arr[i - 1]
    mov dword[ebx + 8], edi    ; arr[i - 1]->next->prev = arr[i - 1]
    mov edi, dword[edi + 4]    ; arr[i - 1]->next
    mov ebx, dword[ebp - 8]    ; arr
    mov esi, ecx
    shl esi, 2
    mov dword[ebx + esi], edi  ; arr[i] = arr[i - 1]->next
    jmp .end1
.E:
    add esp, 8
    push ecx
    push 12
    call malloc
    add esp, 4
    pop ecx
    mov ebx, dword[ebp - 8]  ; arr
    mov dword[ebx + 4], eax  ; *(arr + 1*4) = arr[1] = malloc(struct)
    mov ebx, dword[ebx + 4]  ;  arr[1]
    mov dword[ebx], ecx      ; *(arr[1]) = arr[1]->data = i
    mov dword[ebx + 4], 0    ; *(arr[1] + 4) = arr[1]->next = NULL
    mov dword[ebx + 8], 0    ; *(arr[1] + 8) = arr[1]->prev = NULL
.end1:
    inc ecx
    jmp .Q
.W:
    mov edx, dword[ebp - 8]  ; arr
    mov edx, dword[edx + 4]  ; arr[1]    
    xor ecx, ecx
.R:
    cmp ecx, dword[m]
    jge .T
    push ecx
    push edx
    push b
    push a
    push inp
    push dword[ebp - 4]
    call fscanf
    add esp, 16
    pop edx
    pop ecx
    mov ebx, dword[ebp - 8]  ; arr
    mov esi, dword[a]
    shl esi, 2    ; esi = 4*a
    mov ebx, dword[ebx + esi]  ; arr[a]
    mov ebx, dword[ebx + 8]    ; arr[a]->prev
    test ebx, ebx
    jz .end2
    mov eax, dword[ebp - 8]  ; arr
    mov esi, dword[b]
    shl esi, 2    ; esi = 4*b
    mov eax, dword[eax + esi]  ; arr[b]
    mov eax, dword[eax + 4]    ; arr[b]->next
    mov dword[ebx + 4], eax    ; arr[a]->prev->next = arr[b]->next
    test eax, eax
    jz .A
    mov dword[eax + 8], ebx    ;arr[b]->next->prev = arr[a]->prev
.A:
    mov ebx, dword[ebp - 8]  ; arr
    mov esi, dword[a]
    shl esi, 2    ; esi = 4*a
    mov ebx, dword[ebx + esi]  ; arr[a]
    mov eax, dword[ebp - 8]  ; arr
    mov esi, dword[b]
    shl esi, 2    ; esi = 4*b
    mov eax, dword[eax + esi]  ; arr[b]
    mov dword[eax + 4], edx    ; arr[b]->next = temph
    mov dword[edx + 8], eax    ; temph->prev = arr[b]
    mov dword[ebx + 8], 0      ; arr[a]->prev = NULL
    mov edx, ebx               ; head = arr[a]
.end2:
    inc ecx
    jmp .R
.T:
    push edx
    push dword[ebp-4]
    call fclose
    mov edx, dword[esp + 4]
    add esp, 12
    push edx
    push wf
    push fout
    call fopen
    add esp, 8
    pop edx
    mov dword[ebp - 4], eax
    add esp, 4
    mov ebx, edx
.Y:
    test edx, edx
    jz .U
    push edx
    push dword[edx]
    push outp
    push dword[ebp - 4]
    call fprintf
    add esp, 12
    pop edx
    mov edx, dword[edx + 4]
    jmp .Y 
.U:
    sub esp, 12
    push dword[ebp - 4]
    call fclose
    add esp, 8
.I:
    mov eax, dword[ebx + 4]
    test eax, eax
    jz .O
    push eax
    push ebx
    call free
    add esp, 4
    pop eax
    mov ebx, eax
    jmp .I
.O:
    sub esp, 4
    mov eax, dword[ebp - 8]
    push dword[eax]
    call free
    mov esp, ebp
    pop ebp
    ret
