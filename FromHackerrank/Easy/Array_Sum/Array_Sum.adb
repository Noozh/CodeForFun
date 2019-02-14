with Ada.Text_IO;
with Ada.Strings.Unbounded;
with Ada.Integer_Text_IO;

procedure Array_Sum is
    package T_IO renames Ada.Text_IO;
    package ASU renames Ada.Strings.Unbounded;
    package I_IO renames Ada.Integer_Text_IO;

    type Collention_Type is array (0.. 100000) of Integer;

    procedure Read_Input (N_Elem:out Natural; Collection: out Collention_Type) is
        Line:ASU.Unbounded_String;
        Index:Natural:=0;
    begin
        N_Elem:=Natural'Value(T_IO.Get_Line);
        Line:= ASU.To_Unbounded_String(T_IO.Get_Line);
        for I in 0 .. N_Elem-1 loop
            if I < N_Elem-1 then
                Index:=ASU.Index(Line," ");
                Collection(I):= Integer'Value(ASU.To_String(ASU.Head(Line,Index-1)));
                Line:= ASU.Tail(Line,ASU.Length(Line) - Index);
            else
                Collection(I):= Integer'Value(ASU.To_String(Line));
            end if;
        end loop;
    end Read_Input;

    function Collection_Value (N_Elem:Natural;Collection: Collention_Type) return Integer is
        Sum:Integer:=0;
    begin
        for I in 0 .. N_Elem-1 loop
            Sum:= Sum + Collection(I);
        end loop;
        return Sum;
    end Collection_Value;

    N_Elem:Natural;
    Collection:Collention_Type;
begin
    Read_Input(N_Elem,Collection);
    I_IO.Put(Collection_Value(N_Elem,Collection),Width => 0);
    T_IO.New_Line;
end Array_Sum;
