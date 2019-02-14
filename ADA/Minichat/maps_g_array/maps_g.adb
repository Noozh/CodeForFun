--En la P3 hay que instanciar este paquete dos veces. Una para clientes activos y otra para clientes inactivos.

with Ada.Text_IO;
with Ada.Unchecked_Deallocation;

package body Maps_G is

  procedure Get (M       : Map;
                Key     : in  Key_Type;
                Value   : out Value_Type;
                Success : out Boolean) is
    Index:Natural:=0;
  begin
    Success := False;
    while not Success and Index < M.Length loop
      if M.P_Array(Index).Key = Key then
        Value := M.P_Array(Index).Value;
        Success := True;
      end if;
      Index:=Index+1;
    end loop;
  end Get;

  procedure Put (M     : in out Map;
                Key   : Key_Type;
                Value : Value_Type) is
    -----NUEVA CELDA------
    procedure Add_Cell(M:in out Map;Key:in Key_Type; Value:in Value_Type;Full:in Boolean) is
    begin
      M.P_Array(M.Length).Key:=Key;
      M.P_Array(M.Length).Value:=Value;
      M.Length:=M.Length+1;
    end Add_Cell;
    Index:Natural:=0;
    Found:Boolean:= False;
  begin
    while not Found and then Index < M.Length loop
      if M.P_Array(Index).Key = Key then
        M.P_Array(Index).Value := Value;
        Found := True;
      end if;
      Index:=Index+1;
    end loop;
    if not Found and then M.Length /= N_Max then
      Index:=0;
      Add_Cell(M,Key,Value,True);
    elsif not Found and then M.Length = N_Max then
      raise Full_Map;
    end if;
  end Put;

  procedure Delete (M      : in out Map;
                   Key     : in  Key_Type;
                   Success : out Boolean) is
    Index:Natural:=0;
  begin
    Success:=False;
    while not Success and then Index < M.Length  loop
      if M.P_Array(Index).Key = Key then
        Success := True;
        M.P_Array(Index):=M.P_Array(M.Length-1);
        M.Length:=M.Length-1;
      end if;
      Index:=Index+1;
    end loop;
  end Delete;

  function Map_Length (M : Map) return Natural is
  begin
    return M.Length;
  end Map_Length;
--
  function First (M: Map) return Cursor is
  begin
    return (M => M, Element_A => M.P_Array(0),Pos =>0);
  end First;
--
  procedure Next (C: in out Cursor) is
  begin
    C.Pos:=C.Pos+1;
    if C.Pos< C.M.Length then
      C.Element_A := C.M.P_Array(C.Pos);
    end if;
  end Next;

  function Element (C: Cursor) return Element_Type is
  begin
    return (Key   => C.Element_A.Key,
            Value => C.Element_A.Value);
  end Element;
--
  function Has_Element (C: Cursor) return Boolean is
  begin
      return C.Pos<C.M.Length;
  end Has_Element;
end Maps_G;
