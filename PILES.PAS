PROGRAM Piles;
USES crt;

TYPE apuntador=^node;
     node=record
        inf:integer;
        seg:apuntador;
     End;
VAR
   p,q,top:apuntador;
   aux:node;
   option:word;
   sn:char;
   arxiu:string;
   f:file of node;

BEGIN
     top:=nil;

repeat
clrscr;
TEXTCOLOR(LightGreen);
writeln('AIX„ êS UNA PILA SIMPLE');
WRITELN;
TEXTCOLOR(WHITE);

writeln('1. Afegir');
writeln('2. Eliminar');
writeln('3. Visualitzar');
writeln('4. Recuperar fitxer');
writeln('5. Grabar en fitxer');
writeln('0. Sortir');
writeln;
write('Opci¢: ');
readln(option);

case (option) of
     1:BEGIN  {Afegir}
          new(p);
          write('NFO (Entre 0-100): ');
          readln(p^.inf);
          p^.seg:=top;
          top:=p;
       END;

     2:BEGIN    {Eliminar}
       If top<>nil then begin
       p:=top;
       write('S''eliminar† l''element ',top^.inf, ' (s/n)?: ');
       readln(sn);
       If (sn='s') or (sn='S') then begin
          p:=top^.seg;
          dispose(top);
          top:=p;
       End;
       End;
       END;

     3:BEGIN {Visualitzar}
        If (top <> nil) then begin
          p:=top;
          clrscr;
          textcolor(yellow);
          writeln('ESTAT DE LA PILA:');
          textcolor(white);
          writeln;
          writeln;
          writeln('top:');


          while p<>nil do begin
            WRITELN('   ∫    ∫');
            write  ('   ÃÕÕÕÕπ');
            gotoxy(6,wherey-1);
            textcolor(Lightgreen);
            write(p^.inf);
            gotoxy(1,wherey+2);
            textcolor(white);
            
            p:=p^.seg;
          End;
          gotoxy(4,wherey-1);
          writeln('»ÕÕÕÕº');
          readln;
        End;
       END;

     4:BEGIN
       clrscr;
       write('Arxiu que desitja recuperar: ');
       readln(arxiu);
       assign(f,arxiu);
       {$I-}
       reset(f);
       close(f);
       {$I+}
       reset(f);
       If IOresult <> 0 then writeln('No existeix l''arxiu especificat')
       Else begin
          If filesize(f)=0 then top:=nil
          Else begin
              reset(f);
              new(p);
              read(f,aux);
              p^.inf:=aux.inf;
              p:=top;
              while not eof (f) do begin

                  new(p);
                  read(f,aux);
                  p^.seg:=top;
                  p:=p^.seg;

              End;
          End;
       End;

      close(f);


       readln;
       END;
     5:BEGIN { ... guarda malamament ... }
       write('Nom de l''arxiu a guardar?: ');
       readln(arxiu);
       assign(f,arxiu);
       rewrite(f);
       p:=top;
       while p <> nil do begin
             aux.inf:=p^.inf;
             write(f,aux);
             p:=p^.seg;
       End;
       close(f);
       readln;
       END;
     0:BEGIN
       clrscr;
       writeln(' ERROR 2000120:ùbFF By ÜRt, El despiporre');
       readln;
       END;



End; {case}

Until (option=0);
END.