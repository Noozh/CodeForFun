with Ada.Text_IO;
with Ada.Strings.Unbounded;
with Chat_Messages;
with Clients;
with Message_Control;
with Ada.Command_Line;
with Gnat.Calendar.Time_IO;
with Ada.Calendar;

package body Handlers is
   package T_IO renames Ada.Text_IO;
   package ASU renames Ada.Strings.Unbounded;
   package CM renames Chat_Messages;
   package ACL renames Ada.Command_Line;

   Active_List:Clients.A_C.Map;
   Inactive_List:Clients.I_C.Map;

  procedure Recieve_Server_Message (From:in LLU.End_Point_Type;
                                  To:in LLU.End_Point_Type;
                                  P_Buffer: access LLU.Buffer_Type) is
    Message:CM.Message_Type;
    Nickname,Phrase:ASU.Unbounded_String;
  begin
    Message:=CM.Message_Type'Input(P_Buffer);
    Nickname:=ASU.Unbounded_String'Input(P_Buffer);
    Phrase:=ASU.Unbounded_String'Input(P_Buffer);
    LLU.Reset (P_Buffer.all);
    T_IO.New_Line;
    T_IO.Put_Line(ASU.To_String(Nickname) & ": " & ASU.To_String(Phrase));
    T_IO.Put(">> ");
  end Recieve_Server_Message;

  procedure Recieve_Client_Message (From:in LLU.End_Point_Type;
                                  To:in LLU.End_Point_Type;
                                  P_Buffer: access LLU.Buffer_Type) is
    Message:CM.Package_Type;
  begin
    Message.Message_Class:=CM.Message_Type'Input(P_Buffer);
      case Message.Message_Class is
        when CM.Init =>
          Message.Client_EP_Receive:=LLU.End_Point_Type'Input(P_Buffer);
          Message.Client_EP_Handler:=LLU.End_Point_Type'Input(P_Buffer);
          Message.Nickname:=ASU.Unbounded_String'Input(P_Buffer);
          Message_Control.Manage_Init(Message,Active_List,Inactive_List,P_Buffer);
        when CM.Writer =>
          Message.Client_EP_Handler:=LLU.End_Point_Type'Input(P_Buffer);
          Message.Nickname:=ASU.Unbounded_String'Input(P_Buffer);
          Message.Phrase:=ASU.Unbounded_String'Input(P_Buffer);
          Message_Control.Manage_Writer(Message,Active_List,P_Buffer);
        when CM.Logout =>
          Message.Client_EP_Handler:=LLU.End_Point_Type'Input(P_Buffer);
          Message.Nickname:=ASU.Unbounded_String'Input(P_Buffer);
          Message_Control.Manage_Logout(Message,Active_List,Inactive_List,P_Buffer);
        when others =>
          T_IO.Put_Line("Unexpected message");
      end case;
  end Recieve_Client_Message;

  function Time_Image (T: Ada.Calendar.Time) return String is
  begin
    return Gnat.Calendar.Time_IO.Image(T, "%d-%b-%y %T.%i");
  end Time_Image;

  procedure Show_Active_Clients is
    -----Imprimir un solo cliente //Formato lista activa------
    procedure Print_Client (ID:in Clients.Client_Type) is
      function Resize_EP(Client_EP_Handler:LLU.End_Point_Type) return String is
        EP:ASU.Unbounded_String;
        Port:ASU.Unbounded_String;
        IP:ASU.Unbounded_String;
      begin
        EP:=ASU.To_Unbounded_String(LLU.Image(Client_EP_Handler));
        Port:= ASU.Tail(EP,ASU.Length(EP)-ASU.Index(EP,":")-1);
        Port:= ASU.Tail(Port,ASU.Length(Port)-ASU.Index(Port,":")-1);
        IP:= ASU.Tail(EP,ASU.Length(EP)-ASU.Index(EP,":")-1);
        IP:= ASU.Head(IP,ASU.Index(IP,",")-1);
        return "(" & ASU.To_String(IP) & ":" & ASU.To_String(Port) & ")";
      end Resize_EP;
    begin
      T_IO.Put_Line(ASU.To_String(ID.Nickname) & " "  & Resize_EP(ID.Client_EP_Handler) & " : " & Time_Image(ID.Last_Online));
    end Print_Client;
    Cursor:Clients.A_C.Cursor := Clients.A_C.First(Handlers.Active_List); --Los limited private solo pueden inicializarse en su declaración.
    Element:Clients.A_C.Element_Type;
  begin
    T_IO.Put_Line("ACTIVE CLIENTS");
    T_IO.Put_Line("==============");
    while Clients.A_C.Has_Element(Cursor) loop
      Element:=Clients.A_C.Element(Cursor);
      Print_Client(Element.Value);
      Clients.A_C.Next(Cursor);
    end loop;
  end Show_Active_Clients;

  procedure Show_Inactive_Clients is
    -----Imprimir un solo cliente //Formato lista inactiva------
    procedure Print_Client (Nickname:in ASU.Unbounded_String;Last_Online:in Ada.Calendar.Time) is
    begin
      T_IO.Put_Line(ASU.To_String(Nickname) & " "  & " : " & Time_Image(Last_Online));
    end Print_Client;
    Cursor:Clients.I_C.Cursor := Clients.I_C.First(Handlers.Inactive_List); --Los limited private solo pueden inicializarse en su declaración.
    Element:Clients.I_C.Element_Type;
  begin
    T_IO.Put_Line("OLD CLIENTS");
    T_IO.Put_Line("==============");
    --T_IO.Put_Line(Boolean'Image(Clients.I_C.Has_Element(Cursor)));
    while Clients.I_C.Has_Element(Cursor) loop
      Element:=Clients.I_C.Element(Cursor);
      Print_Client(Element.Key,Element.Value);
      Clients.I_C.Next(Cursor);
    end loop;
  end Show_Inactive_Clients;

end Handlers;
