program pangramas;

consts:
	MaxFrase=1000;
	LetraPrim='A';
	LetraUltima='Z';
	DistLetras=int('A')-int('a');
	
types:	
	TipoLetras=array[0..MaxFrase] of char;
	TipoFrase=record{
		frase:TipoLetras;
		long:int;
	};
	TipoNumLetras=array [LetraPrim..LetraUltima] of bool;
	
procedure leerfrase(ref frase:TipoFrase , fichero:file)	
	i:int;
	c:char;
{
	frase.long=0;
	do{
		fpeek(fichero,c);
		if(not (feof(fichero) or feol(fichero))){
			fread(fichero,frase.frase[frase.long]);
			frase.long=frase.long+1;
		}
	}while( not(feof(fichero) or feol(fichero)));
	freadeol(fichero);
}

function esminus(c:char):bool
{
	return c>='a'and c<='z';
}

procedure transformar(ref c:char)
	
{
	c=char(int(c)+DistLetras);
}

procedure reescribirfrase(ref frase:TipoFrase)
	i:int;
{
	for(i=0,i<frase.long){
		if(esminus(frase.frase[i])){
			transformar(frase.frase[i]);
		}
	}
}

function esblanco(c:char):bool
{
	return c==' ';
}

function espangrama(frase:TipoFrase):bool
	letras:TipoNumLetras;
	i:int;
	c:char;
	valido:bool;
{
	valido=True;
	for(c='A',c<=LetraUltima){
		letras[c]=False;
	}
	for(i=0,i<frase.long){
		if(not esblanco(frase.frase[i])){
			letras[frase.frase[i]]=True;
		}
	}
	for(c='A',c<=LetraUltima){
		if(letras[c]==False){
			valido=False;
		}
	}
	return valido;
}

procedure escribirfrase(frase:TipoFrase)
	i:int;
{
	for(i=0,i<frase.long){
		write(frase.frase[i]);
	}
	writeeol();
}

procedure escribirpangrama(frase:TipoFrase)
{
	if (espangrama(frase)){
		escribirfrase(frase);
	}
}

procedure buscarpangramas(fichero:file)
	fras:TipoFrase;
	c:char;
{
	fpeek(fichero,c);
	while(not feof(fichero)){
		leerfrase(fras, fichero);
		reescribirfrase(fras);
		escribirpangrama(fras);
		fpeek(fichero,c);
	}
}

procedure main()
	datos:file;
{
	open(datos, "datos.txt", "r");
	buscarpangramas(datos);
	close(datos);
}
