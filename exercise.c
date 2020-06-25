#include <time.h>
#include <stdio.h>
int main(void)
{
time_t ltime;
ltime=time(NULL);
printf("Uptime from C: %s",asctime( localtime(&ltime) ) );
return 0;
}
