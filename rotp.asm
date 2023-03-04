section .text
    global rotp

;; void rotp(char *ciphertext, char *plaintext, char *key, int len);
rotp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; ciphertext
    mov     esi, [ebp + 12] ; plaintext
    mov     edi, [ebp + 16] ; key
    mov     ecx, [ebp + 20] ; len
    ;; DO NOT MODIFY

    ;; TODO: Implment rotp
    ;; FREESTYLE STARTS HERE


    xor ebx, ebx ; ebx=0 - retine nr caracterului care trebuie criptat

next_char:

    mov al, [esi+ebx] ; luam caracterul din plaintext

    inc ebx

    sub ecx, ebx

    dec ebx ;aflam in ecx indicele caracterului din key

    mov ah, [edi+ecx] ; luam caracterul din key

    xor al, ah ; facem xor intre cele doua caractere
    
    mov [edx+ebx], byte al ; punem rezultatul in ciphertext

    inc ebx ; trecem la caracterul urmator

    add ecx, ebx ;refacem ecx-ul aka length-ul stringului

    cmp ebx , ecx 

    jl next_char ;trecem la urmatorul caracter


    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY