#include <stdio.h>

int main(void) {
  int n;
  scanf("%d", &n); 
  int a = 1, b = 1, c;
  if (n <= 2) 
    printf("1");
  else 
  {
    for (int i = 2; i < n; i++) 
    {
      c = a + b;
      a = b; 
      b = c; 
    }
    printf("%d", b); 
  }
  return 0;
}
