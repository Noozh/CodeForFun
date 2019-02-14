with Ada.Text_IO, Ada.Characters.Handling;

procedure Dia_Siguiente is
	package T_IO renames Ada.Text_IO;
	package ACH renames Ada.Characters.Handling;
	type Tipo_Semana is (Lunes,Martes,Miercoles,Jueves,Viernes,Sabado,Domingo);
	Dia:Tipo_Semana;
	package Semana_InOut is new T_IO.Enumeration_IO(Tipo_Semana);

	function Es_Lunes (Dia:Tipo_Semana) return Boolean is
	begin
		return Dia=Lunes;
	end Es_Lunes;

	function Es_Domingo (Dia:Tipo_Semana) return Boolean is
	begin
		return Dia=Domingo;
	end Es_Domingo;

	procedure Escribir_Anterior (Dia: in Tipo_Semana) is
	begin
		if Es_Lunes(Dia) then 	
			T_IO.Put(ACH.To_Lower(Tipo_Semana'Image(Domingo)));
		else
			T_IO.Put(ACH.To_Lower(Tipo_Semana'Image(Tipo_Semana'Pred(Dia))));
		end if;
		T_IO.Put(" ");
	end Escribir_Anterior;

	procedure Escribir_Actual (Dia: in Tipo_Semana) is
	begin
		T_IO.Put(ACH.To_Lower(Tipo_Semana'Image(Dia)));
		T_IO.Put(" ");
	end Escribir_Actual;

	procedure Escribir_Siguiente (Dia: in Tipo_Semana) is
	begin
		if Es_Domingo(Dia) then
			T_IO.Put(ACH.To_Lower(Tipo_Semana'Image(Lunes)));
		else			
			T_IO.Put(ACH.To_Lower(Tipo_Semana'Image(Tipo_Semana'Succ(Dia))));
		end if;
		T_IO.Put(" ");
	end Escribir_Siguiente;

begin
	T_IO.Put("Introduce el dia de la semana: ");
	Semana_InOut.Get(Dia);
	Escribir_Anterior(Dia);
	Escribir_Actual(Dia);
	Escribir_Siguiente(Dia);
end Dia_Siguiente;
