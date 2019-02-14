with Ada.Text_IO;
package body Ordered_Maps_G is

    procedure Get (M      : Map;
                    Key     : in  Key_Type;
                    Value   : out Value_Type;
                    Success : out Boolean) is
        Pos:Natural;
    begin
        Pos:= M.Length/2;
        Success:=False;
        if Key < M.P_Array(Pos).Key  then
            --Buscar a la izquierda
            while Pos >= 0 and not Success and  Key < M.P_Array(Pos).Key loop
                if Key = M.P_Array(Pos).Key  then
                    Value := M.P_Array(Pos).Value;
                    Success:=True;
                end if;
                Pos:=Pos-1;
            end loop;
        else
            --Buscar a la derecha
            while Pos <= M.Length and not Success and M.P_Array(Pos).Key < Key loop
                if Key = M.P_Array(Pos).Key  then
                    Value := M.P_Array(Pos).Value;
                    Success:=True;
                end if;
                Pos:=Pos+1;
            end loop;
        end if;
    end Get;

    procedure Put (M    : in out Map;
                    Key   : Key_Type;
                    Value : Value_Type) is
        Pos:Natural;
        Cell_Aux_Prev:Cell;
        Cell_Aux_Next:Cell;
        Success:Boolean;
    begin
        Pos:= M.Length/2;
        Success:=False;
        if Key < M.P_Array(Pos).Key  then
            --Buscar a la izquierda
            while Pos > 0 and not Success and  Key < M.P_Array(Pos).Key loop
                if Key = M.P_Array(Pos).Key  then
                    M.P_Array(Pos).Value:=Value;
                    Success:=True;
                end if;
                Pos:=Pos-1;
            end loop;
        else
            --Buscar a la derecha
            while Pos < M.Length and not Success and M.P_Array(Pos).Key < Key loop
                if Key = M.P_Array(Pos).Key  then
                    M.P_Array(Pos).Value:=Value;
                    Success:=True;
                end if;
                Pos:=Pos+1;
            end loop;
        end if;
        if not Success then
            Cell_Aux_Prev:=M.P_Array(Pos);
            M.P_Array(Pos).Key:=Key;
            M.P_Array(Pos).Value:=Value;
            M.Length:=M.Length+1;
            while Pos+1 < M.Length loop
                Cell_Aux_Next:=M.P_Array(Pos+1);
                M.P_Array(Pos+1):=Cell_Aux_Prev;
                Cell_Aux_Prev:=Cell_Aux_Next;
                Pos:=Pos+1;
            end loop;
        end if;
    end Put;

    procedure Delete (M         : in out Map;
                        Key       : in  Key_Type;
                        Success   : out Boolean) is
        Pos:Natural;
    begin
        Pos:= M.Length/2;
        Success:=False;
        if Key < M.P_Array(Pos).Key  then
            --Buscar a la izquierda
            while Pos >= 0 and not Success and  Key < M.P_Array(Pos).Key loop
                if Key = M.P_Array(Pos).Key  then
                    Success:=True;
                end if;
                Pos:=Pos-1;
            end loop;
        else
            --Buscar a la derecha
            while Pos <= M.Length and not Success and M.P_Array(Pos).Key < Key loop
                if Key = M.P_Array(Pos).Key  then
                    Success:=True;
                end if;
                Pos:=Pos+1;
            end loop;
        end if;
        if Success then
            while Pos+1 < M.Length loop
                M.P_Array(Pos):=M.P_Array(Pos+1);
                Pos:=Pos+1;
            end loop;
            M.Length:=M.Length - 1;
        end if;
    end Delete;

    function Map_Length (M : Map) return Natural is
    begin
        return M.Length;
    end Map_Length;

    function First (M: Map) return Cursor is
    begin
        return (M => M , Element_C => M.P_Array(0) , Pos => 0 );
    end First;

    procedure Next (C: in out Cursor) is
    begin
        C.Pos:=C.Pos+1;
        C.Element_C:=C.M.P_Array(C.Pos);
    end Next;

    function Has_Element (C: Cursor) return Boolean is
    begin
        return C.Pos < C.M.Length;
    end Has_Element;

    function Element (C: Cursor) return Element_Type is
    begin
        return (Key => C.Element_C.Key , Value => C.Element_C.Value);
    end Element;

end Ordered_Maps_G;
