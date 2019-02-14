
package body Message_Control is
   procedure Send_To_All (Map:in Clients.A_C.Map;Message:in CM.Package_Type;Client_EP_Handler:in LLU.End_Point_Type;P_Buffer:access LLU.Buffer_Type) is
     --Reenvia el mensaje a todos los clientes de la lista
     Cursor:Clients.A_C.Cursor := Clients.A_C.First(Map);
     ID:Clients.Client_Type;
     Element:Clients.A_C.Element_Type;
   begin
     while Clients.A_C.Has_Element(Cursor) loop
       Element:=Clients.A_C.Element(Cursor);
       LLU.Reset(P_Buffer.all);
       CM.Message_Type'Output(P_Buffer,Message.Message_Class);
       ASU.Unbounded_String'Output(P_Buffer,Message.Nickname);
       ASU.Unbounded_String'Output(P_Buffer,Message.Phrase);
       if LLU.Image(Element.Value.Client_EP_Handler) /= LLU.Image(Client_EP_Handler) then --Si no es el cliente que habla envia reenvia el mensaje
          ID:=Element.Value;
          LLU.Send(ID.Client_EP_Handler,P_Buffer);
       end if;
       Clients.A_C.Next(Cursor);
     end loop;
  end Send_To_All;

  procedure Compose_Server_Message(Message:out CM.Package_Type;
                                    Nickname:in ASU.Unbounded_String;
                                    Tail:in ASU.Unbounded_String) is
  begin
   Message.Message_Class:= CM.Server;
   Message.Nickname:= (ASU.To_Unbounded_String("server "));
   Message.Phrase:=ASU.To_Unbounded_String(ASU.To_String(Nickname)& ASU.To_String(Tail));
  end Compose_Server_Message;

  procedure Manage_Init (Message:in out CM.Package_Type;Active_List:in out Clients.A_C.Map;Inactive_List:in out Clients.I_C.Map;P_Buffer:access LLU.Buffer_Type) is
    procedure Make_Client(Message:in CM.Package_Type;ID:out Clients.Client_Type) is
    begin
      ID.Client_EP_Handler:= Message.Client_EP_Handler;
      ID.Nickname:= Message.Nickname;
      ID.Last_Online:= AC.Clock;
    end Make_Client;
    procedure Older_Client(Active_List:in Clients.A_C.Map;ID:out Clients.Client_Type) is
      Cursor:Clients.A_C.Cursor := Clients.A_C.First(Active_List);
      Element:Clients.A_C.Element_Type;
    begin
      ID:=Clients.A_C.Element(Cursor).Value;
      while Clients.A_C.Has_Element(Cursor) loop
        Element:=Clients.A_C.Element(Cursor);
        if ID.Last_Online > Element.Value.Last_Online then
           ID:=Element.Value;
        end if;
        Clients.A_C.Next(Cursor);
      end loop;
    end Older_Client;
    ID, AFK_ID:Clients.Client_Type;
    Success,Flag:Boolean;
  begin
    Clients.A_C.Get(Active_List,Message.Nickname,ID,Success);
    if not Success and then ASU.To_String(Message.Nickname) /= "server" then --Si el cliente no esta en la lista
      T_IO.Put_Line("INIT received from " & ASU.To_String(Message.Nickname) & ": ACCEPTED");
      Make_Client(Message,ID);
      begin
        Clients.A_C.Put(Active_List,ID.Nickname,ID);
      exception
         when CLIENTS.A_C.FULL_MAP =>
         Older_Client(Active_List,AFK_ID);
         LLU.Reset(P_Buffer.all);
         Compose_Server_Message(Message,AFK_ID.Nickname,ASU.To_Unbounded_String(" banned for being idle too long"));
         Send_To_All(Active_List,Message,ID.Client_EP_Handler,P_Buffer);
         Clients.A_C.Delete(Active_List,AFK_ID.Nickname,Flag);
         begin
           Clients.I_C.Put(Inactive_List,AFK_ID.Nickname,AFK_ID.Last_Online);
         exception
            when CLIENTS.I_C.FULL_MAP =>
               T_IO.Put_Line("Inactive_List is full");
         end;
         Clients.A_C.Put(Active_List,ID.Nickname,ID);
      end;
      LLU.Reset(P_Buffer.all);
      Compose_Server_Message(Message,ID.Nickname,ASU.To_Unbounded_String(" joins the chat"));
      CM.Package_Type'Output(P_Buffer,Message);
      Send_To_All(Active_List,Message,ID.Client_EP_Handler,P_Buffer);
    else --Si esta en la lista o es server
      T_IO.Put_Line("INIT received from " & ASU.To_String(Message.Nickname) & ": IGNORED. nick already used");
    end if;
    Flag:= not Success and then ASU.To_String(Message.Nickname) /= "server";
    LLU.Reset(P_Buffer.all);
    CM.Message_Type'Output(P_Buffer,CM.Welcome);
    Boolean'Output(P_Buffer,Flag);
    LLU.Send(Message.Client_EP_Receive,P_Buffer);
  end Manage_Init;

  procedure Manage_Writer(Message:in out CM.Package_Type;Active_List:in out Clients.A_C.Map;P_Buffer: access LLU.Buffer_Type) is
    ID:Clients.Client_Type;
  begin
    Clients.A_C.Get(Active_List,Message.Nickname,ID,Message.Flag);
    if Message.Flag and then LLU.Image(Message.Client_EP_Handler) = LLU.Image(ID.Client_EP_Handler) then
      T_IO.Put_Line("WRITER received from " & ASU.To_String(Message.Nickname) & ": " & ASU.To_String(Message.Phrase));
      ID.Last_Online:= AC.Clock;
      Clients.A_C.Put(Active_List,ID.Nickname,ID);
      LLU.Reset(P_Buffer.all);
      Message.Message_Class:= CM.Server;
      Send_To_All(Active_List,Message,ID.Client_EP_Handler,P_Buffer);
    else
       T_IO.Put_Line("WRITER received from unknown client. IGNORED ");
    end if;
  end Manage_Writer;

   procedure Manage_Logout(Message:in out CM.Package_Type;Active_List: in out Clients.A_C.Map;Inactive_List:in out Clients.I_C.Map;P_Buffer: access LLU.Buffer_Type) is
     ID:Clients.Client_Type;
   begin
     Clients.A_C.Get(Active_List,Message.Nickname,ID,Message.Flag);
    if Message.Flag and then LLU.Image(Message.Client_EP_Handler) = LLU.Image(ID.Client_EP_Handler) then
      T_IO.Put_Line("LOGOUT received from " & ASU.To_String(ID.Nickname));
      Clients.A_C.Delete(Active_List,ID.Nickname,Message.Flag);
      begin
        Clients.I_C.Put(Inactive_List,ID.Nickname,ID.Last_Online);
      exception
         when CLIENTS.I_C.FULL_MAP =>
            T_IO.Put_Line("Inactive_List is full");
      end;
      LLU.Reset(P_Buffer.all);
      Message.Message_Class:= CM.Server;
      Message.Nickname:= (ASU.To_Unbounded_String("server "));
      Message.Phrase:=(ASU.To_Unbounded_String(ASU.To_String(ID.Nickname) & " leaves the chat"));
      CM.Package_Type'Output(P_Buffer,Message);
      Send_To_All(Active_List,Message,ID.Client_EP_Handler,P_Buffer);
    else
      T_IO.Put_Line("LOGOUT received from " & ASU.To_String(Message.Nickname) & ".IGNORED");
    end if;
   end Manage_Logout;

end Message_Control;
