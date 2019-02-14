--
--  TAD genérico de una tabla de símbolos (map) implementada como una lista
--  enlazada no ordenada.
--

generic
   type Key_Type is private;
   type Value_Type is private;
   N_Max: in Natural ;
   with function "=" (K1, K2: Key_Type) return Boolean;
package Maps_G is

   type Map is limited private;

   procedure Get (M       : Map;
                  Key     : in  Key_Type;
                  Value   : out Value_Type;
                  Success : out Boolean);


   Full_Map : exception;
   procedure Put (M     : in out Map;
                  Key   : Key_Type;
                  Value : Value_Type);

   procedure Delete (M      : in out Map;
                     Key     : in  Key_Type;
                     Success : out Boolean);


   function Map_Length (M : Map) return Natural;
  -- Cursor Interface for iterating over Map elements

   type Cursor is limited private;
   function First (M: Map) return Cursor; --Primer elemento de la colección
   procedure Next (C: in out Cursor); --Devuelve el siguiente elemento de la coleccion
   function Has_Element (C: Cursor) return Boolean; --Dice si el cursor tiene elemento
   type Element_Type is record
      Key:   Key_Type;
      Value: Value_Type;
   end record;
   No_Element: exception;

  -- Raises No_Element if Has_Element(C) = False;
   function Element (C: Cursor) return Element_Type; -- Da el valor de key y value al que apunta

private

  type Cell is record
    Key   : Key_Type;
    Value : Value_Type;
    Full : Boolean := False;
  end record;

  type Cell_Array is array (0..N_Max-1) of Cell;
  type Cell_Array_A is access Cell_Array;

  type Map is record
    P_Array: Cell_Array_A := new Cell_Array;
    Length : Natural := 0;
  end record;

  type Cursor is record
    M         : Map;
    Element_A : Cell;
    Pos:Natural;
  end record;

end Maps_G;
