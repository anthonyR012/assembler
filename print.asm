.model small
.stack

.data
    name_v db 'Anthony Rubio $';type of datas
    id_v db '1005871022 $';

; code section
.code
    ;mnemonicos (mov, int)

    ; main procedure
        main PROC
        ; load data
        mov ax, @data
        mov ds, ax
        xor ax,ax

        ; print data for console
        mov dx, offset name_v
        mov ah, 9
        int 21h ;interruptions

        mov dx, offset id_v
        mov ah, 9
        int 21h

        .exit
    main ENDP

end main