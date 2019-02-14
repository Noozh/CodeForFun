with Ada.Text_IO, Ada.Calendar, Ada.Strings.Unbounded, Ada.Characters.Handling;

procedure Calendario is
	package T_IO renames Ada.Text_IO;
	package Calendar renames Ada.Calendar;
	package ASU renames Ada.Strings.Unbounded;
	package ACH renames Ada.Characters.Handling;

	type Tipo_Fecha is record
		Anno: Calendar.Year_Number;
		Mes: Calendar.Month_Number;
		Dia: Calendar.Day_Number;
	end record;

	Date:Tipo_Fecha;
	function Quitar_Espacio_I (I:Integer) return String is
	begin
		return ASU.To_String(ASU.Tail(ASU.To_Unbounded_String(Integer'Image(I)), Integer'Image(I)'Length-1));
	end Quitar_Espacio_I;

	procedure Obtener_Fecha(Date: out Tipo_Fecha) is
		Fecha:Calendar.Time;
	begin
		Fecha:=Calendar.Clock;
		Date.Anno:=Calendar.Year(Fecha);
		Date.Mes:=Calendar.Month(Fecha);
		Date.Dia:=Calendar.Day(Fecha);
	end Obtener_Fecha;

	procedure Escribir_Fecha(Date: in Tipo_Fecha) is
	begin
		T_IO.Put(Quitar_Espacio_I(Date.Dia));
		T_IO.Put("/");
		T_IO.Put(Quitar_Espacio_I(Date.Mes));
		T_IO.Put("/");
		T_IO.Put(Quitar_Espacio_I(Date.Anno));
	end Escribir_Fecha;
begin 
	Obtener_Fecha(Date);
	Escribir_Fecha(Date);
end Calendario;