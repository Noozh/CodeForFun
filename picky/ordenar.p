program ordenar;

consts:
	TamanoBaraja=40;

types:
	TipoPalo=(Oros, Copas, Espadas, Bastos);
	TipoValor=int 1..10;
	TipoCarta=record{
		palo:TipoPalo;
		valor:TipoValor;
	};
	TipoCartas= array[0..3*TamanoBaraja] of TipoCarta; /*Incluimos la posibilidad de leer hasta 3 barajas de 40 cartas*/
	TipoBaraja=record{
		baraja:TipoCartas;
		ncartas:int;
	};

procedure leercarta(ref carta:TipoCarta, ref prox:char)
{
	peek(prox);
	if(prox!= Eof){
		readln(carta.palo);
		readln(carta.valor);
	}
}

procedure leernaipes(ref baraja:TipoBaraja,ref prox:char)
	carta:TipoCarta;
{
	do{
		leercarta(carta,prox);
		baraja.baraja[baraja.ncartas]=carta;
		baraja.ncartas=baraja.ncartas+1;
	}while(prox!=Eof);
}

procedure escribircarta(carta:TipoCarta)
{
	write("[");
	write(carta.palo);
	write(",");
	write(carta.valor);
	writeln("]");
}

procedure escribirnaipes(baraja:TipoBaraja)
	j:int;
{
	for(j=0,j<baraja.ncartas-1){
		if(baraja.ncartas-1!=0){
			escribircarta(baraja.baraja[j]);
		}
	}
}

function esmayor(carta1:TipoCarta, carta2:TipoCarta):bool
{
	if (carta1.palo==carta2.palo){
		return carta1.valor > carta2.valor ;
	}else{
		return carta1.palo>carta2.palo;
	}
}

procedure ordenarcarta(ref carta1:TipoCarta,ref carta2:TipoCarta)
	aux:TipoCarta;
{
	aux=carta1;
	carta1=carta2;
	carta2=aux;
}

procedure ordenarnaipes(ref baraja:TipoBaraja)
	i:int;
	j:int;
	aux:TipoCarta;
{
	for(i=0, i<baraja.ncartas-1){
		aux=baraja.baraja[i];
		for(j=i, j<baraja.ncartas-1){
			if(esmayor(aux,baraja.baraja[j])){
				ordenarcarta(aux,baraja.baraja[j]);
			}
		baraja.baraja[i]=aux;
		}
	}
}

procedure main()
	siguiente:char;
	naipes:TipoBaraja;
	prox:char;
{
	naipes.ncartas=0;
	leernaipes(naipes,prox);
	ordenarnaipes(naipes);
	escribirnaipes(naipes);
}
