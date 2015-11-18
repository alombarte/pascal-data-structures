Program Cua_simple;
Uses crt;

type apuntador=^node;
     node=record
     inf:char;
     seg:apuntador;
     End;
VAR
     p,q,ini,fi:apuntador;
     opcio:word;

Procedure Afegeix;
Begin
     write('Lletra: ');
     new(p);
     readln(p^.inf);
     If (ini = nil) then begin;
        p^.seg:=nil;
        ini:=p;
        fi:=ini;
     End
     Else begin
       p^.seg:=ini;
       ini:=p;
     End;
End;

Procedure borra;
BEGIN
  If ini <> nil then begin
     while p^.seg <> fi do begin
           q:=p;
           p:=p^.seg;
     End;
     q^.seg:=nil;
     dispose(fi);
     fi:=q;
     

  End;
END;
procedure veure;
BEGIN
     p:=ini;
     while p<>nil do begin
       write(p^.inf,' -> ');
       p:=p^.seg;
     End;
     readln;
END;

BEGIN
     ini:=nil;
     fi:=nil;
     repeat
     clrscr;
     writeln('1. Afegir (al principi)');
     writeln('2. Borrar (al final)');
     writeln('3. Visualitzar');
     writeln('0. EXIT');
     writeln('');
     write('Opci¢: ');
     readln(opcio);
     case (opcio) of
          1:afegeix;
          2:borra;
          3:veure;
     End;
     Until (opcio=0);

END.