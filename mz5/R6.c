#include <stdio.h>

int main(void) {
    unsigned int n;
    int k = 0;
    scanf("%u", &n);
    while (n > 0) {
        if((n&1))
            k++;
        n = n >> 1;
    }
    printf("%d", 32 - k);
    return 0;
}
