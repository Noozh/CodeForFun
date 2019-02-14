program geom;

consts:
	/*Bloque de Cuadrado*/
	LadoCuadrado=2.0;
	AreaCuadrado=LadoCuadrado**2.0;
	PerimetroCuadrado=LadoCuadrado*4.0;
	/*Bloque Rectangulo*/
	AlturaRectangulo=2.0;
	BaseRectangulo=4.0;
	AreaRectangulo=BaseRectangulo*AlturaRectangulo;
	PerimetroRectangulo=AlturaRectangulo*2.0 + BaseRectangulo*2.0;
	/*Bloque Paralelogramo*/
	LadoParalPeque=4.0;
	LadoParalGrande=5.0;
	AlturaParal=3.5;
	AreaParal=LadoParalGrande*AlturaParal;
	PerimetroParal=2.0*LadoParalPeque+2.0*LadoParalGrande;
	/*Bloque Rombo*/
	LadoRombo=2.0;
	DiagonalMenor=3.2;
	DiagonalMayor=2.4;
	AreaRombo=(DiagonalMenor*DiagonalMayor)/2.0;
	PerimetroRombo=(4.0*LadoRombo);
	Relacion=sqrt((DiagonalMenor**2.0+DiagonalMayor**2.0)/4.0);
	Igualdad=LadoRombo==Relacion;
	/*Bloque Trapecio*/
	BaseMayor=15.0;
	BaseMenor=12.0;      
	LadoTrapecio=6.1846;
	AlturaTrapecio=2.0;
	AreaTrapecio=((BaseMenor+BaseMayor)/2.0)*AlturaTrapecio;
	PerimetroTrapecio=BaseMayor+BaseMenor+LadoTrapecio*2.0;	
	/*Bloque Octaedro*/
	AristaOctaedro=1.0;
	AreaTotalOctaedro=2.0*AristaOctaedro**2.0*sqrt(3.0);
	AreaCaraOctaedro=(sqrt(3.0)*AristaOctaedro**2.0)/4.0;
	VolumenOctaedro=(sqrt(2.0)*AristaOctaedro**3.0)/3.0;
	/*Bloque Dodecaedro*/
	AristaDodecaedro=4.0;
	AreaTotalDodecaedro=3.0*sqrt(25.0+10.0*sqrt(5.0))*AristaDodecaedro**2.0;
	AreaCaraDodecaedro=(sqrt(25.0+10.0*sqrt(5.0))*AristaDodecaedro**2.0)/4.0;
	VolumenDodecaedro=((15.0+7.0*sqrt(5.0))*AristaDodecaedro**3.0)/4.0;
	/*Bloque Icosaedro*/
	AristaIcosaedro=2.0;
	AreaTotalIcosaedro=5.0*sqrt(3.0)*AristaIcosaedro**2.0;
	AreaCaraIcosaedro=(sqrt(3.0)*AristaIcosaedro**2.0)/4.0;
	VolumenIcosaedro=(5.0/12.0)*(3.0+sqrt(5.0))*AristaIcosaedro**3.0;			

procedure main()
{	
	write("El area del cuadrado es:");
	writeln(AreaCuadrado);
	write("El perimetro del cuadrado es:");
	writeln(PerimetroCuadrado);
	write("El area del rectangulo es:");
	writeln(AreaRectangulo);
	write("El perimetro del rectangulo es:");
	writeln(PerimetroRectangulo);
	write("El area del paralelogramo es:");
	writeln(AreaParal);
	write("El perimetro del paralelogramo es:");
	writeln(PerimetroParal);
	write("El area del rombo es:");
	writeln(AreaRombo);
	write("El perimetro del rombo es:");
	writeln(PerimetroRombo);
	write("El lado del rombo es:");
	writeln(Igualdad);
	write("El Area del trapecio es:");
	writeln(AreaTrapecio);
	write("El perimetro del trapecio es:");
	writeln(PerimetroTrapecio);
	write("El area total del octaedro es:");
	writeln(AreaTotalOctaedro);
	write("El area de una cara del octaedro es:");
	writeln(AreaCaraOctaedro);
	write("El volumen del octaedro es:");
	writeln(VolumenOctaedro);
	write("El area total del dodecaedro es:");
	writeln(AreaTotalDodecaedro);
	write("El area de una cara del dodecaedro es:");
	writeln(AreaCaraDodecaedro);
	write("El volumen del dodecaedro es:");
	writeln(VolumenDodecaedro);
	write("El area total del icosaedro es:");
	writeln(AreaTotalIcosaedro);
	write("El area de una cara del icosaedro es:");
	writeln(AreaCaraIcosaedro);
	write("El volumen del icosaedro es:");
	writeln(VolumenIcosaedro);
}
