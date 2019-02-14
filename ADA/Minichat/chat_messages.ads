with Lower_Layer_UDP;
with Ada.Strings.Unbounded;

package Chat_Messages is
   package LLU renames Lower_Layer_UDP;
   package ASU renames ADA.Strings.Unbounded;
   type Message_Type is (Init, Welcome, Writer, Server, Logout);
   type Package_Type is record
      Message_Class:Message_Type;
      Client_EP_Receive:LLU.End_Point_Type;
      Client_EP_Handler:LLU.End_Point_Type;
      Nickname:ASU.Unbounded_String;
      Phrase:ASU.Unbounded_String;
      Flag:Boolean;
   end record;
end Chat_Messages;
