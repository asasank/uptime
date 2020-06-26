#include <time.h>
#include <stdio.h>
int main(void)
{
time_t ltime;
ltime=time(NULL);
printf("Uptime Solutions in New Hampshire from C: %s",asctime( localtime(&ltime) ) );
return 0;
}
