#include <stdio.h>
#include <stdint.h>
#include <assert.h>

int main()
{
    uint64_t v1 = 0x726F6C6564574820; // v1 is a 64-bit number == 8 bytes == 8 chars
    uint64_t v2 = 0x77E435B08;
    
    char* v1chrs = (char*) &v1; // sizeof(v1chrs) == 8 --> typeof(v1chrs) == char[8]
    while (v2) {
        v2 >>= 3; // goto next index (the first 3 bits of v2 are useless and can be whatever)
        uint64_t v1_byte_index = v2 & 7; // isolate the first 3 bits (clamps the number between 0-7)
        uint64_t v3 = v1_byte_index << 3; // multiply v1_byte_index by 8, to obtain the number of bits we have to shift v1, in order to access the desired byte
        char c = (v1 >> v3) & 0xFF; // shift v1 right by v3 bits and isolate the lowest byte of the number
        assert(v1chrs[v1_byte_index] == c); // prove the operations made above and the simple array access are the same
        putchar(c);
    }

    return 0;
}
