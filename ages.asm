; This is your structure
struc  my_date
    .day: resw 1
    .month: resw 1
    .year: resd 1
endstruc

section .text
    global ages

; void ages(int len, struct my_date* present, struct my_date* dates, int* all_ages);
ages:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; present
    mov     edi, [ebp + 16] ; dates
    mov     ecx, [ebp + 20] ; all_ages
    ;; DO NOT MODIFY

    ;; TODO: Implement ages
    ;; FREESTYLE STARTS HERE

    xor ebx, ebx ; indicele persoanei curente

next_age:

    mov ax, word [esi+my_date.year] ; luam anul curent

    cmp ax, word [edi+ebx*my_date_size+my_date.year] ; comparam anul curent cu cel de nastere

    jl imposibil ; anul nasterii este mai mare decat anul curent

    sub ax, word [edi+ebx*my_date_size+my_date.year] ; aflam varsta pe anul respectiv

    cmp ax, word 0 ; caz aceeasi ani

    je same_year

    shl eax, 16 ; mutam varsta teoretica pe partea high al registrului eax

    mov ax, [esi+my_date.month] ; luam luna curenta

    cmp ax , [edi+ebx*my_date_size+my_date.month] ; comparam luna curenta cu luna de nastere

    jg ok ; a fost deja ziua de nastere pe anul curent

    je same_month ; caz aceeasi luna

    shr eax, 16 ; caz luna curenta e mai mica decat luna de nastere, deci inca nu a fost ziua de nastere , readucem in AX varsta teoretica 

    dec eax ; decrementam varsta

    jmp next_step

imposibil:

    xor eax, eax ; punem 0 la varsta

    jmp next_step    
    
same_month:

    mov ax, [esi+my_date.day] ; luam ziua curenta

    cmp ax, [edi+ebx*my_date_size+my_date.day] ; comparam ziua curenta cu cea de nastere

    jge ok ; a fost ziua de nastere

    shr eax, 16 ; nu a fost ziua de nastere, aducem varsta in AX

    dec eax ; decrementam varsta

    jmp next_step


same_year: ;caz anul curent=anul de nastere

    shl eax, 16

    mov ax, [esi+my_date.month] ; luam luna curenta

    cmp ax , [edi+ebx*my_date_size+my_date.month] ; comparam luna curenta cu cea de nastere

    jg ok ; data de nastere corecta

    jl imposibil ; data de nastere imposibila

    mov ax, [esi+my_date.day] ; caz luni egale, comparam zilele

    cmp ax, [edi+ebx*my_date_size+my_date.day]

    jge ok ; data de nastere corecta

    jl imposibil

ok:

    shr eax, 16 ; aducem in AX varsta


next_step: ;varsta este corect calculata

    mov [ecx+ebx*4], eax ; punem in vectorul de ages varsta persoanei respective

    inc ebx ; trecem la indicele urmatoarei persoane

    cmp ebx, edx ; verificam daca mai avem persoane

    jl next_age ; indicele este mai mic decat len deci mai avem persoane



    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
