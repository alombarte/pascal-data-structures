PROGRAM LLISTES_SIMPLES;
USES crt;

TYPE
    apuntador=^node;
    node=record
      inf:integer;
      seg:apuntador;
    end;

VAR
    opcio,pos:word;
    p,r,q:apuntador;
    ini,fi:apuntador; (* Marquen la posiciข del primer i ฃltim element *)
    SiNo:char;

{       ^ini                            ^fi
    ษออออออออออหอออออออป            ษออออออออออหอออออออป
    บ    INF   บ  SEG  บ -> ... ->  บ    INF   บ  SEG  บ --> NIL
    ศออออออออออสอออออออผ            ศออออออออออสอออออออผ
}

BEGIN

     ini:=nil;  {Inicialitzar la llista}
     fi:=nil;

   repeat
   repeat
     clrscr;
     writeln('MENU');
     writeln;
     writeln('0. Sortir');
     writeln('1. Visualitzar');
     writeln('2. Afegir al final');
     writeln('3. Afegir al principi');
     writeln('4. Afegir al mig');
     writeln;
     write('>>');
     readln(opcio);

   Until ((opcio>=0) and (opcio<=4));
     case (opcio) of
            {----   V I S U A L I T Z A R   L A   L L I S T A   ----}

          1:BEGIN
            p:=ini;
            while (p <> nil) do begin
             writeln(p^.inf);
             p:=p^.seg;
            End;
            readln;
            END;

            {----   A F E G I R   U N   E L E M E N T   A L   F I N A L ----}
          2:BEGIN
             IF (ini=nil) then begin (*No hi cap element a la llista*)
                new(p);
                write('Primer enter?: ');
                readln(p^.inf);
                ini:=p;
                fi:=p;
                p^.seg:=nil;
             END
             ELSE BEGIN

             (*  Hi ha com a mกnim un element *)
              new(p);
              write('Enter?: ');
              readln(p^.inf);
              fi^.seg:=p;
              p^.seg:=nil;
              fi:=p;

             END {else}

            END; {case 2}

          3:BEGIN

            new(p);
            write('Nou nง a afegir?: ');
            readln(p^.inf);
            p^.seg:=ini;
            if ini=nil then fi:=p;
            ini:=p;


            END;
          4:BEGIN
                 {  Afegir al mig   }
               p:=ini;
               SiNo:='N';
               while (p <> fi) and (SiNo='N') do begin
                 clrscr;
                 writeln(p^.inf);
                 write('Afegir a cont.? (S/N): ');
                 readln(SiNo);
                 If (SiNo='N') then p:=p^.seg
                 else begin
                    r:=p^.seg;
                    new(q);
                    write('Nombre?: ');
                    readln(q^.inf);
                    p^.seg:=q;
                    q^.seg:=r;
                 end;
               end;
               if (p=fi) then begin
                writeln ('Fi llista');
                readln;
               End;
           end;


          
          0:begin
            End;

     End; {case}
     Until (opcio=0);

END.


