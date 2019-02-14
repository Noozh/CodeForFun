with Ada.Text_IO , Ada.Integer_Text_IO;

procedure Producto_Suma is
	x:Integer;
	y:Integer;
	z:Integer;
	procedure Leer_Entrada (x:out Integer;y:out Integer;z:out Integer) is
	begin
		Ada.Integer_Text_IO.Get(x);
		Ada.Integer_Text_IO.Get(y);
		Ada.Integer_Text_IO.Get(z);
	end Leer_Entrada;
begin
	Leer_Entrada(x,y,z);
	Ada.Text_IO.Put("Resultado de la suma: " & Integer'Image(x+y+z));
	Ada.Text_IO.New_Line;
	Ada.Text_IO.Put("Resultado del producto: " & Integer'Image(x*y*z));
end Producto_Suma;