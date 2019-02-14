with Ada.Float_Text_IO;

procedure Intercambiar is
	X:Float;
	Y:Float;
	package T_IO renames Ada.Float_Text_IO;
	procedure Swap(Var1: out Float; Var2:out Float) is
	aux:Float;
	begin
		aux:=Var1;
		Var1:=Var2;
		Var2:=aux;
	end Swap;
begin 
	X:=1.0;
	Y:=0.0;
	if Y>X then
		Swap(X,Y);
	end if;
	T_IO.Put(X, Exp => 0);
	T_IO.Put(Y, Exp => 0);
end Intercambiar;