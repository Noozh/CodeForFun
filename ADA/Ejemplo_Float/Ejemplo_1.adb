--                                                                                 
-- Ejemplo de uso de Float_Text_IO.Put para dar formato a números reales           
-- Ver más información aquí: https://es.wikibooks.org/wiki/Programaci%C3%B3n_en_Ad\a/Unidades_predefinidas/Ada.Float_Text_IO                                          
--                                                                                 
--                                                                                 

with Ada.Text_IO;
with Ada.Float_Text_IO;

procedure Float_IO_Test is

   F : Float := 1254.1234;

begin
   Ada.Float_Text_IO.Put (F);
   Ada.Text_IO.New_Line;

   Ada.Float_Text_IO.Put (F, Fore => 4, Aft => 2, Exp => 0);
   Ada.Text_IO.New_Line;

end Float_IO_Test;
