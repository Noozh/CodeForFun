with Ada.Text_IO;
with Ada.Strings.Unbounded;
with Ada.Integer_Text_IO;

procedure Diagonal_Difference is
    package T_IO renames Ada.Text_IO;
    package ASU renames Ada.Strings.Unbounded;
    package I_IO renames Ada.Integer_Text_IO;

    M:Natural:=1000;

    type Vector is array (0..M-1) of Integer;
    type Mat is array (0..M-1) of Vector;

    procedure Read_Input (Matrix: out Mat;N_Elem:out Natural) is
        Line:ASU.Unbounded_String;
        Index:Natural:=0;
    begin
        N_Elem:=Natural'Value(T_IO.Get_Line);
        Line:= ASU.To_Unbounded_String(T_IO.Get_Line);
        for I in 0 .. N_Elem-1 loop
            for K in 0.. N_Elem-1 loop
                if K < N_Elem-1 then
                    Index:=ASU.Index(Line," ");
                    --T_IO.Put_Line("a");
                    Matrix(I)(K):= Integer'Value(ASU.To_String(ASU.Head(Line,Index-1)));
                    Line:= ASU.Tail(Line,ASU.Length(Line) - Index);
                else
                    Matrix(I)(K):= Integer'Value(ASU.To_String(Line));
                end if;
            end loop;
        end loop;
    end Read_Input;

    function Diagonal_Sum(Matrix:Mat; Inverse:Boolean) return Integer is
        Sum:Integer:= 0;
        Aux:Natural;
    begin
        if not Inverse then
            for I in 0 .. M-1 loop
                Sum:=Sum + Matrix(I)(I);
            end loop;
            return Sum;
        else
            Aux:=M-1;
            for I in 0 .. M-1 loop
                Sum:=Sum + Matrix(I)(Aux);
                Aux:=Aux-1;
            end loop;
            return Sum;
        end if;
    end Diagonal_Sum;

    Matrix:Mat;
    N_Elem:Natural;
begin
    Read_Input(Matrix,N_Elem);
    M:=N_Elem;
    I_IO.Put(abs(Diagonal_Sum(Matrix,False)+Diagonal_Sum(Matrix,True)));
end Diagonal_Difference;
