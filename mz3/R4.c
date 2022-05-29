#include <stdio.h>

int main(void) {
    int arr[] = {0xffff, 0xff00ff, 0xf0f0f0f, 0x33333333, 0x55555555};
    unsigned int a, c = 1;
    scanf("%u", &a);
    int *b;
    b = arr;
    b += 4;
    while (*b != 0) {
        a = ((a & (*b) ) << (c & 0xff)) | ((a & (~(*b)) ) >> (c & 0xff));
        c = c << 1;
        b -= 1;
    }
    printf("%u", a);
    return 0;
}
