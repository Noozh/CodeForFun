program casillas;

procedure readcoord(ref x: char,ref y: int)
{
	writeln("Introduce primera componente");
	readln(x);
	writeln("Introduce segunda componente:");
	readln(y);
}

procedure swapcasilla(ref x1: char, ref y1: int, ref x2: char, y2: int)
	auxchar: char;
	auxint: int;
{
	auxchar=x1;
	x1=x2;
	x2=auxchar;
	auxint=y1;
	y1=y2;
	y2=auxint;
}

function escasillamayor(x1: char,y1: int, x2: char, y2: int):bool
{
	return x1>x2 or (x1==x2 and y1>y2);
}

procedure ordenarcoord(ref x1: char,ref y1: int,ref x2: char, ref y2: int)
{
	if(escasillamayor(x1,y1,x2,y2))
	{
		swapcasilla(x1,y1,x2,y2);
	}
}

/*Se tratan las casillas de alrededor como tres columnas*/

procedure mostrarcolumizq(x: char,y: int)
{
	write(pred(x));
	write(y-1);
	write(" ");
	write(pred(x));
	write(y);
	write(" ");
	write(pred(x));
	write(y+1);
	write(" ");
}

procedure mostrarcolumcent(x: char,y: int)
{
	write(x);
	write(y-1);
	write(" ");
	write(x);
	write(y+1);
	write(" ");
}

procedure mostrarcolumdcha(x: char,y: int)
{
	write(succ(x));
	write(y-1);
	write(" ");
	write(succ(x));
	write(y);
	write(" ");
	write(succ(x));
	writeln(y+1);
}

procedure main()
	x1: char;
	y1: int;
	x2: char;
	y2: int;
{
	readcoord(x1,y1);
	readcoord(x2,y2);
	ordenarcoord(x1,y1,x2,y2);
	mostrarcolumizq(x1,y1);
	mostrarcolumcent(x1,y1);
	mostrarcolumdcha(x1,y1);
}
