INCLUDE Irvine32.inc

.data
arr DWORD 5,12,18,25,33,41,56,72,89,100
target DWORD ?
low DWORD ?
high DWORD ?
mid DWORD ?
found DWORD ?

msg1 BYTE "Sorted array: 5 12 18 25 33 41 56 72 89 100",0dh,0ah,0
msg2 BYTE 0dh,0ah,"Searching for ",0
msg3 BYTE " ...",0dh,0ah,0
msg4 BYTE "Found ",0
msg5 BYTE " at index ",0
msg6 BYTE " was NOT found in the array.",0dh,0ah,0

tests DWORD 56,42,5,100

.code
main PROC

    mov esi, OFFSET tests
    mov ecx, 4

next_test:
    mov eax, [esi]
    mov target, eax

    mov edx, OFFSET msg2
    call WriteString
    mov eax, target
    call WriteDec
    mov edx, OFFSET msg3
    call WriteString

    mov low, 0
    mov high, 9
    mov found, -1

search_loop:
    mov eax, low
    cmp eax, high
    jg done_search

    mov eax, low
    add eax, high
    shr eax, 1
    mov mid, eax

    mov esi, mid
    mov eax, arr[esi*4]

    cmp eax, target
    je found_case
    jl go_right

go_left:
    mov eax, mid
    dec eax
    mov high, eax
    jmp search_loop

go_right:
    mov eax, mid
    inc eax
    mov low, eax
    jmp search_loop

found_case:
    mov eax, mid
    mov found, eax

done_search:
    cmp found, -1
    je not_found

    mov edx, OFFSET msg4
    call WriteString
    mov eax, target
    call WriteDec
    mov edx, OFFSET msg5
    call WriteString
    mov eax, found
    call WriteDec
    call Crlf
    jmp next_iter

not_found:
    mov eax, target
    call WriteDec
    mov edx, OFFSET msg6
    call WriteString

next_iter:
    add esi, 4
    loop next_test

    exit
main ENDP

END main
