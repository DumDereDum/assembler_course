#include <stdio.h>

//https://stackoverflow.com/questions/25579759/gcc-inline-assembly-what-does-asm-operand-has-impossible-constraints-mean


int main() {
/*
int a = 0;

__asm__ (
  "movl $10, %%eax"
  : "=a" (a)
);
printf("a = %d\n", a);


__asm__ (
  "movl %0, %%eax"
  : "=a" (a)
  : "r" (15)
);
printf("a = %d\n", a);

*/
/*
int arg1 = 1;
int arg2 = 4;
int add  = 0;

__asm__ ( "addl %%ebx, %%eax;"
        : "=a" (add)
        : "a" (arg1), "b" (arg2) );
printf("arg1 = %d\narg2 = %d\nadd = %d\n", arg1, arg2, add);
*/

//return 0 ;



  int a1 = 4, a2 = 3;
  int b1 = 4, b2 = 5;
  //int a = 0, b = 0;
  int a, b;
  __asm__ (
      //"xor %%eax, %%eax;"
      //"xor %%ebx, %%ebx;"

      "movl %%eax, %2;"
      "movl %3, %%ebx;"
      
      "addl %%ebx, %%eax;"

      : "=a" (a), "=b" (b)
      : "r" (a1), "r" (a2)
  );
  
  printf("a = %d\n", a);

return 0 ;
}