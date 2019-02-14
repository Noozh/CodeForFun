with Ada.Text_IO;
With Ada.Command_Line;
with Ada.Strings.Unbounded;
with Lower_Layer_UDP;
with Handlers;
with Chat_Messages;
with Ada.Calendar;
with Clients;

procedure Chat_Server_2 is
   package T_IO renames Ada.Text_IO;
   package ACL renames Ada.Command_Line;
   package ASU renames Ada.Strings.Unbounded;
   use type ASU.Unbounded_String;
   package LLU renames Lower_Layer_UDP;
   package CM renames Chat_Messages;
   package AC renames Ada.Calendar;
   use type CM.Message_Type;

   Bad_Params:exception;
   Bad_Port: exception;
   Bad_Limit: exception;

   --Recoge los parametros que se le pasan al programa por consola
    procedure Get_Params(Port :out Natural;Max_Clients:out Natural) is
    begin
      if ACL.Argument_Count /= 2 then
        raise Bad_Params;
      else
        Port:=Natural'Value(ACL.Argument(1));
        Max_Clients:=Natural'Value(ACL.Argument(2));
      end if;
      if Port <= 1024 or  Port > 65535 then
        raise Bad_Port;
      end if;
      if Max_Clients < 2 or  Max_Clients > 50 then
        raise Bad_Limit;
      end if;
    end Get_Params;

    procedure Get_Command (C:in out Character) is
    begin
      T_IO.Get_Immediate(C);
      case C is
        when 'l'|'L' =>
          --T_IO.Put_Line(Character'Image(C));
          Handlers.Show_Active_Clients;
        when 'o'|'O' =>
          --T_IO.Put_Line(Character'Image(C));
          Handlers.Show_Inactive_Clients;
        --when 'c'|'C' =>
        --  --Limpiar terminal
        --  T_IO.Put(ASCII.ESC & "[2J");
        when others =>
          T_IO.New_Line;
      end case;
    end Get_Command;

   Port,Max_Clients:Natural;
   C:Character:=' ';
   Server_EP:LLU.End_Point_Type;

begin
   Get_Params(Port,Max_Clients);
   Server_EP:= LLU.Build(LLU.To_IP(LLU.Get_Host_Name), Port);
   LLU.Bind(Server_EP,Handlers.Recieve_Client_Message'Access);
   loop
     Get_Command(C);
   end loop;
   LLU.Finalize;
exception
  when Bad_Port =>
    T_IO.Put_Line("Reserved port");
    LLU.Finalize;
  when Bad_Params =>
    T_IO.Put_Line("Insert correct param format");
    LLU.Finalize;
  when Bad_Limit =>
    T_IO.Put_Line("Insert a list size between 2 and 50");
    LLU.Finalize;
  when others =>
    T_IO.Put_Line("Unexpected exception");
    LLU.Finalize;
end Chat_Server_2;
