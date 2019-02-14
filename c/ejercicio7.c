#include <stdio.h>
int menu;
void introducir(char a [20],char b [15], char c [10],char d [10],float e);
struct ordenador
{
	char marca [20];
	char procesador [15];
	char RAM [10];
	char DDuro[10];
	float precio;
} o1,o2,o3,o4,o5;
void main()
{
	printf ("Elige una opcion, 0 para introduccion de datos,1 para presentacion de datos,2 ficha concreta,3 salir del programa\n");
	switch (menu)
	{
		case 0:
		printf ("Porfavor introduzca los datos\n");
		introducir(o1.marca,o1.procesador,o1.RAM,o1.DDuro,o1.precio);
		break;
		case 1:
		presentar(o1.marca,o1.procesador,o1.RAM,o1.DDuro,o1.precio);
		break;
		case 2:
		break;
		case 3:
		break;
	}
}

void introducir (char a [20],char b [15], char c [10],char d [10],float e) 
{
	printf("\nMarca:");
	gets (a);
	printf("\n Procesador:");
	gets (b);
	printf("\n RAM:");
	gets (c);
	printf("\n Disco Duro:");
	gets (d);
	printf ("\n Precio:");
	scanf ("%f",&e);
	printf ("\nHas introducido los siguientes datos:\n");
	printf ("Marca: %s\n",a);
	printf ("Procesador: %s\n",b);
	printf ("RAM: %s GB\n",c);
	printf ("Disco Duro: GB %s\n",d);
	printf ("Precio: %f euros \n",e);
}
void presentar (char a [20],char b [15], char c [10],char d [10],float e) 
{
	printf ("\n El ordenador tiene las siguientes caracteristicas :\n");
	printf ("Marca: %s\n",a);
	printf ("Procesador: %s\n",b);
	printf ("RAM: %s GB\n",c);
	printf ("Disco Duro: GB %s\n",d);
	printf ("Precio: %f euros \n",e);
}
