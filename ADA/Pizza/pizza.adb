with Ada.Text_IO , Ada.Float_Text_IO;

procedure Pizza is
	Pi: Constant Float:= 3.14159;
	type pizz is
	record
		Diametro:Float;
		Precio:Float;
	end record;
	Cena:pizz;
	function area(Radio:Float) return Float is
	begin
		return Pi*Radio*Radio;
	end area;

begin
	Ada.Text_IO.Put("Introduce el diametro en metros de la pizza: ");
	Ada.Float_Text_IO.Get(Cena.Diametro);
	Ada.Text_IO.Put("Introduce el pecio de la pizza: ");
	Ada.Float_Text_IO.Get(Cena.Precio);
	Ada.Text_IO.Put("El metro cuadrado de pizza vale: " & Float'Image(Cena.Precio/area(Cena.Diametro/2.0)));
end Pizza;
