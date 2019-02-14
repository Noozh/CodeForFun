/*Suma de los números impares de un intervalo cerrado, solicitado por el programa [N1,N2]*/
// Por Daniel Arevalo.
#include <stdio.h>
int cs,ci,i,res,z=1;
void main ()
{
	while (z==1)
	{
	res=0;
	printf ("Introduce limites, tenga en cuenta que el limite superior no se sumara\n");
	scanf("%i",&ci);
	scanf("%i",&cs);
	printf ("Los limites establecidos son %i y %i\n",ci,cs);
	for (i=ci;i<cs;i++)
	{
		if (i%2!=0)
		res=res+i;
	}
	printf ("El resultado es %i \n",res);
	printf ("Desea repetir la operacion con nuevos valores? \n");
	printf ("1=si/2=salir del programa\n");
	scanf ("%i",&z);
	}
}
