with Ada.Text_IO ,Ada.Calendar;

procedure Fecha is
	package T_IO renames Ada.Text_IO;
	package Calendario renames Ada.Calendar;
	type Tipo_Fecha is record
		Y:Calendario.Year_Number;
		M:Calendario.Month_Number;
		D:Calendario.Day_Number;
	end record;
	Date:Tipo_Fecha;

	procedure Obtener_Fecha(Fecha: out Tipo_Fecha ) is
	begin
		Fecha.Y:=Calendario.Year(Calendario.Clock);
		Fecha.M:=Calendario.Month(Calendario.Clock);
		Fecha.D:=Calendario.Day(Calendario.Clock);
	end Obtener_Fecha;

	procedure Escribir_Fecha (Fecha: in Tipo_Fecha) is
	begin
		T_IO.Put(Calendario.Day_Number'Image(Fecha.D) & "/" & Calendario.Year_Number'Image(Fecha.M) & "/" & Calendario.Year_Number'Image(Fecha.Y));
	end Escribir_Fecha;

begin
	T_IO.Put("La fecha actual es: ");
	Obtener_Fecha(Date);
	Escribir_Fecha(Date);
end Fecha;