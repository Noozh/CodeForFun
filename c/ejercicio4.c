//Convertir números binarios en hexadecimal y decimal. Al menos hay que llegar a 20 cifras binarias.
//Por Daniel Arevalo Rodrigo
#include <stdio.h>
#include <math.h>
int i=0;
char bin [20];
int x;
int e=0;
int d;
void main()
{
	
	printf("Introduce un numero binario de hasta 20 cifras\n");
	gets (bin);
	printf("El numero introducido es: %s \n",bin);
	while (bin[i]!='\0') // se cuentan los digitos de la palabra
		i++;
	printf("El numero de digitos introducidos es: %i \n",i);
	for (i;i>=0;i--)
	{
		if (bin [i]=='1')
			{
			d=d+ pow(2,e);
			e++;
			}
		if (bin[i]=='0')
			e++;
	}
	printf("El numero en decimal es : %i \n",d);
	printf("El numero en hexadecimal es :%x \n",d);
}
