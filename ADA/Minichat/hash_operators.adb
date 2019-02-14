
with Ada.Text_IO;
package body Hash_Operators is

  function Get_Value (Word:String) return Integer is
    Length:Natural:=ASU.Length(ASU.To_Unbounded_String(Word));
    Value:Integer:=0;
  begin
    for I in 1..Length loop
      Value:=Value + Character'Pos(Word(I));
    end loop;
    return Value;
  end Get_Value;

  function Hash (Word: ASU.Unbounded_String) return  My_Hash_Range is
  begin
    return My_Hash_Range'Mod(Get_Value(ASU.To_String(Word)));
  end Hash;
end Hash_Operators;
