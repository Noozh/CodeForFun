//Convertir números de decimal a binario y hexadecimal. llegar al menos a 999999
//Por Daniel Arevalo Rodrigo
#include <stdio.h>
#include <math.h>
#include <string.h>
int i=0,c,m;
int dec;
char bin [21];
char bin2 [21];
void main()
{
	printf("Introduce un numero decimal de hasta 6 cifras\n");
	scanf ("%i",&dec);
	printf("El numero introducido es: %i \n",dec);
	printf("El numero en hexadecimal es: %x\n",dec);
	for (dec;dec!=0;dec=dec/2) // transforma numeros en cadena de caracteres.
	{
		if (dec%2==0)
		bin[i]='0';
		if (dec%2==1)
		bin[i]='1';
		i++;
	}
	while (bin[c]!='\0')// cuenta digitos de la cadena
	{ 
		c++;
	}
	printf("El numero de digitos es: %i \n",c);
	m=c-1;
	for (i=0;i<c;i++) // Invierte el numero.
	{
	bin2[i]=bin[m];
	m--;
	}
	printf("El numero introducido en binario es: %s \n",bin2);
}
