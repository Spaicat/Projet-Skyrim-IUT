unit unitCombat;



interface
    uses unitPersonnage;

  // TYPES

  //FONCTIONS ET PROCEDURES

    procedure combat(var perso,monstre: personnage);


implementation

procedure combat(var perso,monstre: personnage);

var
   sortie: Boolean;
   choix: Integer;
   attaque: Integer;
begin
randomize;
sortie := False;
       while sortie=FALSE DO
       begin


         writeln('Choisissez une option : ');
         writeln('1 - Attaquer');
         writeln('2 - Se defendre');
         writeln('3 - Fuite');
         readln(choix);
         case choix of
              1:
              begin
                attaque:= perso.attaque + random(perso.attaque div 2);
                monstre.pv := monstre.pv - attaque;
                if monstre.pv <= 0 then
                  monstre.pv :=  0;
                writeln('Vous attaquez ',monstre.pseudo,' il subit ',attaque,' pv. Il lui reste ',monstre.pv,' pv.');
                attaque:= monstre.attaque + random(monstre.attaque div 2);
                perso.pv:= perso.pv - attaque;
                writeln;
                writeln(monstre.pseudo,' vous attaque, ',' vous subissez ',attaque,' pv. Il vous reste ',perso.pv,' pv.');
              end;
              2:
              begin
                attaque:= (perso.attaque div 2) + random(perso.attaque div 2);
                monstre.pv := monstre.pv - attaque;
                writeln('Vous contrez ',monstre.pseudo,' il subit ',attaque,'. Il lui reste ',monstre.pv);
                attaque:= (monstre.attaque + random(monstre.attaque div 2)) - perso.defense;
                perso.pv:= perso.pv - attaque;
                writeln(monstre.pseudo,' vous attaque, ',' vous subissez ',attaque,' pv. Il vous reste ',perso.pv,' pv.');
              end;
              3:
              begin
                writeln('Vous vous enfuyez...');
                sortie:=TRUE;
              end;
       end;
         IF monstre.pv<=0 then
           begin
             sortie := True;
             writeln('Vous avez gagnez !!');
             writeln('Vous gagnez ',monstre.argent,' or !');
             perso.argent := perso.argent + monstre.argent;
         if perso.pv <= 0 then
           begin
           writeln('Vous êtes mort...');
           // QuitGame();
           end;
           end;
         writeln;
end;
end;
end.

