program solitario;

types:
	TipoPaloBasta=(Oros, Bastos, Copas, Espadas,Basta);
	TipoPalo=TipoPaloBasta Oros .. Espadas;
	TipoNumCarta=int 1 .. 9;
	TipoColor=(Rojo,Verde);
	TipoCarta=record
	{
		palo:TipoPaloBasta;
		num:TipoNumCarta;
		col:TipoColor;
	};



function espar(num:TipoNumCarta):bool
{
	return num%2 == 0;
}

function estipo1(palo:TipoPalo):bool
{
	return (palo == Oros) or (palo == Copas);
}

function sumatoriopar(num:int):int
	value:int;
{
	value=0;
	for(num=num , num>=0){
		if (espar(num))
		{
			value=value+num;
		}else{
		    value=value;
		}	
	}
	return value;
}

function sumatorioimpar(num:int):int
	value:int;
{
	value=0;
	for(num=num ,num>=0){
		if (espar(num))
		{
			value=value;
		}else{
		    value=value+num;
		}	
	}
	return value;
}

function valorcarta(carta:TipoCarta):int
{
	if(estipo1(carta.palo))
	{
		return sumatoriopar(carta.num);
	}else{
		return sumatorioimpar(carta.num);
	}
}

procedure leercarta(ref carta:TipoCarta)
{
	writeln("Introduce una carta:");
	readln(carta.palo);
	if(carta.palo!=Basta)
	{
		readln(carta.num);
		readln(carta.col);	
	}
}

procedure main()
	carta:TipoCarta;
	result:int;
	primcol:TipoColor;
{
	result=0;
	leercarta(carta);
	primcol=carta.col;
	result=valorcarta(carta);
	while (carta.palo!=Basta)
    {
		leercarta(carta);
		if(carta.col==primcol)
        {
			if(carta.palo!=Basta){
				result=result+valorcarta(carta);
			}
        }
    }
    writeln(result);     
}
