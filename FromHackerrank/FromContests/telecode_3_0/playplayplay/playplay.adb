with Ada.Text_IO;
with Ada.Strings.Unbounded;
with Ada.Command_Line;
with Ada.IO_Exceptions;
--librerias
procedure PlayPlay is
	-- Constantes Universales
	-- renames
	package T_IO renames Ada.Text_IO;
	package ASU renames Ada.Strings.Unbounded;
	package C_L renames Ada.Command_Line;
	-- Tipos
	-- Paquetes
	-- Funciones
	-- Procedimientos
	procedure LeerInteger(I : out Integer) is
	begin -- LeerInteger
		I  := Integer'Value(Ada.Text_IO.Get_Line);
	end LeerInteger;
	-- Declaraciones del programa principal(variables)
	End_File : Boolean := False;
	I : Integer;
	N : Integer := 0;
	T : Integer;
	T_Error : exception;
	Memoria : Integer := -3;
	OK : Boolean := True;
	Array_Bool : array(0..80000) of Boolean;
	First_Time : Boolean;

begin
	LeerInteger(T);
		if T < 0 and T > 80000 then
			raise T_Error;
		end if;
	for X in 1..T loop
		OK := True;
		Memoria := -3;
		I := -3;
		First_Time := True;
		while not End_File and N < (10**6) and I /= 0 loop
			begin
			LeerInteger(I);
			if First_Time then
				Memoria := I;
				First_Time := False;
			else
				OK := Memoria/2 = I;
				if OK then
					Memoria := I;
				end if;
			end if;
			exception
			when Ada.IO_Exceptions.End_Error =>
				End_File := True;
			end;
			N := N + 1;
		end loop;
		Array_Bool(X) := OK;
		exit when End_File;	
	end loop;

	for X in 1..T loop
		OK := Array_Bool(X);		
		if OK then
			Ada.Text_IO.Put_Line("GANADORES");
		else
			Ada.Text_IO.Put_Line("DESCALIFICADOS");
		end if;
	end loop;
exception
	when T_Error=>
		null;
end PlayPlay;