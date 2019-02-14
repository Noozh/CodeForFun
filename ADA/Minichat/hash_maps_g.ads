generic
  type Key_Type is private;
  type Value_Type is private;
  with function "=" (K1, K2: Key_Type) return Boolean;
  type Hash_Range is mod <>;
  with function Hash (K:Key_Type) return Hash_Range;
  Module: in Natural;
  Max: in Natural;

package Hash_Maps_G is

  type Map is limited private;

  procedure Get (M      : in out Map;
                Key     : in  Key_Type;
                Value   : out Value_Type;
                Success : out Boolean);

  Full_Map : exception;

  procedure Put (M    : in out Map;
                Key   : Key_Type;
                Value : Value_Type);

  procedure Delete (M         : in out Map;
                    Key       : in  Key_Type;
                    Success   : out Boolean);


  function Map_Length (M : Map) return Natural;

  type Cursor is limited private;

  function First (M: Map) return Cursor; --Primer elemento de la colección

  procedure Next (C: in out Cursor); --Devuelve el siguiente elemento de la coleccion

  function Has_Element (C: Cursor) return Boolean; --Dice si el cursor tiene elemento

  type Element_Type is record
    Key:   Key_Type;
    Value: Value_Type;
  end record;

  No_Element: exception;

  function Element (C: Cursor) return Element_Type; -- Da el valor de key y value al que apunta

private

  type Cell;
  type Cell_A is access Cell;

  type Cell is record
    Key   : Key_Type;
    Value : Value_Type;
    Full  : Boolean := False;
    Next  : Cell_A := null;
  end record;

  type Cell_Array is array (0..Module-1) of Cell_A ;
  type Cell_Array_A is access Cell_Array;

  type Map is record
    P_Array: Cell_Array_A := new Cell_Array;
    Length : Natural := 0;
  end record;

  type Cursor is record
    M         : Map;
    Element_A : Cell_A;
    Pos       :Natural := 0;
  end record;

end Hash_Maps_G;
