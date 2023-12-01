#!/usr/bin/python3

from pwn import *
import time

if args.CUSTOM_FLAG:
    flag = input("insert flag start: ")
else:
    flag = "havceCTF{"

if args.REMOTE:
    conn = remote("challs.beginner.havce.it", 1338)
else:
    conn = process(['./chal'])
hello_msg = conn.recvuntilS(": ")
flag_len = int(hello_msg.split(" ")[5])-1
char = 32
test_len = len(flag)

while (test_len < flag_len):
    conn.send(flag + chr(char) + '\n');
    msg = conn.recvuntilS(": ")
    guessed = int(msg.split()[4])
    if (char > 255):
        print("Error: char too big")
        break
    if (guessed > test_len):
        flag += chr(char)
        char = 32
    else:
        char += 1
    test_len = len(flag)
    print("Flag status:", flag)

conn.close()
