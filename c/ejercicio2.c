/*Dar el recibo correspondiente al gasto (consumo) de LUZ. El recibo es bimensual. El programa debe pedir dos datos:la potencia contratada y el consumo*/
// Por Daniel Arevalo Rodrigo
#include <stdio.h>

float consumo;
float potencia;
float total,x,iva;
float cuota;
int menu=1;

void main()
{
	while (menu==1)
	{
	printf ("Por favor, introduzca la potencia contratada\n");
	scanf ("%f",&potencia);
	printf ("Por favor, introduzca su consumo\n");
	scanf("%f",&consumo);
	printf ("Su potencia contratada es: %f kW y su consumo es: %f kWh \n",potencia,consumo);
	if (consumo>50)
		total=50*0.06;
	if( consumo<=50)
		total=consumo*0.06;
	if (consumo>120)
		total=total+(69*0.09);
	if (consumo<=120&&consumo>50)
		total=total+(consumo-50)*0.09;
	if (consumo>=121)
		total=total+(consumo-120)*0.14;
	float alquiler=1.14;
	printf ("El alquiler de equipos es:0.57*2 = 1.14\n");
	cuota=potencia*1.4*2;
	printf ("El importe de la cuota es: %f\n",cuota);
	printf ("El coste de consumo:%f \n",total);
	x=total+cuota+alquiler;
	printf ("El total de la factura sin IVA es:%f\n",x);
	iva=x*1.16;
	printf ("El total de la factura con IVA es:%f\n",iva);
	printf ("Desea repetir la operacion con nuevos valores? \n");
	printf ("1=si/2=salir del programa\n");
	scanf ("%i",&menu);
	}
}
