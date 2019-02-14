with Ada.Text_IO, Ada.Integer_Text_IO;

procedure Ordenar is
	package T_IO renames Ada.Text_IO;
	package I_IO renames Ada.Integer_Text_IO;
	type Tipo_Coleccion is array (1..3) of Integer;
	Muestras:Tipo_Coleccion;

	procedure Recoger_Muestras(Muestras:out Tipo_Coleccion; Cantidad:in Natural) is
	begin
		for Indice in 1..Cantidad loop
			T_IO.Put("Introduce la muestra numero" & Integer'Image(Indice) & ": ");
			I_IO.Get(Muestras(Indice));
		end loop;
	end Recoger_Muestras;

	procedure Swap (A:out Integer; B:out Integer) is
		Aux:Integer;
	begin
		Aux:=A;
		A:=B;
		B:=Aux;
	end Swap;

	procedure Ordenar_Muestras (Muestras: out Tipo_Coleccion; Cantidad:in Natural) is
	begin
		for J in 1..Cantidad loop
			for Indice in J..Cantidad loop
				if Muestras(J) > Muestras(Indice) then
					Swap(Muestras(J),Muestras(Indice));
				end if;
			end loop;
		end loop;
	end Ordenar_Muestras;
begin 
	Recoger_Muestras(Muestras,3);
	Ordenar_Muestras(Muestras,3);
	I_IO.Put(Muestras(1));
	I_IO.Put(Muestras(2));
	I_IO.Put(Muestras(3));
end Ordenar ;