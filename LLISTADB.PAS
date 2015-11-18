PROGRAM Llista_doble;
USES crt;


TYPE apuntador=^node;
     node=record
       inf:integer;
       seg:apuntador;
       ant:apuntador;
     End;

VAR
   ini,fi,p,q,r:apuntador;
   opcio:word;
   aux:node;
   f:File of NODE;
   nom:string;
   sn:CHAR; {resposta si/no}

BEGIN

ini:=nil;
fi:=nil;


repeat

  clrscr;
  writeln('     '''''''''''''''' Men£ ''''''''''''''');
  writeln('     1. Afegir (final)');
  writeln('     2. Afegir (mig)');
  writeln('     3. Afegir (principi)');
  writeln('     4. Eliminar (principi)');
  writeln('     5. Eliminar (mig)');
  writeln('     6. Eliminar (final)');
  writeln('     7. Visualitzar');
  writeln('     8. Recuperar fitxer');
  writeln('     9. Grabar en fitxer');
  writeln;
  writeln('     0. Sortir');
  writeln;
  write('Opci¢: ');
  readln(opcio);
  case (opcio) of

       1: BEGIN                 { AFEGIR AL FINAL }

          If (ini=nil) then begin
             new(p);
             write('INFO:');
             readln(p^.inf);
             ini:=p;
             fi:=p;
             p^.seg:=nil;
             p^.ant:=nil;
          End
          Else begin
             new(p);
             write('INFO:');
             readln(p^.inf);
             fi^.seg:=p;
             p^.ant:=fi;
             p^.seg:=nil;
             fi:=p;
          End;
          END;

       2: BEGIN {Afegir al mig}
          if (ini <> fi) then begin
             p:=ini;
             sn:='n';
             while (p<>nil) and (sn='n') do begin
                   write('Afegir a continuaci¢ de ',p^.inf,' ? (s/n): ');
                   readln(sn);
                   If (sn='s') then begin
                     new(q);
                     write('INFO: ');
                     readln(q^.inf);
                     r:=p^.seg;
                     p^.seg:=q;
                     q^.ant:=p;
                     q^.seg:=r;
                     r^.ant:=q;
                   End;
                   p:=p^.seg;
             End;
          End; {if}
          END;
       3: BEGIN {AFEGIR AL PRINCIPI}
          If (ini<>nil) then begin
             new(p);
             write('INFO: ');
             readln(p^.inf);
             p^.seg:=ini;
             ini^.ant:=p;
             p^.ant:=nil;
             ini:=p;

          End
          Else begin
             new(p);
             write('INFO: ');
             readln(p^.inf);
             p^.ant:=nil;
             p^.seg:=nil;
             ini:=p;
             fi:=p;
          End;
          



          END;

       4: BEGIN {Eliminar del principi}
          IF (ini <> nil) then begin
            p:=ini;
            ini:=ini^.seg;
            ini^.ant:=nil;
            dispose(p);
            write('Borrat...');
            readln;
          End;

          END;
       5: BEGIN                     {       ELIMINAR DEL MIG        }
          If (ini^.seg<>fi) and (ini <> fi) then begin
             p:=ini^.seg;
             sn:='n';
             while (p<>fi) and (sn='n') do begin
                   write('Eliminar ',p^.inf,' ? (s/n): ');
                   readln(sn);
                   If (sn='n') then p:=p^.seg
                   Else begin
                   q:=p^.ant;
                   r:=p^.seg;
                   r^.ant:=q;
                   q^.seg:=r;
                   dispose(p);
                   write('Borrat...');
                   End;
             End;
          End;
          END;

       6: BEGIN                         { ELIMINAR DEL FINAL }
          If (ini=nil) then writeln('No hi ha elements')
          Else begin
               If ini=fi then begin {Un element}
                 p:=fi;
                 ini:=nil;
                 fi:=ini;
                 dispose(p);
               End
               Else begin {+ d'un }
                  p:=fi;
                  q:=fi^.ant;
                  q^.seg:=nil;
                  fi:=q;
                  dispose(p);
               End;
               writeln('BoRRaT!');

          End;

          readln;
          END;

       7: BEGIN {Visualitzar}
          p:=ini;
          while p <> nil do begin
                write(p^.inf,', ');
                p:=p^.seg;
          End;
          readln;
          END;

       8: BEGIN { RECUPERAR UN ARXIU }

          write('Nom del arxiu: ');
          readln(nom);
          assign(f,nom);
          {$I-}
          reset(f);
          close(f);
          {$I+}
          If  Ioresult <> 0 then writeln('L''arxiu no existeix')
          Else begin
               reset(f);
               if Filesize(f)=0 then begin
                  ini:=nil;
                  fi:=nil;
               End
               Else Begin
                  new(p);
                  read(f,aux);
                  p^.inf:=aux.inf;
                  p^.seg:=nil;
                  p^.ant:=nil;
                  ini:=p;
                  fi:=p;
                  while not eof (f) do begin
                        new(p);
                        read(f,aux);
                        p^.inf:=aux.inf;
                        p^.seg:=nil;
                        p^.ant:=fi;
                        fi^.seg:=p;
                        fi:=p;
                  End;
               End;
               writeln('Arxiu recuperat...');
          End;

          readln;
          END;

       9: BEGIN         {  GRABAR EN UN FITXER }
          write('Arxiu on vol guardar: ');
          readln(nom);
          assign(f,nom);
          rewrite(f);
          p:=ini;
          while p <> nil do begin
                aux.inf:=p^.inf;
                write(f,aux);
                p:=p^.seg;
          End;
          close(f);
          writeln('Arxiu grabat...');
          readln;
          END;

  End; {case}

Until (opcio=0);
END.