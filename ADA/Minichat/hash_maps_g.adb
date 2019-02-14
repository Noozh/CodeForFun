with Ada.Text_IO;
with Ada.Unchecked_Deallocation;
package body Hash_Maps_G is

    procedure Free is new Ada.Unchecked_Deallocation (Cell, Cell_A);

    procedure Get (M      : in out Map;
                  Key     : in  Key_Type;
                  Value   : out Value_Type;
                  Success : out Boolean) is
        Pos:Natural;
        P_Aux:Cell_A;
    begin
        Pos:= Natural(Hash(Key));
        P_Aux:= M.P_Array(Pos);
        Success:=False;
        while P_Aux /= null and then not Success loop
            if P_Aux.Key = Key then
                Success:= True;
                Value:= P_Aux.Value;
            end if;
            P_Aux:= P_Aux.Next;
        end loop;
    end Get;

    procedure Put (M    : in out Map;
                  Key   : Key_Type;
                  Value : Value_Type) is
        Pos:Natural;
        P_Aux:Cell_A;
        Found:Boolean;
    begin
        Pos:= Natural(Hash(Key));
        P_Aux:= M.P_Array(Pos);
        Found:=False;
        -- Buscamos si ya existe Key
        while P_Aux /= null and then not Found loop
            if P_Aux.Key = Key then
                Found := True;
                P_Aux.Value:= Value;
            end if;
            P_Aux:= P_Aux.Next;
        end loop;
         --No se ha encontrado
        if not Found then
            if M.Length = Max then
                raise Full_Map;
            end if;
            M.P_Array(Pos):= new Cell'(Key, Value, True, M.P_Array(Pos));
            M.Length:= M.Length+1;
        end if;
    end Put;

    procedure Delete (M         : in out Map;
                      Key       : in  Key_Type;
                      Success   : out Boolean) is
        Pos:Natural;
        P_Current:Cell_A;
        P_Aux:Cell_A;
    begin
        Success:=False;
        Pos:= Natural(Hash(Key));
        P_Current:= M.P_Array(Pos);
        if M.P_Array(Pos).Key = Key then
            M.P_Array(Pos):=M.P_Array(Pos).Next;
            Free(P_Current);
            Success:=True;
            M.Length:=M.Length-1;
        else
            while P_Current /= null and then P_Current.Key /= Key loop
                P_Aux:= P_Current;
                P_Current:= P_Current.Next;
            end loop;
            if P_Current.Key = Key then
                P_Aux.Next:=P_Current.Next;
                Free(P_Current);
                Success := True;
                M.Length:=M.Length-1;
            end if;
        end if;
    end Delete;

    function Map_Length (M : Map) return Natural is
    begin
        return M.Length;
    end Map_Length;

    function First (M: Map) return Cursor is
        C:Cursor;
    begin
        C.Pos:=0;
        while M.P_Array(C.Pos) = null and then C.Pos < Module-1 loop
            C.Pos:=C.Pos+1;
        end loop;
        return (M => M, Element_A => M.P_Array(C.Pos), Pos => C.Pos);
    end First;

    procedure Next (C: in out Cursor) is
    begin
        if C.Element_A.Next /= null then
            C.Element_A:=C.Element_A.Next;
        else
            C.Pos:=C.Pos+1;
            while C.M.P_Array(C.Pos) = null and then C.Pos+1 <= Module-1 loop
                C.Pos:=C.Pos+1;
            end loop;
            C.Element_A:= C.M.P_Array(C.Pos);
        end if;
    end Next;

    function Has_Element (C: Cursor) return Boolean is
    begin
        return C.Pos < Module-1 or C.Element_A /= null;
    end Has_Element;

    function Element (C: Cursor) return Element_Type is
    begin
        return (Key => C.Element_A.Key,
                Value => C.Element_A.Value);
    end Element;

end Hash_Maps_G;
