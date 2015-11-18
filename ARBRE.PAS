PROGRAM ArbreBinari;
USES Crt;

TYPE apuntador=^node;
     node=record
       inf:char;
       ant:apuntador;
       esq:apuntador;
       dret:apuntador;
       nivell:integer;
     End;

VAR
   p,q,arrel:apuntador;
   opcio,opcio2:integer;


{             --- ARBRE BINARI ---

        A               Preordre: arrel/esquerra/dreta:  ABDCEF
      /  \              Inordre:  esquerra/arrel/dreta:  DBAECF
     B    C             postordre: esquerra/dreta/arrel: DBEFCA
   /    /  \
  D    E    F

}


PROCEDURE Preordre(p:apuntador);
Begin
     write(p^.inf,', ');
     If (p^.esq<>nil) then preordre(p^.esq);
     If (p^.dret<>nil) then preordre(p^.dret);
End;


PROCEDURE Inordre(p:apuntador);
     BEGIN

     
     If (p^.esq<>nil) then inordre(p^.esq);
     write(p^.inf,' ,');
     If (p^.dret<>nil) then inordre(p^.dret);
     End;


PROCEDURE Postordre(p:apuntador);
Begin
     If (p^.esq<>nil) then postordre(p^.esq);
     If (p^.dret<>nil) then postordre(p^.dret);
     write(p^.inf,' ,');


End;
BEGIN

     repeat
     clrscr;
     writeln('----_BIN TREE_----');
     writeln;
     writeln('1. Crear arbre');
     writeln('2. Recorregut');
     writeln;
     writeln('0. Sortir');
     writeln;
     write('Opci¢ => ');
     readln(opcio);

     case (opcio) of
          1:BEGIN

            write('Lletra del Node arrel: ');
            new(p);
            readln(p^.inf);
            p^.ant:=nil;
            p^.esq:=nil;
            p^.dret:=nil;
            p^.nivell:=0;
            arrel:=p;

            repeat
            clrscr;
            writeln('----_BIN TREE (2)_----');
            writeln;
            writeln('1. Fill esquerre');
            writeln('2. Fill dret');
            writeln('3. Retrocedir');
            writeln;
            writeln('0. Sortir');
            writeln;
            Writeln('NODE ACTUAL:  ',p^.inf);
            writeln('NIVELL ACTUAL:  ',p^.nivell);
            WRITELN;
            write('Opci¢ => ');
            readln(opcio2);
            case (opcio2) of
              1:begin
                   new(q);
                   Write('Node: ');
                   readln(q^.inf);
                   q^.ant:=p;
                   p^.esq:=q;
                   q^.esq:=nil;
                   q^.dret:=nil;
                   q^.nivell:=p^.nivell+1;
                   p:=q;
                end;

              2:begin
                   new(q);
                   Write('Node: ');
                   readln(q^.inf);
                   q^.ant:=p;
                   p^.dret:=q;
                   q^.esq:=nil;
                   q^.dret:=nil;
                   q^.nivell:=p^.nivell+1;
                   p:=q;
                end;
              3:IF P^.ANT <> NIL THEN p:=p^.ant;

            End;
            until (opcio2=0);
            END;
          2:BEGIN
            repeat
            clrscr;
            writeln('----_BIN TREE (2)_----');
            writeln;
            writeln('1. Preordre');
            writeln('2. Inordre');
            writeln('3. Postordre');
            writeln;
            writeln('0. Sortir');
            writeln;
            write('Opci¢ => ');
            readln(opcio2);

            case (opcio2) of
            1: begin Preordre(arrel); readln; end;
            2: BEGIN Inordre(arrel); readln; end;
            3: begin Postordre(arrel); readln; end;
            End;

            until (opcio2=0);
            END;

     End;


     Until (opcio=0);

END.