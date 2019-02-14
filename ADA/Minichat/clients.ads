with Lower_Layer_UDP;
with Ada.Text_IO;
with Ada.Strings.Unbounded;
with Ada.Calendar;
with Hash_Maps_G;
with Hash_Operators;
with Ordered_Maps_G;
with Ada.Command_Line;
with Read_Arg;

package Clients is
   package LLU renames Lower_Layer_UDP;
   package ASU renames Ada.Strings.Unbounded;
   package AC renames Ada.Calendar;
   package ACL renames Ada.Command_Line;

   type Client_Type is record
      Client_EP_Handler:LLU.End_Point_Type;
      Nickname:ASU.Unbounded_String;
      Last_Online: AC.Time;
   end record;

   HASH_SIZE:   constant := 5;
   type Hash_Range is mod HASH_SIZE;

   package H_Op is new Hash_Operators (Hash_Range);
   package A_C is new Hash_Maps_G(ASU.Unbounded_String, Client_Type,ASU."=", Hash_Range ,H_Op.Hash,HASH_SIZE,Read_Arg.Manage_Exception(2));
   package I_C is new Ordered_Maps_G(ASU.Unbounded_String,AC.Time,ASU."=",ASU."<" ,150);

end Clients;
