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
    valor:char;
    nomf:string;
    f:file of node;
    aux:node;

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
     writeln('5. Borrar del principi');
     writeln('6. Borrar del mig');
     writeln('7. Grabar en un fitxer');
     writeln('8. Recuperar d''un fitxer');



     writeln;
     write('>>');
     readln(opcio);

   Until ((opcio>=0) and (opcio<=8));
     case (opcio) of
            {----   V I S U A L I T Z A R   L A   L L I S T A   ----}

          1:BEGIN
            p:=ini;
            while (p <> nil) do begin
             write(p^.inf,', ');
             p:=p^.seg;
            End;
            readln;
            END;

            {----   A F E G I R   U N   E L E M E N T   A L   F I N A L ----}
          2:BEGIN
             IF (ini=nil) then begin (*No hi cap element a la llista*)
                new(p);
                write('Primer enter de la llista?: ');
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

          3:BEGIN {Afegir al principi}

            new(p);
            write('Nou nง a afegir?: ');
            readln(p^.inf);
            p^.seg:=ini;
            if ini=nil then fi:=p;
            ini:=p;


            END;
          4:BEGIN
                 {  Afegir al mig   }
            If (ini <> nil) and (ini^.seg <> nil) then begin
               p:=ini;
               valor:='n';
               while (p <> fi) and (valor='n') do begin
                 clrscr;
                 writeln(p^.inf);
                 write('Afegir a cont.? (s/n): ');
                 readln(valor);
                 If (valor='n') then p:=p^.seg
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
          End
          Else begin
               writeln('No hi ha dos elements');
               readln;
          End;

           end;


          
          0:begin
            End;

          5:begin {Eliminar el del principi}
            If (ini <> nil) then begin
               p:=ini;
               ini:=p^.seg;
               dispose(p);
               writeln('Borrat!');
            End
            Else begin
               writeln('No hi ha elements');
            End;

            readln;


            end;

          6:begin       {       BORRAR DEL MIG          }
              if (ini <> fi) then begin
                 q:=ini;
                 p:=ini^.seg;
                 r:=p^.seg;
                 valor:='n';
              while (p<>fi) and (valor='n') do begin
                       repeat
                         write('Borrar ',p^.inf,' ? (s/n): ');
                         readln(valor);
                       Until ((valor='n') or (valor='s'));
                       if (valor='n') then begin
                           q:=p;
                           p:=p^.seg;
                           r:=p^.seg;
                       End
                       Else begin
                           q^.seg:=r;
                           dispose(p);

                       End;


                 End; {while}
              End;

            End;

            7: BEgin { GUARDAR EN UN FITXER     }
               write('Nom del fitxer: ');
               readln(nomf);
               assign(f,nomf);
               rewrite(f);
               p:=ini;
               while p <> nil do begin
                 aux.inf:=p^.inf;
                 write(f,aux);
               p:=p^.seg;
               End;

               End;
            8: BEGIN {  RECUPERAR D'UN FITXER   }
                  ini:=nil;
                  fi:=nil;
                  write('Nom del fitxer: ');
                  readln(nomf);
                  assign(f,nomf);
                  {$I-}
                  reset(f);
                  close(f);
                  {$I+}
                  if IOresult=0 then begin
                     reset(f);
                     new(p);
                     ini:=p;
                     fi:=p;
                     p^.seg:=nil;
                     read(f,aux);
                     p^.inf:=aux.inf;

                     while not eof (f) do begin
                       new(p);
                       read(f,aux);
                       p^.inf:=aux.inf;
                       fi^.seg:=p;
                       fi:=p;
                       p^.seg:=nil;
                     End;
                  End;
               END;




     End; {case}
     Until (opcio=0);

END.


