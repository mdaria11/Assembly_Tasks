global get_words
global compare_func
global sort

section .bss

	delim: resb 4

section .text

extern strtok
extern qsort
extern strlen
extern strcmp

compare_func: ;compare_func(char* *a, char* *b)

    enter 0, 0

    mov ecx, [ebp+8] ;luam primul cuvant
    mov ecx, [ecx]

    push ecx
    call strlen ;apelam strlen
    add esp, 4

    mov ebx, eax ; ebx-length primul word

    mov edx, [ebp+12] ;luam al doilea cuvant
    mov edx, [edx]

    push edx
    call strlen ;apelam strlen
    add esp, 4 ; eax - len al doilea word

    cmp ebx, eax ;comparam cele doua lungimi

    jl second

    je equal

first:

    mov eax, dword 1 ;returnam 1

    jmp stop

equal:

    mov ecx, [ebp+8] ;luam cele doua cuvinte
    mov ecx, [ecx]

    mov edx, [ebp+12]
    mov edx, [edx]

    push edx
    push ecx
    call strcmp ;apelam strcmp(word1, word2)
    add esp, 8

    cmp eax, dword 0
    jg first

second:

    mov eax, dword -1 ;returnam -1

stop:      

    leave
    ret


;; sort(char **words, int number_of_words, int size)
;  functia va trebui sa apeleze qsort pentru soratrea cuvintelor 
;  dupa lungime si apoi lexicografix
sort:
    enter 0, 0

    mov eax, [ebp+8] ;luam parametrii
    mov ebx, [ebp+12]
    mov ecx, [ebp+16]

    push compare_func ;punem pe stiva parametrii
    push ecx
    push ebx
    push eax
    call qsort ;apelam qsort
    add esp, 16 ;curatam stiva

    leave
    ret

;; get_words(char *s, char **words, int number_of_words)
;  separa stringul s in cuvinte si salveaza cuvintele in words
;  number_of_words reprezinta numarul de cuvinte
get_words:
    enter 0, 0

    mov edx, [ebp+8] ; *s

    mov ebx, [ebp+12] ; **words

    mov ecx, [ebp+16] ; nr

    mov [delim], byte '.'    ;facem un string de delimitatori pt strtok
    mov [delim+1], byte ','
    mov [delim+2], byte ' '
    mov [delim+3], byte 10

    push ebx ;salvam pe stiva registrele
    push ecx
    push edx

    push delim ;punem pe stiva parametrii pt strtok()
    push edx
    call strtok ;apelam strtok()
    add esp, 8 ;curatam stiva

    pop edx ;readucem registrele dp stiva
    pop ecx
    pop ebx

    xor esi, esi

next_word:

    mov [ebx+esi*4], eax ; salvam in words fiecare cuvant gasit

    dec ecx ;decrementam nr de cuvinte

    cmp ecx, dword 0 ;vedem daca mai avem cuvinte de luat
    je end

    push ebx ;salvam pe stiva registrele
    push ecx
    push edx
    push esi

    push delim ;reapelam strtok pt urmatoarele cuvinte
    push 0
    call strtok
    add esp, 8

    pop esi ;readucem registrele
    pop edx
    pop ecx
    pop ebx

    inc esi ;trecem la urmatorul indice din words

    jmp next_word

end:

    leave
    ret
