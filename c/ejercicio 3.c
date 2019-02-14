/*Programa que incluya una función Determinante que devuelva el valor del determinante de una matriz de 3x3.  Se deben utilizar variables locales.*/
// Por Daniel Arevalo Rodrigo
#include <stdio.h>
int matriz[9];
int menu=1;
float res;
float a,b,c,d,e,f,g,h,i;
float determinante(float a1,float a2,float a3,float a4,float a5,float a6,float a7,float a8,float a9); //se declara la funcion
void main()
{
	while (menu==1)
	{
	printf ("Introduce los coeficientes de la matriz (a1,a2,a3...)\n");
	res= determinante(a,b,c,d,e,f,g,h,i); //se invoca la funcion
	printf("%f",res);
	printf ("Desea repetir la operacion con nuevos valores? \n");
	printf ("1=si/2=salir del programa\n");
	scanf ("%i",&menu);
	}
}
float determinante(float a1,float a2,float a3,float a4,float a5,float a6,float a7,float a8,float a9) //se define la funcion.
{
	scanf("%f",&a1);
	scanf("%f",&a2);
	scanf("%f",&a3);
	scanf("%f",&a4);
	scanf("%f",&a5);
	scanf("%f",&a6);
	scanf("%f",&a7);
	scanf("%f",&a8);
	scanf("%f",&a9);
	return (a1*a5*a9)+(a2*a6*a7)+(a3*a4*a8)-(a3*a5*a7)-(a1*a6*a8)-(a2*a4*a9);
}
