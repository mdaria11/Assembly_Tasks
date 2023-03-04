section .text
	global par

;; int par(int str_length, char* str)
;
; check for balanced brackets in an expression
par:

	pop ebx ;luam return_addr

	pop ecx ; luam str_length

	pop edx ; luam *str

	xor eax, eax

	xor esi, esi

	xor edi, edi

next_char:

	cmp [edx+eax], byte '(' ; vedem daca caracterul este '('

	je first_par

	inc edi ; incrementam nr de paranteze ')'

	cmp esi, edi ; daca nr de paranteze ')' este mai mare decat cele '('->imposibil

	jl impossible

	jmp next_step

first_par:

	inc esi ; incrementam nr de paranteze '('

	cmp esi, edi

	jl impossible ; daca nr de paranteze ')' este mai mare decat cele '('->imposibil

	jmp next_step

impossible:

	xor eax, eax ; returnam 0

	jmp stop

next_step:

	inc eax

	cmp eax, ecx ; vedem daca mai avem caractere de citit

	jl next_char

	cmp esi, edi ; la final nr de paranteze '(' trebuie sa fie egala cu nr de ')'

	jne impossible

	xor eax, eax

	inc eax ; returnam 1

stop:
	
	push edx ;refacem stiva(*str, length, return)

	push ecx

	push ebx
	
	ret
