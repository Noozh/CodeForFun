with Ada.Text_IO;

procedure Ordenar_Letras is
	package T_IO renames Ada.Text_IO;
	S:String(1..4);

	procedure Swap(A:in out Character; B:in out Character) is
	Aux:Character;
	begin
		Aux:=A;
		A:=B;
		B:=Aux;
	end Swap;

	procedure Ordenar_Palabra(Palabra:in String) is
	begin
		for J in 1..4  loop
			for I in J..4 loop
				if S(J)>S(I) then
					Swap(S(I),S(J));
				end if;
			end loop;
		end loop;
	end Ordenar_Palabra;

begin 
	T_IO.Get(S);
	Ordenar_Palabra(S);
	T_IO.Put(S(1));
end Ordenar_Letras;