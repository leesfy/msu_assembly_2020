%include "io.inc"

section .data
inp1 db "%c", 0
inp2 db "%d", 0xA, 0
inp3 db "%d %d", 0xA, 0

section .bss
key resd 1
data resd 1
op resd 1

section .text
global CMAIN
CEXTERN malloc
CEXTERN free

CMAIN:
    push ebp
    mov ebp, esp
    sub esp, 8
    and esp, ~15
    sub esp, 8
    xor ebx, ebx
.Q:
    push op
    push inp1
    call scanf
    cmp dword[op], 'F'
    je .end1
    cmp dword[op], 'A'
    jne .S
    add esp, 12
    push data
    push key
    push inp3
    call scanf
    add esp, 12
    push dword[data]
    push dword[key]
    push ebx
    call addit
    mov ebx, eax
    add esp, 8
    jmp .Q
.S:
    cmp dword[op], 'S'
    jne .D
    add esp, 8
    push key
    push inp2
    call scanf
    add esp, 8
    push dword[key]
    push ebx
    call search
    add esp, 8
    jmp .Q
.D:
    cmp dword[op], 'D'
    jne .Q
    add esp, 8
    push key
    push inp2
    call scanf
    add esp, 8
    push dword[key]
    push ebx
    call del
    add esp, 8
    jmp .Q 
.end1:
    add esp, 4
    push ebx
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
    sub esp, 4
    push 20
    call malloc   ; eax = head
    mov ecx, dword[ebp + 12]
    mov dword[eax], ecx       ; head->key = key
    mov ecx, dword[ebp + 16]
    mov dword[eax + 4], ecx   ; head->data = data
    xor ecx, ecx
    mov dword[eax + 8], ecx   ; head->left = NULL
    mov dword[eax + 12], ecx  ; head->right = NULL
    mov dword[eax + 16], ecx  ; head->ex = 0
    jmp .enda
.W:
    test eax, eax
    jz .K
    mov ecx, dword[ebp + 12]
    cmp ecx, dword[eax]        ; key ? head->key
    jl .E
    jg .R
    mov ecx, dword[ebp + 16]
    mov dword[eax + 4], ecx
    xor ecx, ecx
    mov dword[eax + 16], ecx
    mov eax, dword[ebp + 8]
    jmp .enda 
.E: 
    mov edx, eax
    mov eax, dword[eax + 8]
    jmp .W
.R:
    mov edx, eax
    mov eax, dword[eax + 12]
    jmp .W
.K:
    push edx
    push 20
    call malloc   ; eax = head
    add esp, 4
    pop edx
    mov ecx, dword[ebp + 12]
    cmp ecx, dword[edx]
    jl .H
    mov dword[edx + 12], eax
    jmp .G
.H:
    mov dword[edx + 8], eax
.G:
    mov ecx, dword[ebp + 12]
    mov dword[eax], ecx       ; head->key = key
    mov ecx, dword[ebp + 16]
    mov dword[eax + 4], ecx   ; head->data = data
    xor ecx, ecx
    mov dword[eax + 8], ecx   ; head->left = NULL
    mov dword[eax + 12], ecx  ; head->right = NULL
    mov dword[eax + 16], ecx  ; head->ex = 0
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
    cmp ecx, dword[eax]
    jl .Y
    jg .U
    mov ecx, dword[eax + 16]
    test ecx, ecx
    jnz .ends 
    sub esp, 12
    push dword[eax + 4]
    push dword[eax]
    push inp3
    call printf
    jmp .ends
.Y:
    mov eax, dword[eax + 8]
    jmp .N
.U:
    mov eax, dword[eax + 12]  
    jmp .N  
.ends:
    mov esp, ebp
    pop ebp
    ret


search2:
    push ebp
    mov ebp, esp
    mov eax, dword[ebp + 8]
.M:
    test eax, eax
    jz .ends21
    mov ecx, dword[ebp + 12]
    cmp ecx, dword[eax]
    jl .Y1
    jg .U1
    mov ecx, dword[eax + 16]
    test ecx, ecx
    jz .ends21
    xor eax, eax
    jmp .ends21
.Y1:
    mov eax, dword[eax + 8]
    jmp .M
.U1:
    mov eax, dword[eax + 12]  
    jmp .M
.ends21:
    mov esp, ebp
    pop ebp
    ret
     
del:
    push ebp
    mov ebp, esp
    mov ecx, dword[ebp + 8]
    mov edx, dword[ebp + 12]
    push edx
    push ecx
    call search2
    add esp, 8
    test eax, eax
    jz .endd
    mov ecx, 1
    mov dword[eax + 16], ecx
.endd:
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
    push dword[eax + 8]
    call freetree
    add esp, 4
    mov eax, dword[ebp + 8]
    push dword[eax + 12]
    call freetree
    add esp, 4
    push dword[ebp + 8]
    call free    
.endfr:
    mov esp, ebp
    pop ebp
    ret
