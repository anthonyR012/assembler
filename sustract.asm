.model small
.stack

.data
    mensaje1 db 'Introduce el primer digito: $'
    mensaje2 db 'Introduce el segundo digito: $'
    resultado db 'El resultado es: $'
    digito1 db ?
    digito2 db ?
    resta db ?

.code
main PROC
    ; Cargar datos
    mov ax, @data
    mov ds, ax
    
    ; Pedir al usuario que introduzca el primer dígito
    mov dx, offset mensaje1
    mov ah, 9
    int 21h
    
    ; Leer el primer dígito capturado por teclado
    mov ah, 1
    int 21h
    sub al, '0'   ; Convertir el carácter ASCII en dígito decimal
    mov digito1, al
    
    ; Imprimir un carácter de retorno de carro y un carácter de nueva línea para comenzar una nueva línea
    mov dl, 13  ; Carácter de retorno de carro
    mov ah, 2
    int 21h
    mov dl, 10  ; Carácter de nueva línea
    mov ah, 2
    int 21h
    
    ; Pedir al usuario que introduzca el segundo dígito
    mov dx, offset mensaje2
    mov ah, 9
    int 21h
    
    ; Leer el segundo dígito capturado por teclado
    mov ah, 1
    int 21h
    sub al, '0'   ; Convertir el carácter ASCII en dígito decimal
    mov digito2, al
    
        ; Imprimir un carácter de retorno de carro y un carácter de nueva línea para comenzar una nueva línea
    mov dl, 13  ; Carácter de retorno de carro
    mov ah, 2
    int 21h
    mov dl, 10  ; Carácter de nueva línea
    mov ah, 2
    int 21h
    
    ; Restar los dígitos
    mov al, digito1
    sub al, digito2
    mov resta, al
    
    ; Convertir el resultado de la resta a un carácter ASCII
    add resta, '0'
    
    ; Mostrar el resultado en pantalla
    mov dx, offset resultado
    mov ah, 9
    int 21h
    
    mov dl, resta
    mov ah, 2
    int 21h

    ; Salir del programa
    mov ah, 4ch
    int 21h
main ENDP

end main
