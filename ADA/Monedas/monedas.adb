
with Ada.Text_IO, Ada.Integer_Text_IO;            
--use  Ada.Text_IO, Ada.Integer_Text_IO;

procedure Monedas is
	--type Valores is (5, 10, 20, 50, 1, 2);
	type Value is array (Natural range 1 .. 6) of Float;
	val:Value:=(0.05, 0.1, 0.2, 0.5, 1.0, 2.0);
	type Coins is array (Natural range 1 .. 6) of Natural;
	token:Coins;

	function Calcular_Total (monedas: Coins) return Float is
		resultado: Float;
	begin
		for Indice in 1..6 loop
			resultado:=resultado+(Float(token(Indice))*val(Indice));
		end loop;
	return resultado;
	end Calcular_Total;

begin
	for Indice in 1..6 loop
		Ada.Text_IO.Put("Monedas de " & Float'Image(val(Indice)) & ":");
		Ada.Integer_Text_IO.Get(token(Indice));
	end loop;
	Ada.Text_IO.Put("Hay: " & Float'Image(Calcular_Total(token)) & " euros" );
end Monedas;
