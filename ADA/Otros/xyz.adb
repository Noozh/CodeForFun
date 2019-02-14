with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Strings.Unbounded;

procedure Xyz is
	package T_IO renames Ada.Text_IO;
	package I_IO renames Ada.Integer_Text_IO;
	package ASU renames Ada.Strings.Unbounded;
	X:Integer;
	Y:Integer;
	Z:Integer;
	procedure Recoger_Datos (A:out Integer; B:out Integer; C:out Integer) is
	begin
		T_IO.Put("Introduce los datos:");
		T_IO.New_Line;
		I_IO.Get(A);
		I_IO.Get(B);
		I_IO.Get(C);
	end Recoger_Datos;

	function Quitar_Espacio_I (I:Integer) return String is
	begin
		return ASU.To_String(ASU.Tail(ASU.To_Unbounded_String(Integer'Image(I)), Integer'Image(I)'Length-1));
	end Quitar_Espacio_I;

	function Quitar_Espacio_F (F:Float) return String is
	begin
		return ASU.To_String(ASU.Tail(ASU.To_Unbounded_String(Float'Image(F)), Float'Image(F)'Length-1));
	end Quitar_Espacio_F;

	procedure Escribir_Salida(A:in Integer; B:in Integer; C:in Integer) is
	begin
		T_IO.Put(Quitar_Espacio_I(A+B+C));
		T_IO.New_Line;
		T_IO.Put(Quitar_Espacio_I(A*B*C));
	end Escribir_Salida;

begin
	Recoger_Datos(X,Y,Z);
	Escribir_Salida(X,Y,Z);
end Xyz;