with Ada.Strings.Maps;
with Ada.Strings.Unbounded;
with Ada.Text_IO;

procedure Solution is

	package ASU renames Ada.Strings.Unbounded;
	use type ASU.Unbounded_String;

	Input: ASU.Unbounded_String;
	I: Integer;
	Numbers: constant String := "0" & "1" & "2"& "3"& "4" & "5" & "6" & "7"
								& "8" & "9";

	Count: ASU.Unbounded_String;

	OutPut: ASU.Unbounded_String;

	function Gruas (Value: ASU.Unbounded_String) return ASU.Unbounded_String is
   	devolver:String :="";
      Cadena:ASU.Unbounded_String:= ASU.Trim(Value,Ada.Strings.Maps.To_Set("abcdefghijklmnñopqrstuvwxyz : - Importe Cantidad Total € $"),Ada.Strings.Maps.To_Set("Importe Saldo : abcdefghijklmnñopqrstuvwxyz -Cantidad Total € $"));
      N: Integer;
   begin
		N := ASU.Index(Cadena,",");
		if N /= 0 then -- no tengo un punto
			ASU.Replace_Element(Cadena, ASU.Index(Cadena,","), '.');
		end if;

   	return Cadena;
   end Gruas;

	N: Integer;

begin
	Input:= ASU.To_Unbounded_String(Ada.Text_IO.Get_Line);
	I:= ASU.Index((Input), Ada.Strings.Maps.To_Set(Numbers)) - 1;
	Count := ASU.Tail(Input, ASU.Length(Input)- I);
	I := ASU.Index(Count, "$");
	OutPut := ASU.Head(Count, I-1);
	N := ASU.Index(OutPut,",");
   begin
	     ASU.Replace_Element(Output, ASU.Index(OutPut,","), '.');
   exception
      when Others =>
         Ada.Text_IO.Put("");
   end;
   --if ASU.Index(Input,"l") /= 0 and then ASU.Index(Input,"$") /= 0 then
	if Gruas(Input) = OutPut then
	  Ada.Text_IO.Put("OK");
	else
		Ada.Text_IO.Put(ASU.To_String(OutPut));
	end if;

end Solution;

