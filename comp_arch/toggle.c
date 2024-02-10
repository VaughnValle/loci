#include <stdio.h>

unsigned int toggleBit2(unsigned int x){
  return x ^ 2;
}

unsigned int flipOffBit5(unsigned int x){
  return x & ~(1 << 4);
}
unsigned int repeatBitsThrice(unsigned int x){
  return (x & 7) * 0x49;
}

unsigned int detectBitPattern(unsigned int x){
  return (x & 0x00A0) == 0x00A0;
}

int main(){
  int n;
  scanf("%d", &n);
  printf("%d \n", toggleBit2(n));
  printf("%d \n", flipOffBit5(n));
  printf("%d \n", repeatBitsThrice(n));
  printf("%d \n --- \n", detectBitPattern(n));
  printf("%b \n", 8 & 4);
  printf("%b \n", 8 && 4);
  return 0;
}
