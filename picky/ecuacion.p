program ecuacion;
	
function esecseggrad(a:float):bool
{
	return a!=0.0;
}

function esraizreal(a:float,b:float,c:float):bool
{
	return b**2.0-4.0*a*c>=0.0;
}

function solucion1(a:float,b:float,c:float):float
{
	return (-b+sqrt(b**2.0-4.0*a*c))/(2.0*a);
}

function solucion2(a:float,b:float,c:float):float
{
	return (-b-sqrt(b**2.0-4.0*a*c))/(2.0*a);
}

function tienesoldob(a:float,b:float,c:float):bool
{
	return solucion1(a,b,c)==solucion2(a,b,c);
}

function parteimaginaria(a:float,b:float,c:float):float
{
	return sqrt(-1.0*(b**2.0-4.0*a*c))/(2.0*a);
}

function partereal (a:float,b:float):float
{
	return -b/(2.0*a);
}

consts:
	A=2.0;
	B=1.0;
	C=2.0;
procedure main()
{
	if(esecseggrad(A)){
		if(esraizreal(A,B,C)){
			if(tienesoldob(A,B,C)){
				write("x= ");
				writeln(solucion1(A,B,C));
			}else{
				write("x1= ");
				writeln(solucion1(A,B,C));
				write("x2= ");
				writeln(solucion2(A,B,C));
			}
		}else{
			write("x1= ");
			write(partereal(A,B));
			write(" + ");
			write(parteimaginaria(A,B,C));
			writeln("i");
			write("x2= ");
			write(partereal(A,B));
			write(" - ");
			write(parteimaginaria(A,B,C));
			writeln("i");
		}
	}else{
		writeln("No es ecuacion de segundo grado");
	}
}
