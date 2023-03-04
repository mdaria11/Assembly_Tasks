struc node
    .val: resd 1
    .next: resd 1
endstruc

section .text
	global sort
	extern printf

; struct node {
;     	int val;
;    	struct node* next;
; };

;; struct node* sort(int n, struct node* node);
; 	The function will link the nodes in the array
;	in ascending order and will return the address
;	of the new found head of the list
; @params:
;	n -> the number of nodes in the array
;	node -> a pointer to the beginning in the array
; @returns:
;	the address of the head of the sorted list
sort:
	enter 0, 0 ;echivalent cu push ebp; mov ebp, esp

	mov ebx, [ebp+8] ; int n
	mov ecx, [ebp+12] ; struct node *node

	xor edx, edx ; aici o sa salvam max din noduri

	xor edi, edi ; indicele la care suntem in vector

find_max: ; loop in care cautam valoarea maxima din vector

	cmp [ecx+edi*node_size+node.val], edx ; comparam valoarea din nodul curent cu cel max

	jl next

	mov edx, [ecx+edi*node_size+node.val] ; salvam noua val maxima

	lea eax, [ecx+edi*node_size] ; salvam adresa ei in eax

next: ;trecem la urmatorul nod

	inc edi

	cmp edi, ebx ; verificam daca mai avem noduri de citit

	jl find_max

	push ebx ; salvam nr de noduri intr-o variabila locala (o folosim ca sa stim cate noduri mai avem de citit)

next_node: ; loop in care aflam pe rand valoarea maxima mai mica decat valoarea maxima anterioara

	sub esp, 4 ; alocam loc pentru variabila locala in care o sa salvam adresa nodului max

	xor esi, esi ; initializam valoarea maxima cu 0

	xor edi, edi ; indicele nodului in care sunt 

next_max:

	cmp [ecx+edi*node_size+node.val], esi ; cautam valoarea maxima

	jl next_step

	cmp [ecx+edi*node_size+node.val], edx ; vedem sa nu gasim maximul deja vizitat

	jge next_step

	mov esi, [ecx+edi*node_size+node.val] ; salvam maximul in esi

	lea ecx, [ecx+edi*node_size] ; savam intr-un registru aux adresa nodului max

	mov [ebp-8], ecx ; punem adresa pe stiva

	mov ecx, [ebp+12] ; reintoarcem valoarea initiala din ecx

next_step:

	inc edi ;trecem la urmatorul nod

	cmp edi, ebx ;verificam daca mai avem noduri de citit

	jl next_max

	mov edx, esi ; reinitializam valoarea maxima totala

	pop esi ; luam adresa nodului maxim local

	mov [esi+node.next], eax ;initializam campul next cu adresa maximului anterior

	mov eax, esi ; punem in eax adresa nodului maxim local

	mov esi, [esp] ; punem in esi nr de noduri necitite

	dec esi ; decrementam nr

	mov [ebp-4], esi ; il punem la loc pe stiva

	cmp esi, dword 1 ; verificam daca mai avem noduri nevizitate

	jg next_node


	leave
	ret
