section .text
	global cmmmc

;; int cmmmc(int a, int b)
;
;; calculate least common multiple fow 2 numbers, a and b
cmmmc:

	pop ebx ;luam adresa de return

	pop ecx ; primul parametru, a

	pop edx; al doilea parametru b

	push ecx

	pop edi ; luam inca o copie a lui a

	push edx

	pop esi ; luam inca o copie a lui b

cmmdc:

	cmp ecx, edx

	je next ; am gasit cel mai mare divizor comun

	jg first

	sub edx, ecx

	jmp next_step

first:

	sub ecx, edx ;scadem din nr mare nr mic

next_step:

	jmp cmmdc	

next:

	push esi

	pop eax ; punem in eax b

	mul edi ; inmultim b cu a

	push esi ;refacem stiva (punem b, a, return)

	push edi

	push ebx

	div ecx; impartim a*b la cmmdc, adica in eax o sa avem cmmmc

	ret
