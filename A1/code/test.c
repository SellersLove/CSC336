#include <stdio.h>
#include <math.h>
int main (void){
	int a,k;
	double m;
 	for(a = 0; a<=20; a++){
 		m = M_PI;
 		for(k = 0; k<a; k++){
 			m = m * 10;
 		}
 		printf("%G\n",m);
 		printf("%G\n",cos(m) );
 	}
	return 0; }
