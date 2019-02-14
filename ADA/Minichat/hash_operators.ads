with Ada.Strings.Unbounded;
generic
    type My_Hash_Range is mod <>;
    
package Hash_Operators is
  package ASU renames Ada.Strings.Unbounded;


  function Get_Value (Word:String) return Integer;

  function Hash (Word: ASU.Unbounded_String) return  My_Hash_Range;

end Hash_Operators;
