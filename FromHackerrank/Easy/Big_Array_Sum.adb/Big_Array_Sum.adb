with Ada.Text_IO;
with Ada.Strings.Unbounded;
with Ada.Integer_Text_IO;

procedure Big_Array_Sum is
    package T_IO renames Ada.Text_IO;
    package ASU renames Ada.Strings.Unbounded;
    package I_IO renames Ada.Integer_Text_IO;

    type My_Integer_64 is range -(2**63) .. +(2**63 - 1);
    type Collention_Type is array (0.. 100000) of My_Integer_64;

    procedure Read_Input (N_Elem:out Natural; Collection: out Collention_Type) is
        Line:ASU.Unbounded_String;
        Index:Natural:=0;
    begin
        N_Elem:=Natural'Value(T_IO.Get_Line);
        Line:= ASU.To_Unbounded_String(T_IO.Get_Line);
        for I in 0 .. N_Elem-1 loop
            if I < N_Elem-1 then
                Index:=ASU.Index(Line," ");
                Collection(I):= My_Integer_64'Value(ASU.To_String(ASU.Head(Line,Index-1)));
                Line:= ASU.Tail(Line,ASU.Length(Line) - Index);
            else
                Collection(I):= My_Integer_64'Value(ASU.To_String(Line));
            end if;
        end loop;
    end Read_Input;

    function Collection_Value (N_Elem:Natural;Collection: Collention_Type) return My_Integer_64 is
        Sum:My_Integer_64:=0;
    begin
        for I in 0 .. N_Elem-1 loop
            Sum:= Sum + Collection(I);
        end loop;
        return Sum;
    end Collection_Value;

    N_Elem:Natural;
    Collection:Collention_Type;
    Chain:ASU.Unbounded_String;
begin
    Read_Input(N_Elem,Collection);
    Chain:=ASU.To_Unbounded_String(My_Integer_64'Image(Collection_Value(N_Elem,Collection)));
    T_IO.Put(ASU.To_String(ASU.Tail(Chain,ASU.Length(Chain) - 1)));
    T_IO.New_Line;
end Big_Array_Sum;
