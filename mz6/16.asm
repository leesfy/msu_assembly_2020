%include "io.inc"

section .data
fin db "input.txt", 0
fout db "output.txt", 0
rf db "r", 0
wf db "w", 0
inp1 db "%100s", 0
inp2 db "%u", 0xA, 0
outp1 db "%d", 0xA, 0

section .bss
key resb 101
data resd 1
n resd 1
m resd 1
op resd 1

section .text
global CMAIN
CEXTERN malloc
CEXTERN free
CEXTERN strncpy
CEXTERN strncmp
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
    add esp, 8
    push wf
    push fout
    call fopen
    mov dword[ebp - 8], eax
    add esp, 12
    push n
    push inp2
    push dword[ebp - 4]
    call fscanf 
    add esp, 16
    xor ecx, ecx
    xor ebx, ebx
.Q:
    cmp ecx, dword[n]
    jge .T
    push ecx
    push key
    push inp1
    push dword[ebp - 4]
    call fscanf
    add esp, 12
    push data
    push inp2
    push dword[ebp - 4]
    call fscanf
    add esp, 12
    push dword[data]
    push key
    push ebx
    call addit
    mov ebx, eax
    add esp, 12
    pop ecx
    inc ecx
    jmp .Q
.T:
    sub esp, 4
    push m
    push inp2
    push dword[ebp - 4]
    call fscanf
    add esp, 16
    xor ecx, ecx
.P:
    cmp ecx, dword[m]
    jge .end1
    push ecx
    push key
    push inp1
    push dword[ebp - 4]
    call fscanf
    add esp, 12
    push dword[ebp - 8]
    push key
    push ebx
    call search
    add esp, 12
    pop ecx   
    inc ecx
    jmp .P
.end1:
    sub esp, 12
    push dword[ebp - 4]
    call fclose
    add esp, 4
    push dword[ebp - 8]
    call fclose
    add esp, 4
    push ebx
    xor ebx, ebx
    call freetree
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret
    
    

addit:
    push ebp
    mov ebp, esp
    mov eax, dword[ebp + 8]  ; head
    test eax, eax            ; head == NULL
    jnz .W
    push 112
    call malloc   ; eax = head
    mov ecx, dword[ebp + 12]  ; key
    sub esp, 4
    push 100
    push ecx
    push eax
    call strncpy
    mov ecx, dword[ebp + 16]
    mov dword[eax + 100], ecx   ; head->data = data
    xor ecx, ecx
    mov dword[eax + 104], ecx   ; head->left = NULL
    mov dword[eax + 108], ecx  ; head->right = NULL
    jmp .enda
.W:
    test eax, eax
    jz .K
    mov ecx, dword[ebp + 12]
    sub esp, 12
    push 100
    push ecx
    push eax
    call strncmp
    cmp eax, 0                 ; head->key ? key
    jg .R
.E: 
    pop eax
    add esp, 20
    mov edx, eax
    mov eax, dword[eax + 108]
    jmp .W
.R:
    pop eax
    add esp, 20
    mov edx, eax
    mov eax, dword[eax + 104]
    jmp .W
.K:
    push edx
    push 112
    call malloc   ; eax = head
    add esp, 4
    pop edx
    mov ecx, dword[ebp + 12]  ; key
    sub esp, 8
    push eax
    push 100
    push ecx
    push edx
    call strncmp
    pop edx
    cmp eax, 0                 ; head->key ? key
    jl .H
    add esp, 8
    pop eax
    mov dword[edx + 104], eax
    jmp .G
.H:
    add esp, 8
    pop eax
    mov dword[edx + 108], eax
.G:
    mov ecx, dword[ebp + 12]  ; &key
    sub esp, 4
    push 100
    push ecx
    push eax
    call strncpy
    pop eax
    add esp, 12
    mov ecx, dword[ebp + 16]
    mov dword[eax + 100], ecx   ; head->data = data
    xor ecx, ecx
    mov dword[eax + 104], ecx   ; head->left = NULL
    mov dword[eax + 108], ecx  ; head->right = NULL
    mov eax, dword[ebp + 8]
.enda: 
    mov esp, ebp
    pop ebp
    ret
  

search:
    push ebp
    mov ebp, esp
    mov eax, dword[ebp + 8]
.N:
    test eax, eax
    jz .ends
    mov ecx, dword[ebp + 12]
    sub esp, 12
    push 100
    push ecx
    push eax
    call strncmp
    cmp eax, 0         ; head->key ? key
    jl .Y
    jg .U
    pop eax
    add esp, 8
    mov ecx, dword[ebp + 16]
    push dword[eax + 100]
    push inp2
    push ecx
    call fprintf
    jmp .end1
.Y:
    pop eax
    add esp, 20
    mov eax, dword[eax + 108]
    jmp .N
.U:
    pop eax
    add esp, 20
    mov eax, dword[eax + 104]  
    jmp .N  
.ends:
    mov eax, -1
    mov ecx, dword[ebp + 16]
    push eax
    push outp1
    push ecx
    call fprintf
    
.end1:
    mov esp, ebp
    pop ebp
    ret
    
    
freetree:
    push ebp
    mov ebp, esp
    mov eax, dword[ebp + 8]
    test eax, eax
    jz .endfr
    sub esp, 4
    push dword[eax + 104]
    call freetree
    add esp, 4
    mov eax, dword[ebp + 8]
    push dword[eax + 108]
    call freetree
    add esp, 4
    push dword[ebp + 8]
    call free   
.endfr:
    mov esp, ebp
    pop ebp
    ret
