;; defining constants, you can use these as immediate values in your code
CACHE_LINES  EQU 100
CACHE_LINE_SIZE EQU 8
OFFSET_BITS  EQU 3
TAG_BITS EQU 29 ; 32 - OFSSET_BITS

section .bss

    auxaddr: resd 1
    offset: resd 1
    auxtoreplace: resd 1


section .text
    global load

;; void load(char* reg, char** tags, char cache[CACHE_LINES][CACHE_LINE_SIZE], char* address, int to_replace);
load:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; address of reg
    mov ebx, [ebp + 12] ; tags
    mov ecx, [ebp + 16] ; cache
    mov edx, [ebp + 20] ; address
    mov edi, [ebp + 24] ; to_replace (index of the cache line that needs to be replaced in case of a cache MISS)
    ;; DO NOT MODIFY

    ;; TODO: Implment load
    ;; FREESTYLE STARTS HERE

    mov [auxaddr], edx ; salvam adresa intr-o variabila globala

    shr edx, 3 ; aflam tag-ul 

    mov esi, edx ; salvam tag-ul in esi

    mov edx, [auxaddr] ; readucem adresa initiala 

    shl edx, TAG_BITS

    shr edx, TAG_BITS ; aflam offsetul

    mov [offset], dl ; salvam offsetul intr-o variabila globala

    mov [auxtoreplace], edi ; salvam to_replace intr-o variabila globala

    xor edx, edx ; edx=0 - indicele tag-ului curent din vectorul tags

search_tag:

    cmp esi, [ebx+edx*4] ; comparam tag-ul nostru cu tag-urile din vector

    je cache_hit ; am gasit tagul in tags pe pozitia edx

    inc edx

    cmp edx, CACHE_LINES ; verificam daca mai avem tag-uri de citit

    jl search_tag

cache_miss: ; caz cache-miss

    mov [ebx+edi*4], esi ; tags[to_replace]=tag

    lea edx, [ecx+edi*CACHE_LINE_SIZE] ; edx- inceput de linie to_replace din matricea cache

    xor edi, edi ; edi=0 - indicele coloanei de pe linia cache[to_replace]

    shl esi, 3 ;facem prima adresa a octetului care trebuie trecuta in cache - (tag)000

write_to_cache:

    mov ebx, [esi] ;luam octetul de la adresa

    mov [edx+edi], ebx ; punem in cache[to_replace][edi] octetul

    inc esi ; trecem la urmatoarea adresa

    inc edi ; trecem la coloana urmatoare

    cmp edi, CACHE_LINE_SIZE ; verificam daca mai avem octeti de pus in cache

    jl write_to_cache

    mov edi, [offset] ; luam offset-ul

    mov esi, [edx+edi] ; punem in esi octetul din cache[to_replace][offset]

    mov [eax], esi ; punem octetul la adresa reg

    jmp stop

cache_hit: ; caz cache hit (tag gasit la tags[edx])

    lea esi, [ecx+edx*CACHE_LINE_SIZE] ; luam in esi adresa liniei edx din cache

    mov edi, [offset] ; punem in edi offset-ul calculat

    mov edx, [esi+edi] ; punem in edx octetul cache[edx][offset]

    mov [eax], edx ; punem octetul la adresa reg

stop:

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY


