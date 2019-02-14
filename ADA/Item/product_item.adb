with Ada.Text_IO, Ada.Strings.Unbounded;

procedure Product_Item is
	package T_IO renames Ada.Text_IO;
	package  ASU renames Ada.Strings.Unbounded;
	Item:Integer;
	Product:Integer;
begin 
	Item:=4;
	Product:=1000;
	if Item/=0 then
		Product:=Item*Product;
		T_IO.Put(ASU.To_String(ASU.Tail(ASU.To_Unbounded_String(Integer'Image(Product)), Integer'Image(Product)'Length-1))); -- Linea para quitar un espacio en blanco
	else
		T_IO.Put("Me como los mocos");
	end if;
end Product_Item;