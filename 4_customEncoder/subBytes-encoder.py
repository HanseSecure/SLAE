#!/usr/bin/python
""" 
Content:	custom encoder for evilPayload via subtract randomInt
Author: 	Florian Hansemann | @HanseSecure | https://hansesecure.de
Date: 		09/2017

For testing insert your evilPayload here and copy encodedShellcode, length and randomInt to your subBytes-decoder.nasm file

"""


import random
shellcode = ("\xeb\x17\x31\xc0\xb0\x04\x31\xdb\xb3\x01\x59\x31\xd2\xb2\x0d\xcd\x80\x31\xc0\xb0\x01\x31\xdb\xcd\x80\xe8\xe4\xff\xff\xff\x48\x65\x6c\x6c\x6f\x20\x57\x6f\x72\x6c\x64\x21\x0a")

encode4higherLang = ""
encoded4nasm = ""
randomInt = random.randint(1,5)

print "\n \n[+] Custom Encoder by @HanseSecure [+]"
print "[+] Just adding a random integer to every single shellcodeByte [+]"
print "[+] HappyHacking ;-) [+]"

for x in bytearray(shellcode) :		
	 	
	y = x - randomInt		
	encode4higherLang += '\\x'	
	encode4higherLang += '%02x' % y

	encoded4nasm += '0x'
	encoded4nasm += '%02x,' %y

print "\n[+] Shellcode for higher languages like python or c: [+]"
print encode4higherLang
print "\n[+] Shellcode for your decoder nasmFile: [+]"
print encoded4nasm
print "\n[+] Additional Infos [+]"
print "[+] ShellcodeLengh: [+]"
print len(bytearray(shellcode))
print "[+] Used random integer: [+]"
print randomInt
 

