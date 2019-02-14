with Ada.Text_IO ,Ada.Float_Text_IO;

procedure Libras is
	peso:Float;  --En libras--
	lib: Constant Float := 0.453592;
	function kilos (peso:Float)return Float is
	begin
		return peso*lib;
	end kilos;
begin
	Ada.Text_IO.Put("Introduce el peso en libras: ");
	Ada.Float_Text_IO.Get(peso);
	Ada.Text_IO.Put("El peso en kilogramos es:" & Float'Image(kilos(peso)));
	Ada.Text_IO.Put("El peso en gramos es:" & Float'Image(kilos(peso)*1000.0));
end Libras;