with Lower_Layer_UDP;
with Ada.Calendar;

package Handlers is
  package LLU renames Lower_Layer_UDP;
  procedure Recieve_Server_Message (From:in LLU.End_Point_Type;
                                    To:in LLU.End_Point_Type;
                                    P_Buffer: access LLU.Buffer_Type);

  procedure Recieve_Client_Message (From:in LLU.End_Point_Type;
                                    To:in LLU.End_Point_Type;
                                    P_Buffer: access LLU.Buffer_Type);

  function Time_Image (T: Ada.Calendar.Time) return String;

  procedure Show_Active_Clients;

  procedure Show_Inactive_Clients;
end Handlers;
