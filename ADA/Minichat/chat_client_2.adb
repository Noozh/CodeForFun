with Ada.Text_IO;
With Ada.Command_Line;
with Ada.Strings.Unbounded;
with Lower_Layer_UDP;
with Chat_Messages;
with Handlers;

procedure Chat_Client_2 is
   package T_IO renames Ada.Text_IO;
   package ACL renames Ada.Command_Line;
   package ASU renames Ada.Strings.Unbounded;
   package LLU renames Lower_Layer_UDP;
   package CM renames Chat_Messages;
   use type CM.Message_Type;

   Bad_Params:exception;
   Bad_Port: exception;
   Server_Unreachable: exception;
   Denied_Join:exception;

   --Recoger parametros de la linea de comandos.
   procedure Get_Params(Nameserver:out ASU.Unbounded_String;
                        Port : out Integer;
                        Nickname: out ASU.Unbounded_String ) is
   begin
      if ACL.Argument_Count /= 3 then
         raise Bad_Params;
      else
         Nameserver := ASU.To_Unbounded_String(ACL.Argument(1));
         Port:=Integer'Value(ACL.Argument(2));
         Nickname:= ASU.To_Unbounded_String(ACL.Argument(3));
      end if;

      if Port <= 1024 or Port > 65535 then
         raise Bad_Port;
      end if;

   end Get_Params;

   procedure Join_Answer(Client_EP_Receive:in LLU.End_Point_Type;
                        Nickname:in ASU.Unbounded_String;
                        P_Buffer:access LLU.Buffer_Type) is
      Expired,Flag:Boolean;
      Message_Class:CM.Message_Type;
   begin
      LLU.Reset(P_Buffer.all);
      LLU.Receive(Client_EP_Receive, P_Buffer, 10.0, Expired);
      if Expired then
         raise Server_Unreachable;
      else
        Message_Class:=CM.Message_Type'Input(P_Buffer);
        Flag:=Boolean'Input(P_Buffer);
        if not Flag then
          raise Denied_Join;
        else
          T_IO.Put_Line("Mini-Chat v2.0: Welcome " & ASU.To_String(Nickname) );
        end if;
      end if;
   end Join_Answer;

   procedure Send_Writer_Message(Server_EP:in LLU.End_Point_Type;
                                 Client_EP_Handler:in LLU.End_Point_Type;
                                 Nickname:in ASU.Unbounded_String;
                                 P_Buffer:access LLU.Buffer_Type) is
     Phrase:ASU.Unbounded_String;
   begin
      Phrase:=ASU.To_Unbounded_String("");
      while ASU.To_String(Phrase) /= ".quit" loop
         T_IO.Put(">> ");
         Phrase:=ASU.To_Unbounded_String(T_IO.Get_Line);
         if ASU.To_String(Phrase) /= ".quit" then
            LLU.Reset(P_Buffer.all);
            CM.Message_Type'Output(P_Buffer,CM.Writer);
            LLU.End_Point_Type'Output(P_Buffer,Client_EP_Handler);
            ASU.Unbounded_String'Output(P_Buffer,Nickname);
            ASU.Unbounded_String'Output(P_Buffer,Phrase);
            LLU.Send(Server_EP,P_Buffer);
         end if;
      end loop;
   end Send_Writer_Message;

   procedure Send_Logout_Message (Server_EP:in LLU.End_Point_Type;
                                 Client_EP_Handler:in LLU.End_Point_Type;
                                 Nickname:in ASU.Unbounded_String;
                                 P_Buffer:access LLU.Buffer_Type) is
   begin
      LLU.Reset(P_Buffer.all);
      CM.Message_Type'Output(P_Buffer,CM.Logout);
      LLU.End_Point_Type'Output(P_Buffer,Client_EP_Handler);
      ASU.Unbounded_String'Output(P_Buffer,Nickname);
      LLU.Send(Server_EP,P_Buffer);
   end Send_Logout_Message;

   Nickname,Nameserver: ASU.Unbounded_String;
   Port: Integer;
   Server_EP,Client_EP_Receive,Client_EP_Handler: LLU.End_Point_Type;
   Buffer: aliased LLU.Buffer_Type(1024);
begin
   Get_Params(Nameserver,Port,Nickname);
   Server_EP:= LLU.Build(LLU.To_IP(ASU.To_String(Nameserver)), Port);
   LLU.Bind_Any(Client_EP_Receive);
   LLU.Bind_Any(Client_EP_Handler,Handlers.Recieve_Server_Message'Access);
   CM.Message_Type'Output(Buffer'Access,CM.Init);
   LLU.End_Point_Type'Output(Buffer'Access,Client_EP_Receive);
   LLU.End_Point_Type'Output(Buffer'Access,Client_EP_Handler);
   ASU.Unbounded_String'Output(Buffer'Access,Nickname);
   LLU.Send(Server_EP, Buffer'Access);
   Join_Answer(Client_EP_Receive,Nickname,Buffer'Access);
   Send_Writer_Message(Server_EP,Client_EP_Handler,Nickname,Buffer'access);
   Send_Logout_Message(Server_EP,Client_EP_Handler,Nickname,Buffer'access);
   LLU.Finalize;
exception
   when Bad_Port =>
      T_IO.Put_Line("Port is reserved");
      LLU.Finalize;
   when Bad_Params =>
      T_IO.Put_Line("Insert just three params");
      LLU.Finalize;
   when Server_Unreachable =>
      T_IO.Put_Line("Server Unreachable");
      LLU.Finalize;
   when Denied_Join =>
      T_IO.Put_Line("Mini-Chat v2.0: IGNORED new user " & ASU.To_String(Nickname) & ", nick already used");
      LLU.Finalize;
   when others =>
      T_IO.Put_Line("Unexpected exception");
      LLU.Finalize;
end Chat_Client_2;
