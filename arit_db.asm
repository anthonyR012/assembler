.286
; Programado por Crispin Condori Rodriguez
title datos de 8 bits
pila segment stack
  db 125 dup(?)
pila ends
datos segment
	n1 db ?  ;  Rango maxima 255 => 2^8 - 1
	n2 db ?	;  Valor en sistema decimal (base 10)
	msg	   db '  ARITMETICA  {PARA 8 BITS => MAX = 255}$'
	msgsum db '  La suma es: $'
	msgres db '  La resta es: $'
	msgmul db '  El producto es: $'
	msgcos db '  La division es: [Cociente] = $'
	msgrs  db '  [Residuo] = $'
	mensaje1 db 'Digite el primer numero: $'
	mensaje2 db 'Digite el segundo numero: $'
datos ends
;
codigo segment
	assume ds:datos,cs:codigo,ss:pila
	principal proc far	
		mov ax,datos
		mov ds,ax
        ;================================== INICIO ==========================================
		call saltar
		lea dx,msg
		call mostrarDXmsg
		;
		mov ax,0
		mov bx,0
		mov cx,0
		mov dx,0
		; PEDIR LOS DATOS
		mov dx, offset mensaje1
		mov ah, 9
		int 21h
			mov ah, 1
		int 21h
		sub al, '0'   ; Convertir el carácter ASCII en dígito decimal
		mov n1, al
		
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
		mov n2, al
		
			; Imprimir un carácter de retorno de carro y un carácter de nueva línea para comenzar una nueva línea
		mov dl, 13  ; Carácter de retorno de carro
		mov ah, 2
		int 21h
		mov dl, 10  ; Carácter de nueva línea
		mov ah, 2
		int 21h

	; REALIZAR OPERACION
		call saltar
		lea dx, msgsum	;mostrar el mesaje de la suma
		call mostrarDXmsg
		mov ax,0
		mov al,n1		;sumar al = n1
		add al,n2		;      al = al + n2
		call mostrarAXnum
		;
		call saltar
		lea dx,msgres	;mostrar el mesaje de la resta
		call mostrarDXmsg
		mov ax,0
		mov al,n1		;restar al = n1
		sub al,n2		;       al = al - n2
		call mostrarAXnum
		;
		call saltar
		lea dx,msgmul	;mostrar el mesaje de la multiplicacion
		call mostrarDXmsg
		mov ax,0
		mov al,n1		;multilpicar  al = n1
		mul n2			;             ax = al * n2
		call mostrarAXnum
		;
		call saltar
		lea dx, msgcos	;mostrar el mesaje de la division
		call mostrarDXmsg
		mov ax,0
		mov al,n1		;dividir      al = n1
		div n2			;             al = ax / n2
		push ax
		mov ah,0
		call mostrarAXnum
		;
		lea dx, msgrs	;mostrar mensaje de residuo de la division
		call mostrarDXmsg
		;
		pop ax
		mov al,ah
		mov ah,0
		call mostrarAXnum
		;
		;=============================== FIN ==============================================
		call pausa
		mov ah,4ch
		int 21h	
		ret
	principal endp
	mostrarDXmsg proc near
		mov ah,9
		int 21h
		ret
	mostrarDXmsg endp
	mostrarAXnum proc near
		xor cx,cx
		mov si,10
		bucle2ccr:
			xor dx,dx			
			div si 			;ax = ax div si     dx = ax mod si
			push dx
			inc cx
			cmp ax,0
		jne bucle2ccr
		;
		bucle3ccr:
			pop dx			
			add dx,48
			mov ah,2
			int 21h			
		loop bucle3ccr
		ret
	mostrarAXnum endp 
	saltar proc near
		mov dl,10
		mov ah,2
		int 21h
		ret
	saltar endp
	pausa proc near
		mov ah,08h		;sin eco				01h con eco
		int 21h
		ret
	pausa endp
codigo ends
end principal