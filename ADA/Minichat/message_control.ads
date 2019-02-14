with Ada.Text_IO;
with Ada.Strings.Unbounded;
with Chat_Messages;
with Lower_Layer_UDP;
with Clients;
with Ada.Calendar;

package Message_Control is

  package T_IO renames Ada.Text_IO;
  package ASU renames Ada.Strings.Unbounded;
  package CM renames Chat_Messages;
  package LLU renames Lower_Layer_UDP;
  package AC renames Ada.Calendar;
  use type AC.Time;

  procedure Send_To_All (Map:in Clients.A_C.Map;Message:in CM.Package_Type;Client_EP_Handler:in LLU.End_Point_Type;P_Buffer:access LLU.Buffer_Type);

  procedure Manage_Init (Message:in out CM.Package_Type;Active_List:in out Clients.A_C.Map;Inactive_List:in out Clients.I_C.Map;P_Buffer:access LLU.Buffer_Type);

  procedure Manage_Writer(Message:in out CM.Package_Type;Active_List:in out Clients.A_C.Map;P_Buffer: access LLU.Buffer_Type);

  procedure Manage_Logout(Message:in out CM.Package_Type;Active_List: in out Clients.A_C.Map;Inactive_List:in out Clients.I_C.Map;P_Buffer: access LLU.Buffer_Type);


end Message_Control;
