with gnat.os_lib;
with Ada.Command_Line;
with Ada.Text_IO;
package body Read_Arg is
  function Manage_Exception (i: positive) return Integer is
  begin
     return Integer'Value(Ada.Command_Line.Argument (i));
  exception
    when CONSTRAINT_ERROR =>
      Ada.Text_IO.Put_Line ("Insert correct param format");
      Gnat.OS_Lib.OS_exit(0);
  end Manage_Exception;
end Read_Arg;
