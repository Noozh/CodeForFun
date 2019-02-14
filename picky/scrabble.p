program scrabble;

/*-----------------------Bloque de declaracion------------------------------------------*/
consts:
	LongPal=20;
	MinY='A';
	MaxY='O';
	MinX=1;
	MaxX=15;
	Jugador1=1;
	Jugador2=2;

types:
	TipoCasilla=record{
		x:int;
		y:char;
	};
	TipoID=(Doble,Triple);
	TipoCasillaEsp=record
	{
		id:TipoID;
		casilla:TipoCasilla;
	};
	TipoEspecial=array[0..224] of TipoCasillaEsp;
	TipoElemEsp=record
	{
		casillas:TipoEspecial;
		nelem:int;
	};
	TipoPal= array[0..LongPal-1] of char;
	TipoPalabra=record
	{
		palabra:TipoPal;
		long:int;
		valor:int;
	};
	TipoOrientacion=(abajo,derecha);
	TipoJugada=record
	{
		pal:TipoPalabra;
		coord:TipoCasilla;
		dir:TipoOrientacion;
	};
	TipoPartida= array[1..200] of TipoJugada;
	TipoColumna= array [MinY..MaxY] of char;
	TipoTablero=array [MinX..MaxX] of TipoColumna;
	TipoPuntuacion= array['a'..'z'] of int;

consts:
	Puntuacion=TipoPuntuacion(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26);
	
	
	
/*-----------------------Fin del bloque------------------------------------------*/


/*-----------------------Bloque leer casillas especiales------------------------------------------*/

procedure initablero(ref tablero:TipoTablero)
	c:char;
	i:int;
{
	c='A';
	do{
		for(i=1,i<=15){
			tablero[i][c]=' ';
		}
		c=succ(c);
	}while(c<='O');
}

procedure leercasilla(ref casilla:TipoCasilla)
{
	readln(casilla.y);
	readln(casilla.x);
}

procedure leerespecial(ref cas:TipoCasillaEsp)
{
	readln(cas.id);
	leercasilla(cas.casilla);
}

function escolumvalida(columna:int):bool
{
	return columna>=MinX and columna<=MaxX;
}	

function esfilavalida(fila:char):bool
{
	return fila>=MinY and fila<=MaxY;
}	

function estadentro(casilla:TipoCasilla):bool
{
	return escolumvalida(casilla.x) and esfilavalida(casilla.y);
}

function estarepe(casilla:TipoCasilla, conjunto:TipoElemEsp):bool
	i:int;
{
	i=0;
	while(casilla!=conjunto.casillas[i].casilla and i<conjunto.nelem){
		i=i+1;
	}
	return casilla==conjunto.casillas[i].casilla;
}

function escorrecta(casilla:TipoCasilla,conjunto:TipoElemEsp):bool
{
	return estadentro(casilla) and not(estarepe(casilla,conjunto));
}

procedure leerespeciales(ref cas:TipoElemEsp)
	c:char;
	casesp:TipoCasillaEsp;
{
	cas.nelem=0;
	do{
		peek(c);
		if(c!='@'){
			leerespecial(casesp);
			if(escorrecta(casesp.casilla,cas)){
				cas.casillas[cas.nelem]=casesp;
				cas.nelem=cas.nelem+1;
			}
		}
	}while(c!='@');
	readln(c); /*Se lee para eliminar el @*/
}

/*-----------------------Fin de bloque------------------------------------------*/

/*-----------------------Lectura de jugadas------------------------------------------*/

procedure leerpalabra(ref pal:TipoPalabra)
{
	pal.long=0;
	do{
		read(pal.palabra[pal.long]);
		pal.long=pal.long+1;
	}while(not eol());
	pal.long=pal.long-1;
	readeol();
}

procedure leerdireccion(ref direccion:TipoOrientacion)
{
	readln(direccion);
}

/*Subbloque de comprobacion de jugadas*/
function esminus(letra:char):bool
{
	return letra>='a' and letra<='z';
}

function espalok(pal:TipoPalabra):bool
	i:int;
{
	i=0;
	while(i<pal.long and esminus(pal.palabra[i])){
		i=i+1;
	}
	return esminus(pal.palabra[i-1]);
}

function eslongok(long:int,coord:TipoCasilla,dir:TipoOrientacion):bool
{
	switch(dir){
		case abajo:
			return char(int(coord.y)+long)<=succ(MaxY);
		case derecha:
			return coord.x+long<=MaxX+1;
		default:
			return True;
	}
}

function esprimjug(long:int,coord:TipoCasilla,dir:TipoOrientacion):bool
{
	switch(dir){
		case abajo:
			return int(coord.y)+long>int('H') and coord.y<='H' and coord.x==8;
		case derecha:
			return coord.x+long>8 and coord.x<=8 and coord.y=='H';
		default:
			return True;
	}
}

function esposok(jugada:TipoJugada,tablero:TipoTablero):bool
	i:int;
{
	i=0;
	switch(jugada.dir){
		case abajo:
			while(i<jugada.pal.long-1 and (jugada.pal.palabra[i]==tablero[jugada.coord.x][char(int(jugada.coord.y)+i)] or tablero[jugada.coord.x][char(int(jugada.coord.y)+i)]==' ')){
				i=i+1;
			}
			return jugada.pal.palabra[i]==tablero[jugada.coord.x][char(int(jugada.coord.y)+i)] or tablero[jugada.coord.x][char(int(jugada.coord.y)+i)]==' ';
		case derecha:
			while(i<jugada.pal.long-1 and (jugada.pal.palabra[i]==tablero[jugada.coord.x+i][jugada.coord.y] or tablero[jugada.coord.x+i][jugada.coord.y]==' ')){
				i=i+1;
			}
			return jugada.pal.palabra[i]==tablero[jugada.coord.x+i][jugada.coord.y] or tablero[jugada.coord.x+i][jugada.coord.y]==' ';
		default:
			return True;	
	}
}

function hayhueco(jugada:TipoJugada, tablero:TipoTablero):bool
	i:int;
{
	i=0;
	switch(jugada.dir){
		case abajo:
			while(i<jugada.pal.long and tablero[jugada.coord.x][char(int(jugada.coord.y)+i)]!=' '){
				i=i+1;
			}
			return tablero[jugada.coord.x][char(int(jugada.coord.y)+i)]==' ';
		case derecha:
			while(i<jugada.pal.long and tablero[jugada.coord.x+i][jugada.coord.y]!=' '){
				i=i+1;
			}
			return tablero[jugada.coord.x+i][jugada.coord.y]==' ';
		default:
			return False;	
	}
}

function hayletra(jugada:TipoJugada,tablero:TipoTablero):bool
	i:int;
{
	i=0;
	switch(jugada.dir){
		case abajo:
			while(i<jugada.pal.long-1 and jugada.pal.palabra[i]!=tablero[jugada.coord.x][char(int(jugada.coord.y)+i)]){
				i=i+1;
			}
			return jugada.pal.palabra[i]==tablero[jugada.coord.x][char(int(jugada.coord.y)+i)];
		case derecha:
			while (i<jugada.pal.long-1 and jugada.pal.palabra[i]!=tablero[jugada.coord.x+i][jugada.coord.y]){
				i=i+1;
			}
			return jugada.pal.palabra[i]==tablero[jugada.coord.x+i][jugada.coord.y];
		default:
			return False;	
	}
}

function esjugcorr(jugada:TipoJugada,numjug:int,tablero:TipoTablero):bool
{
	if(numjug==1){
		return espalok(jugada.pal) and eslongok(jugada.pal.long,jugada.coord,jugada.dir) and esprimjug(jugada.pal.long,jugada.coord,jugada.dir);
	}else{
		if(eslongok(jugada.pal.long,jugada.coord,jugada.dir)){
			return espalok(jugada.pal) and esposok(jugada,tablero) and hayhueco(jugada,tablero) and hayletra(jugada,tablero);
		}else{
			return False;
		}
	}
}
/*Fin del subbloque*/

procedure leerjugada(ref jugada:TipoJugada)
{
	leerpalabra(jugada.pal);
	leercasilla(jugada.coord);
	leerdireccion(jugada.dir);
}

procedure colocarjugada(jugada:TipoJugada, ref tablero:TipoTablero)
	i:int;
	j:int;
	c:char;
	k:int;
{
	j=0;
	switch(jugada.dir){
		case abajo:
			c=jugada.coord.y;
			i=int(c);
			k=i+jugada.pal.long;
			do{
				tablero[jugada.coord.x][c]=jugada.pal.palabra[j];
				j=j+1;
				i=i+1;
				c=succ(c);
			}while(i<k);
		case derecha:
			for(i=jugada.coord.x, i<jugada.coord.x+jugada.pal.long){
				tablero[i][jugada.coord.y]=jugada.pal.palabra[j];
				j=j+1;
			}
	}
}

procedure cassig(ref cas:TipoCasilla, dir:TipoOrientacion)
{
	switch(dir){
		case abajo:
			cas.y=succ(cas.y);
		case derecha:
			cas.x=cas.x+1;
		default:
			writeeol();
	}
}

procedure buscaresp(ref cas:TipoCasilla, ref casesp:TipoElemEsp,ref valor:int,letra:char)
	i:int;
{
	for (i=0,i<casesp.nelem){
		if(cas==casesp.casillas[i].casilla){
			switch(casesp.casillas[i].id){
				case Doble:
					valor=valor+Puntuacion[letra]; 
					casesp.casillas[i].casilla.x=0;
				case Triple:
					valor=valor+(2*Puntuacion[letra]);
					casesp.casillas[i].casilla.x=0;
				default:
					writeeol();
			}
		}
	}
	valor=valor+Puntuacion[letra];
}

procedure calcvalorpal(ref jugada:TipoJugada,ref casesp:TipoElemEsp)
	j:int;
	cas:TipoCasilla;
{
	jugada.pal.valor=0;
	cas=jugada.coord;
	for(j=0,j<jugada.pal.long){
		buscaresp(cas,casesp,jugada.pal.valor,jugada.pal.palabra[j]);
		cassig(cas,jugada.dir);
	}
}

procedure leerjugadas(ref jugada:TipoJugada, ref tablero:TipoTablero,ref numjug:int, ref partida:TipoPartida, casesp:TipoElemEsp)
	c:char;
	i:int;
{
	i=1;
	do{
		peek(c);
		if(c!='#' and c!=Eof){
			leerjugada(jugada);
			if (esjugcorr(jugada,i,tablero)){
				calcvalorpal(jugada,casesp);
				colocarjugada(jugada,tablero);
				i=i+1;
				if(jugada.pal.palabra[0]=='e'){
					jugada.pal.valor=0;
				}
			}else{
				jugada.pal.valor=0;
			}
			partida[numjug]=jugada;
			numjug=numjug+1;
		}
	}while(c!='#' and c!=Eof);
}
/*-----------------------Fin del bloque------------------------------------------*/

/*-----------------------Bloque de puntuacion-----------------------------------------*/
procedure escribirpalabra(pal:TipoPalabra)
	i:int;
{
	for(i=0,i<pal.long){
		write(pal.palabra[i]);
	}
}

function calcularpartida(partida:TipoPartida ,numjug:int, jugador:int):int
	i:int;
	tot:int;
{
	tot=0;
	i=jugador;
	while(i<numjug){
		tot=tot+partida[i].pal.valor;
		i=i+2;
	}
	return tot;
}

procedure escribirganador(res1:int, res2:int)
{
	if(res1>res2){
		writeln ("Gana el Jugador 1");
	}else if(res1<res2){
		writeln ("Gana el Jugador 2");
	}else{
		writeln ("Empate");
	}
}

procedure escribirpartida(partida:TipoPartida,numjug:int)
	i:int;
{
	i=Jugador1;
	writeln("Jugador 1:");
	while(i<numjug){
		escribirpalabra(partida[i].pal);
		write(":");
		writeln(partida[i].pal.valor);
		i=i+2;
	}
	write("Total:");
	writeln(calcularpartida(partida,numjug,Jugador1));
	i=Jugador2;
	writeln("Jugador 2:");	
	while(i<numjug){
		escribirpalabra(partida[i].pal);
		write(":");
		writeln(partida[i].pal.valor);
		i=i+2;
	}
	write("Total:");
	writeln(calcularpartida(partida,numjug,Jugador2));
	escribirganador(calcularpartida(partida,numjug,Jugador1),calcularpartida(partida,numjug,Jugador2));
}


/*-----------------------Fin del bloque------------------------------------------*/


procedure escribirjugadas(partida:TipoPartida , numjug:int)
	i:int;
{
	for(i=1,i<numjug){
		escribirpalabra(partida[i].pal);
		writeeol();
		writeln(partida[i].coord.y);
		writeln(partida[i].coord.x);
		writeln(partida[i].dir);
	}
}

procedure escribirtablero(tablero:TipoTablero)
	c:char;
	i:int;
{
	c='A';
	do{
		for(i=1,i<=15){
			write("[");
			write(tablero[i][c]);
			write("]");
		}
		c=succ(c);
		writeeol();
	}while(c<='O');
}

procedure sinopciones(ref casesp:TipoElemEsp,ref tablero:TipoTablero,ref jugada:TipoJugada,ref partida:TipoPartida,ref numjug:int)
{
	initablero(tablero);
	leerespeciales(casesp);
	leerjugadas(jugada,tablero,numjug,partida,casesp);
	escribirtablero(tablero);
	if(numjug!=1){
		escribirpartida(partida,numjug);
	}else{
		writeln("No ha habido jugadas");
	}
}

procedure main()
	casesp:TipoElemEsp;			
	tablero:TipoTablero;
	jugada:TipoJugada;
	partida:TipoPartida;
	numjug:int;							
{
	numjug=1;
	sinopciones(casesp,tablero,jugada,partida,numjug);
}
