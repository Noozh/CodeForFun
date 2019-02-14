program alumnos;
types:
	Letra=array[0..22] of char;
	
consts:
	LetraNIF= Letra('T','R','W','A','G','M','Y','F','P','D','X','B','N','J','Z','S','Q','V','H','L','C','K','E');
	
types:
	TipoRama=(Ciencias, Ingenieria, Humanidades);
	TipoNumNIF=int 1..99999999;
	TipoNIF=record
	{
		num:TipoNumNIF;
		letra:char;
		
	};
	TipoAlumno=record
	{
		nif:TipoNIF;
		rama:TipoRama;
		nota:float;
	};
	Alumnos=array[0..4] of TipoAlumno;
		
procedure leernif(ref nif:TipoNIF)
{
	readln(nif.num);
	readln(nif.letra);
}		

function calcularletra(nifnum:int):int
{
	return nifnum%23;
}

function esnif(nif:TipoNIF):bool
	res: int;
{
	res=calcularletra(nif.num);
	return LetraNIF[res]==nif.letra;
}
	
		
procedure leeralumno(ref alumno:TipoAlumno)
{
	leernif(alumno.nif);
	if (esnif(alumno.nif)){
		readln(alumno.rama);
		readln(alumno.nota);
	}else{
		fatal("NIF incorrecto");
	}
}

procedure mostrarnif(nif:TipoNIF)
{
	write(nif.num);
	write(nif.letra);
}

function esrama(rama1:TipoRama , rama2:TipoRama):bool
{
	return rama1==rama2;
}

procedure mostraralumno(alumno:TipoAlumno, rama:TipoRama)
{
	if (esrama(alumno.rama,rama)){
		write("(NIF: ");
		mostrarnif(alumno.nif);
		write(" ,RAMA: ");
		write(alumno.rama);
		write(" ,NOTA: ");
		write(alumno.nota);
		writeln(")");
	}
}

function notamedia(notatot:float, numnotas:float):float
{
	if(int(numnotas)!=0){
		return notatot/numnotas;
	}else{
		return 0.0;
	}
}

procedure main()
	alumno:TipoAlumno;
	lista:Alumnos;
	i:int;
	j:int;
	rama:TipoRama;
	notatot:float;
{
	for(i=0,i<=4){
		leeralumno(alumno);
		lista[i]=alumno;
	}
	readln(rama);
	for(i=0,i<=4){
		mostraralumno(lista[i],rama);
	}
	notatot=0.0;
	j=0;
	for(i=0,i<=4){
		if(lista[i].rama==rama){
			notatot=notatot+lista[i].nota;
			j=j+1;
		}
	}
	write("MEDIA: ");
	writeln(notamedia(notatot,float(j)));
}
