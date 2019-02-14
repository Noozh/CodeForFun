with Ada.Text_IO, Ada.Float_Text_IO;

procedure Salario is
	package T_IO renames Ada.Text_IO;
	package F_IO renames Ada.Float_Text_IO;
	type Tipo_Sueldo is record
		Horas:Float;
		Precio:Float;
	end record;
	Salario:Tipo_Sueldo;

	function Calcular_Salario(Salario:Tipo_Sueldo) return Float is
	begin
		return Salario.Horas*Salario.Precio;
	end Calcular_Salario;

	function Calcular_SS(Devengos:Float) return Float is
	begin
		return 0.2*(Devengos-600.0);
	end Calcular_SS;

	function Calcular_IRPF(Devengos:Float) return Float is
	begin
		return 0.15*Devengos;
	end Calcular_IRPF;



	procedure Escribir_Salario (Salario: in Tipo_Sueldo) is
		Sueldo_Bruto:Float;
		Sueldo_Neto:Float;
		IRPF: Float;
		SS:Float;
	begin
		Sueldo_Bruto:=Calcular_Salario(Salario);
		T_IO.Put("El salario bruto es: ");
		F_IO.Put(Sueldo_Bruto, Exp => 0);
		IRPF:= Calcular_IRPF(Sueldo_Bruto);
		SS:=0.0;
		if Sueldo_Bruto > 600.0 then
			SS := Calcular_SS(Sueldo_Bruto);
		end if;
		T_IO.New_Line;
		Sueldo_Neto:=Sueldo_Bruto-SS-IRPF;
		T_IO.Put("El salario neto: ");
		F_IO.Put(Sueldo_Neto, Exp => 0);
	end Escribir_Salario;

begin 
	T_IO.Put("Introduce horas trabajadas ");
	F_IO.Get(Salario.Horas);
	T_IO.Put("Introduce precio por hora ");
	F_IO.Get(Salario.Precio);
	Escribir_Salario(Salario);
end Salario;