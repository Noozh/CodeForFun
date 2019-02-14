program volumen;

consts:
	Pi=3.1415;

function apot(longlado:float ,nlados:int):float
{
	return (longlado/2.0)*tan((Pi*(float(nlados)-2.0))/(float(nlados)*2.0));
}

function perim(longlado:float ,nlados:int):float
{
	return longlado*float(nlados);
}

function areapolig(longlado:float ,nlados:int):float
{
	return perim(longlado ,nlados)*apot(longlado ,nlados)/2.0;
}
function volprisma(longlado:float ,altpris:float ,nlados:int):float
{
	return areapolig(longlado ,nlados)*altpris;
}

function volpiram(longlado:float ,altpiram:float ,nlados:int):float
{
	return (areapolig(longlado ,nlados)*altpiram)/3.0;
}

function volpoliedro(longlado:float ,nlados:int ,altpris:float ,altpiram:float):float
{
	return volprisma(longlado ,altpris ,nlados)+(2.0*volpiram(longlado ,altpiram ,nlados));
}

consts:
	LadoPoligono=2.0;
	NumeroLadosPoligono=6;
	AlturaPrisma=2.0;
	AlturaPiramide=2.0;
	
procedure main()
{
	write("El volumen del poliedro es: ");
	write(volpoliedro(LadoPoligono ,NumeroLadosPoligono ,AlturaPrisma ,AlturaPiramide));
	writeln(" unidades cubicas");
}
