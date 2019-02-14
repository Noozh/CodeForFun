/*Construir un programa que maneje N (por ejemplo, N = 5) fichas de ordenadores con la siguiente estructura: marca:
(máximo 20 caracteres), procesador (máximo de 15 caracteres), RAM (en MB), Disco duro (en GB) y   precio. El
programa debe presentar y elegir entre las siguientes opciones: 
Entrada de datos, Presentación de datos,Presentar la
ficha del menor relación Precio dividido por  (RAM+Disco Duro)y 
Salir del programa. Se deben utilizar funciones. */
// Por Daniel Arevalo Rodrigo
#include <stdio.h>
#define N 5
int menu;
int i;
void introducir(void);
void presentar(void);
void relacion();
struct ordenador
{
	char marca [20];
	char procesador [15];
	int RAM ;
	int DDuro;
	float precio;
};
struct ordenador pc [N];

void main()
{
	comienzo:
	printf ("0 para introducir,1 para presentar,2 para presentar ficha mejor relacion,3 para salir del programa\n");
	scanf ("%i",&menu);
	switch (menu)
	{
		case 0:
			introducir ();
			break;
		case 1: 
			presentar ();
			break;
		case 2:
			relacion();
			break;
		case 3:
			break;
	}	
	if (menu==3)
	0;
	
	if (menu==0||menu==1||menu==2)
	{
	printf ("0 para realizar otra operacion,1 para salir\n");
	scanf("%i",&menu);
	}
	if (menu==0)
	{
	goto comienzo;
	}
}
void introducir (void) 
{
	
	for (i=0;i<N;i++)
	{
		printf ("Introduce  modelo %i \n",i+1);
		scanf("%s",pc[i].marca);
		printf ("Introduce  procesador %i \n",i+1);
		scanf("%s",pc[i].procesador);
		printf ("Introduce  RAM %i \n",i+1);
		scanf("%i",&pc[i].RAM);
		printf ("Introduce  DiscoDuro %i \n",i+1);
		scanf("%i",&pc[i].DDuro);
		printf ("Introduce  precio %i \n",i+1);
		scanf("%f",&pc[i].precio);
	}
}
void presentar (void) 
{
	for (i=0;i<N;i++)
	{	
		printf ("Ordenador %i\n",i+1);
		printf ("Marca %s\n", pc[i].marca);
		printf ("Procesador %s\n",pc[i].procesador);
		printf ("RAM %i\n", pc[i].RAM);
		printf ("DiscoDuro %i\n", pc[i].DDuro);
		printf ("Precio %f\n", pc[i].precio);
	}
}	
void relacion()
{
	float menor=15000;
	float paso;
	int e=-1;
	for (i=0;i<N;i++)
	{
		paso= pc[i].precio/(pc[i].RAM+pc[i].DDuro); 
		if (paso<menor)
		{
		menor=paso;
		e=i;
		}
	}
		printf ("Ordenador %i\n",e+1);
		printf ("Marca %s\n", pc[e].marca);
		printf ("Procesador %s\n",pc[e].procesador);
		printf ("RAM %i\n", pc[e].RAM);
		printf ("DiscoDuro %i\n", pc[e].DDuro);
		printf ("Precio %f\n", pc[e].precio);
}
