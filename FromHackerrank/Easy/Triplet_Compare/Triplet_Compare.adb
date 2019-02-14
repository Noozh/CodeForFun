with Ada.Text_IO;
with Ada.Strings.Unbounded;
with Ada.Integer_Text_IO;

procedure Triplet_Compare is
    package T_IO renames Ada.Text_IO;
    package ASU renames Ada.Strings.Unbounded;
    package I_IO renames Ada.Integer_Text_IO;

    type Triplet is record
        x:Natural;
        y:Natural;
        z:Natural;
    end record;

    procedure Read_Line (Trip: out Triplet) is
        Line:ASU.Unbounded_String;
        Index:Natural:=0;
    begin
        Line:= ASU.To_Unbounded_String(T_IO.Get_Line);
        Index:=ASU.Index(Line," ");
        Trip.x:= Integer'Value(ASU.To_String(ASU.Head(Line,Index-1)));
        Line:= ASU.Tail(Line,ASU.Length(Line) - Index);
        Index:=ASU.Index(Line," ");
        Trip.y:= Integer'Value(ASU.To_String(ASU.Head(Line,Index-1)));
        Line:= ASU.Tail(Line,ASU.Length(Line) - Index);
        Index:=ASU.Index(Line," ");
        Trip.z:= Integer'Value(ASU.To_String(Line));
    end Read_Line;

    function Bob_Victory (Bob_Trip: Triplet;Alice_Trip: Triplet) return Natural is
        Points:Natural:=0;
    begin
        if Bob_Trip.x > Alice_Trip.x then
            Points:= Points +1;
        end if;
        if Bob_Trip.y > Alice_Trip.y then
            Points:= Points +1;
        end if;
        if Bob_Trip.z > Alice_Trip.z then
            Points:= Points +1;
        end if;
        return Points;
    end Bob_Victory;


    function Allice_Victory (Bob_Trip: Triplet;Alice_Trip: Triplet) return Natural is
        Points:Natural:=0;
    begin
        if Bob_Trip.x < Alice_Trip.x then
            Points:= Points +1;
        end if;
        if Bob_Trip.y < Alice_Trip.y then
            Points:= Points +1;
        end if;
        if Bob_Trip.z < Alice_Trip.z then
            Points:= Points +1;
        end if;
        return Points;
    end Allice_Victory;

    Bob_Triplet,Alice_Triplet: Triplet;
begin
    Read_Line(Bob_Triplet);
    Read_Line(Alice_Triplet);
    I_IO.Put(Bob_Victory(Bob_Triplet,Alice_Triplet),Width =>0);
    T_IO.Put(" ");
    I_IO.Put(Allice_Victory(Bob_Triplet,Alice_Triplet),Width =>1);
end Triplet_Compare;
