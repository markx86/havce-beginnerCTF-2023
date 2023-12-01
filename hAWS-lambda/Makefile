all:
	gcc -o shellcode.o -c shellcode.S
	ld -nostdlib -Tlink.ld -o shellcode.bin shellcode.o
