section .data
    extern len_cheie, len_haystack

section .bss
    aux: resw 1

section .text
    global columnar_transposition

;; void columnar_transposition(int key[], char *haystack, char *ciphertext);
columnar_transposition:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha 

    mov edi, [ebp + 8]   ;key
    mov esi, [ebp + 12]  ;haystack
    mov ebx, [ebp + 16]  ;ciphertext
    ;; DO NOT MODIFY

    ;; TODO: Implment columnar_transposition
    ;; FREESTYLE STARTS HERE

    xor eax, eax ; eax=0 - retine indicele la care am ramas in ciphertext

    xor edx, edx ; edx=0 -retine indicele in care sunt in vectorul de ordine

next_line:

    mov ecx, [edi+edx*4] ; luam nr coloanei din vectorul de ordine(indicele caracterului din haystack)

    mov [aux], edx ; salvam valoarea lui edx in aux ca sa eliberam registrul

citire:    

    cmp ecx, [len_haystack] ;verificam daca indicele caracterului se afla in string

    jge stop ; cazul in care am terminat de parcurs tot haystack-ul 

    mov dl, [esi+ecx] ; punem in dl caracterul corespunzator din haystack

    mov [ebx+eax], dl ; punem caracterul in ciphertext

    inc eax ; incrementam indicele caracterului din ciphertext

    add ecx, [len_cheie] ; trecem la indicele caracterului de pe urm linie din coloana

    jmp citire

stop: ; cazul in care am parcurs intregul haystack

    mov edx, [aux] ; aducem inapoi valoarea lui edx initiala

    inc edx ; trecem la urm numar de ordine din vector

    cmp edx, [len_cheie] ; verificam daca am terminat toate nr din vectorul de ordine

    jl next_line ; recitim din nou string-ul pt urmatoarea coloana
   

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY