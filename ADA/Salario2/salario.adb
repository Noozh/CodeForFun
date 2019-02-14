with Ada.Text_IO, Ada.Float_Text_IO;

procedure Salario is
	package T_IO renames Ada.Text_IO;
	package F_IO renames Ada.Float_Text_IO;
	type Tipo_Sueldo is record
		Horas:Float;
		Precio:Float;
	end record;
	Salario:Tipo_Sueldo;

	function Calcular_Horas (Salario:Tipo_Sueldo) return Float is
	begin 
		return (Salario.Horas-160.0)*0.5*Salario.Precio;
	end Calcular_Horas;

	function Calcular_Bruto(Salario:Tipo_Sueldo) return Float is
	Sueldo_Bruto:Float;
	begin
		Sueldo_Bruto:=Salario.Horas*Salario.Precio;
		if Salario.Horas>160.0 then
			Sueldo_Bruto:=Sueldo_Bruto+Calcular_Horas(Salario);
		end if;
		return Sueldo_Bruto;
	end Calcular_Bruto;

	function Calcular_SS(Salario:Tipo_Sueldo) return Float is
	begin
		return 0.2*(Calcular_Bruto(Salario)-600.0);
	end Calcular_SS;

	function Calcular_IRPF(Salario:Tipo_Sueldo) return Float is
	begin
		return 0.15*Calcular_Bruto(Salario);
	end Calcular_IRPF;

	function Calcular_Neto(Salario:Tipo_Sueldo) return Float is
	begin
		return Calcular_Bruto(Salario)-Calcular_SS(Salario)-Calcular_IRPF(Salario);
	end Calcular_Neto;

	procedure Escribir_Salario (Salario: in Tipo_Sueldo) is
	begin
		T_IO.Put("El salario bruto es: ");
		F_IO.Put(Calcular_Bruto(Salario), Exp => 0);
		T_IO.New_Line;
		T_IO.Put("El salario neto: ");
		F_IO.Put(Calcular_Neto(Salario), Exp => 0);
	end Escribir_Salario;

begin 
	T_IO.Put("Introduce horas trabajadas ");
	F_IO.Get(Salario.Horas);
	T_IO.Put("Introduce precio por hora ");
	F_IO.Get(Salario.Precio);
	Escribir_Salario(Salario);
end Salario;