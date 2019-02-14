program salario;

consts:
	SegNivel=50000.0;
	PrimNivel=100000.0;
	GratificacionABC=5000.0;
	GratificacionEK=2000.0;
	DescuentoImpar=3000.0;
	LimiteSalarial=10000.0; /*En las condiciones mas adversas un sueldo por debajo de esta cantidad no esta sujeto a descuento */

function letravalida(letra:char):bool
{
	return letra>='A' and letra<='K';
}	
function niveluno(salario:float):bool
{
	return salario>=PrimNivel;
}

function niveldos(salario:float):bool
{
	return salario<PrimNivel and salario>=SegNivel;
}

function par(num:int):bool
{
	return num%2==0;
}

function abc(letra:char):bool
{
	return letra>='A' and letra<='C';
}

function porcentaje(salario:float):float
{
	return salario*0.1;
}

function enrango(salario:float):bool
{
	return salario>=LimiteSalarial;
}

function aumento(numnif:int,letranif:char,salario:float):float
{
	if(letravalida(letranif)){
		if (niveluno(salario))
		{
			return 0.0;
		}else if (niveldos(salario)){
			if(par(numnif)){
				if(abc(letranif)){
					return GratificacionABC;
				}else{
					return GratificacionEK;
				}
			}else{
				if(abc(letranif)){
					return GratificacionABC-DescuentoImpar;
				}else{
					return GratificacionEK;
				}
			}
		}else{
			if(par(numnif)){
				if(abc(letranif)){
					return porcentaje(salario)+GratificacionABC;
				}else{
					return porcentaje(salario)+GratificacionEK;
				}
			}else{
				if(abc(letranif)){
					return porcentaje(salario)+GratificacionABC-DescuentoImpar;
				}else{
					if(enrango(salario)){
						return porcentaje(salario)+GratificacionEK-DescuentoImpar;
					}else{
						return porcentaje(salario)+GratificacionEK;
					}
				}
			}
		}
	}else{
		return 0.0;
	}
}

consts:
	LetraNIF='A';
	NumNIF=21;
	SalarioActual=40000.0;

procedure main()
{
	writeln(aumento(NumNIF,LetraNIF,SalarioActual));
}
