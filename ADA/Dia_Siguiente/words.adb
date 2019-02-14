with Ada.Text_IO;
with Ada.Command_Line;
with Ada.Exceptions;
with Ada.Strings.Unbounded;

procedure Words is
	
	package T_IO renames Ada.Text_IO;
	package ACL renames Ada.Command_Line;
	package AE renames Ada.Exceptions;
	package ASU renames Ada.Strings.Unbounded;

	Parameter_error:exception;
	
begin 
	if ACL.Argument(1)/="i" then
		raise Parameter_error;
	end if;
	T_IO.Put_Line(" ");
end ;