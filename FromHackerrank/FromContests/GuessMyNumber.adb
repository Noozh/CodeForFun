with Ada.Strings.Maps;
with Ada.Strings.Unbounded;
with Ada.Text_IO;
with Ada.Integer_Text_IO;

procedure Solution is

	package ASU renames Ada.Strings.Unbounded;
	package AIT renames Ada.Integer_Text_IO;
	use type ASU.Unbounded_String;

	use type ASU.Unbounded_String;

	Input: ASU.Unbounded_String;

	Cota_Max :Integer := 1000;
	Cota_Min :Integer:= 1;
   Number :Integer:=500;

	Text: ASU.Unbounded_String;
	N_Saltos: Integer:= 50;

   --function Trunk (Chain: ASU.Unbounded_String) return Integer is
   --begin
   --   return Integer'Value(ASU.To_String(ASU.Head(Chain,ASU.Index(Chain,".")-1)));
   --end Trunk;

begin
   Input:= ASU.To_Unbounded_String(Ada.Text_IO.Get_Line); -- guess my number
	loop
      Number:=500;
      Cota_Min:=0;
      Cota_Max:=1000;
      AIT.put(Number,Width => 0);
      Ada.text_io.New_Line;
      --Text:= ASU.To_Unbounded_String(Ada.Text_IO.Get_Line);
		loop
         --Ada.text_io.Put_Line(ASU.To_String(Text));
         --Ada.text_io.Put_Line(Integer'Value(Cota_Min));
         Text:= ASU.To_Unbounded_String(Ada.Text_IO.Get_Line);
         if Text = ASU.To_Unbounded_String("bigger") then
				Cota_Min := Number;
            Number:=Cota_Min+((Cota_Max - Cota_Min) / 2);
            AIT.put(Number,Width => 0);
            Ada.text_io.New_Line;
         end if;
			if Text = ASU.To_Unbounded_String("smaller") then
            Cota_Max := Number;
            Number:=Cota_Min+((Cota_Max - Cota_Min) / 2);
            AIT.put(Number,Width => 0);
            Ada.text_io.New_Line;
			end if;
         exit when Text = ASU.To_Unbounded_String("start-over") or Text = ASU.To_Unbounded_String("quit");
		end loop;
		exit when Text = ASU.To_Unbounded_String("quit");
	end loop;
end Solution;

