#!/usr/bin/python
# -*- coding: utf8 -*-
""" 
https://github.com/livz/slae/blob/master/Level-7/encrypt_payload_polar.py
Content:	custom crypter for evilPayload
Author: 	Florian Hansemann | @HanseSecure | https://hansesecure.de
Date: 		10/2017
	
Test:		Insert your Shellcode in this file, execute it and copy the aes-key and the encrypted shellcode to the decrypt.py file
		After decrypting the shellcode you can execute it via the shellcode.c file
"""
import sys
from cryptography.fernet import Fernet

#	Insert your favourit evilPayload here ;-)
shellHex = ("\xeb\x17\x31\xc0\xb0\x04\x31\xdb\xb3\x01\x59\x31\xd2\xb2\x0d\xcd\x80\x31\xc0\xb0\x01\x31\xdb\xcd\x80\xe8\xe4\xff\xff\xff\x48\x65\x6c\x6c\x6f\x20\x57\x6f\x72\x6c\x64\x21\x0a")

# 	Block size
BS = 16 
pad = lambda s: s + (BS - len(s) % BS) * chr(BS - len(s) % BS) 
unpad = lambda s : s[0:-ord(s[-1])]

def to_hex(in_str):
	out = ""
	tmp = ["\\x%02x" % ord(c) for c in in_str]
	for i in range(0, len(in_str),16):
		out = out + '"' + "".join(tmp[i:i+16]) + "\"\n"

	return out

def start():
	shellHex_len = len(pad(shellHex))
	print "[+] Added "+str(shellHex_len-len(shellHex))+" bytes for padding."
	print "[+] Final shellcode size: \n",shellHex_len

#	generate key
	key = Fernet.generate_key()
	str_key = to_hex(key)
	print "[+] Used random key:"
	print key

# 	encrypt
	cipher_suite = Fernet(key)
	enc = cipher_suite.encrypt(pad(shellHex))
	str_enc = to_hex(enc)
	print "[+] Encrypted shellcode:"
	print str_enc


if __name__ == "__main__":
	start()

