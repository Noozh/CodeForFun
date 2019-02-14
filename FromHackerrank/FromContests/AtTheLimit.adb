--At the Limit
with Ada.Text_IO;
with Ada.Strings.Unbounded;

procedure Limit is

    package T_IO renames Ada.Text_IO;
    package ASU renames Ada.Strings.Unbounded;

    procedure WriteText(C: in out ASU.Unbounded_String) is

        function SigienteEsBlanco(C: in out ASU.Unbounded_String) return Boolean is
        begin

            return ASU.To_String(ASU.Head(C, 1)) = " ";

        end SigienteEsBlanco;

        PosBlanco: Natural := 2;
        Finish: Boolean := False;
        Word: ASU.Unbounded_String;
    begin
        while(not Finish)loop
            PosBlanco := ASU.Index(C, " "); --obtengo laposicion del blanco
            if(PosBlanco >= 1)then
                Word := ASU.Head(C, PosBlanco - 1);
                C := ASU.Tail(C, ASU.Length(C) - PosBlanco);
                if(SigienteEsBlanco(C))then
                    PosBlanco := ASU.Index(C, " ");
                    C := ASU.Tail(C, ASU.Length(C) - PosBlanco);
                end if;

                T_IO.Put(ASU.To_String(Word) & " ");
            else
                Finish := True;
            end if;
        end loop;

        T_IO.Put_Line(ASU.To_String(C));

    end WriteText;

    Cadena: ASU.Unbounded_String;
begin

    Cadena := ASU.To_Unbounded_String(T_IO.Get_Line);
    WriteText(Cadena);

end Limit;

