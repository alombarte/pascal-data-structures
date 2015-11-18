PROGRAM ArxiusDeTipus;
USES Crt;

TYPE
    Alumne=record
       Nom: String [20];
       Edat: Word;
       nota:real;
    End;

VAR
   f:FILE of Alumne;
   tmp: FILE of ALumne;
   AUX: Alumne;
   option: word;
   ch:char;
   BorraNom:string;

Procedure Afegir;
  begin
     write('Nom: ');
     readln(Aux.nom);
     write('Edat: ');
     readln(Aux.edat);
     write('Nota: ');
     readln(aux.nota);

     reset(f);
     seek(f,filesize(f));
     write(f,Aux);
     close(f);

  end;

Procedure Visualitzar;
   begin
      clrscr;
      reset(f);
      while not eof (f) do begin
      clrscr;
      read(f,aux);
      If Aux.edat <> 0 then begin
        writeln(aux.Nom);
        writeln(aux.Edat);
        writeln(aux.Nota:2:2);
        ch:=readkey;
      End;
      End;
      close(f);
   End;

Procedure Borrar;

  begin
     write('Nom a borrar?: ');
     readln(BorraNom);
     clrscr;
     reset(f);
     while not eof (f) do begin
       read(f,aux);
       If (aux.nom=BorraNom) then begin
          seek(f,filepos(f)-1);
          aux.edat:=0;
          write(f,aux);
       End;
     End;
     close(f);
  End;
Procedure Modificar;
Begin
     write('Nom a modificar?: ');
     readln(BorraNom);
     clrscr;
     reset(f);
     while not eof (f) do begin
       read(f,aux);
       If (aux.nom=BorraNom) then begin
          seek(f,filepos(f)-1);
          write('Nom: ');
          readln(aux.nom);
          write('Edat: ');
          readln(aux.edat);
          write('Nota: ');
          readln(aux.nota);
          write(f,aux);
       End;
     End;
     close(f);


End;
Procedure Mitja;
var m:real;
c:word;
Begin
     c:=0;
     m:=0;
     reset(f);
     while not eof (f) do begin
     read(f,aux);
     if (aux.edat <> 0) then begin
        c:=c+1;
        m:=(m+aux.nota)/c;
     End;
     End;
     write('La mitja de notes ‚s ',m:2:2);
     readln;
End;

Procedure Sortir; {Copia el fitxer amb un altre de temporal i el torna
                   a copiar sense camp edat=0}
  VAR

     f_aux:File of alumne;

  BEGIN

  Assign(f_aux,'DADES.TMP');
  {$I-}
    reset(f_aux);
    close(f_aux);
  {$I+}
  If IOResult <> 0 then begin
  rewrite(f_aux);
  close(f_aux);
  End;

  reset(f);
  reset(f_aux);
  seek(f_aux,0);
  seek(f,0);

  While not eof (f) do begin
    read(f,aux);
    if (aux.edat > 0) then begin
       write(f_aux,aux);
    End;
  End;
  close(f);
  close(f_aux);

  
  reset(f_aux);
  seek(f_aux,0);
  rewrite(f);
  seek(f,0);

  While not eof (f_aux) do begin
     read(f_aux,aux);
     write(f,aux);
  End;
  close(f);
  close(f_aux);
  erase(f_aux);

  END;


                  {       M       A       I        N      }


   


BEGIN
     Assign(f,'Dades.dat');
     {$I-}
      reset(f);
      close(f);
     {$I+}
     If IOResult <> 0 then begin
        rewrite(f);
        close(f);
     End;

     repeat
         clrscr;
         textcolor(white);
         writeln('1. Visualitzar');
         writeln('2. Afegir');
         writeln('3. Borrar');
         writeln('4. Modificar');
         writeln('5. Mitja');
         writeln;
         writeln('0. SORTIR i COMPACTAR');
         writeln;
         write('Opci¢: ');
         readln(option);


     case (option) of

          1:visualitzar;
          2:Afegir;
          3:Borrar;
          4:Modificar;
          5:Mitja;
          0:sortir;
     End; {del case}
     Until (Option=0);

END.