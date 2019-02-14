/*Realizar un programa que admita hasta un máximo de 20 notas (las notas pueden variar entre 0 y 10, ambas
inclusive, y pueden tener dos decimales). Si se introduce un valor mayor de 10 debe rechazarlo y si se introduce un
valor negativo debe acabar la introducción de datos. A continuación debe dar cuántas notas se han introducido, la nota
máxima, la mínima, la media y el porcentaje de notas aprobadas. */
//Por Daniel Arevalo Rodrigo
#include <stdio.h>
int notas[20];
int i,e,c,j,paso,repetir;
float aprobado,total,media;
void main()
{
	inicio:
	printf ("Introduce un maximo de 20 notas \n");
	for (i=0;i<20;i++)  //Inicio del segmento de Introduccion de notas
	{
			scanf("%i",&notas[i]);
		if (notas[i]>10)
		{
			printf("Valor invalido,repita la operacion \n");
			i--;
		}
		if (notas[i]<0)
		{
			notas[i]='\0';
			goto siguiente;
		}
	}					//Fin del segmento de introduccion de notas
	siguiente:
	while (notas[c]!='\0') // Segmento cuenta notas
		{
			c++;
		}					//Fin del segmento cuenta notas
	printf ("Se han introducido un total de %i notas \n",c);
	e=i;
	printf ("Las notas introducidas son:\n");
	for (i=0;i<e;i++) //Inicio del segmento de orden de notas.
		printf ("%i\n", notas [i]);
	for (j=0;j<c;j++)						// Ordena las notas de menor a mayor realizando un muestreo completo
		for (i=0;i<c;i++)			
			{
				if (notas[i]>notas[i+1])
				{
					paso=notas[i+1];
					notas[i+1]=notas[i];
					notas[i]=paso;
				}
			}// Fin del segmento orden de notas.
	printf ("La nota mas baja es: %i \n", notas[0]); // Codigo para imprimir la nota mas baja tras ordenarlas de menor a mayor
	printf ("La nota mas alta es : %i \n",notas [c]);// Codigo para imprimir la mas alta despues de la ordenacion.
	for (i=0;i<=c;i++) //Inicio segmento calculo de media.
	{
		total=total+notas[i];
	}
	media=total/c;
	printf ("La nota media es :%f\n",media); //Fin del segmento calculo de media.
	for (e=0;e<=c;e++) //Segmento de porcentaje
	{
		if (notas[e]>=5)
		aprobado++;
	}
	aprobado=(aprobado/c)*100;
	printf ("El porcentaje de aprobados es:%f\n",aprobado);// Fin de segmento de porcentaje
	printf ("Desea introducir nuevos datos?\n"); //Inicio de segmento de salida
	printf ("1 para introducir nuevos datos/2 para salir\n");
	scanf ("%i",&repetir);
	if (repetir == 1)
	goto inicio; // Fin del segmento de salida.
	
}
