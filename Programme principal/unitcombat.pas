unit unitCombat;



interface
    uses unitPersonnage, unitInventaire, GestionEcran, SysUtils, TypInfo;

  //FONCTIONS ET PROCEDURES

    procedure combat(var perso,monstre: personnage;var inventairePerso : Inventaire;var fuite : Boolean);
    //Procedure gérant tous les combats

    function Illyar():personnage;
    //Fonction permettant de gérer le premier dragon

    function Qjard():Personnage;
    //Fonction permettant de gérer le second dragon

    function Ksiorn():Personnage;
    //Fonction permettant de gérer le troisième dragon

    function Ivrogne():Personnage;
    //Fonction permettant de gérer l'Ivrogne qui est là la nuit sur la place du marché


implementation

uses UnitMenu, unitLieu;

function Illyar():Personnage;

var
   monstre : Personnage;

begin
     monstre.pseudo:= 'Illÿar';
     monstre.pv:= 120;
     monstre.pvMax:=120;
     monstre.attaque:=10;
     monstre.argent:=12;
     Illyar:=monstre;
end;

function Qjard():Personnage;

var
   monstre : Personnage;

begin
     monstre.pseudo:= 'Qjärd';
     monstre.pv:= 125;
     monstre.pvMax:=125;
     monstre.attaque:=11;
     monstre.argent:=12;
     Qjard:=monstre;
end;

function Ksiorn():Personnage;

var
   monstre : Personnage;

begin
     monstre.pseudo:= 'Ksïorn';
     monstre.pv:= 130;
     monstre.pvMax:=130;
     monstre.attaque:=20;
     monstre.argent:=12;
     Ksiorn:=monstre;
end;
function Ivrogne():Personnage;
var
   monstre : Personnage;
begin
   monstre.pseudo:= 'L''Ivrogne';
   monstre.pv:= 75;
   monstre.pvMax:=75;
   monstre.attaque:=15;
   monstre.argent:=30;
   Ivrogne:=monstre;
end;

procedure combat(var perso,monstre: personnage;var inventairePerso : Inventaire;var fuite : Boolean);

var
   sortie: Boolean;
   choix: Integer;
   attaque: Integer;
   rng : Integer;
begin
randomize;
sortie := False;
randomize();

       while sortie=FALSE DO
       begin

         attendre(4000);
         effacerEcran();
         setPersonnage(perso);
         InterfaceInGame(position);
         writelnPerso();
         writelnPerso('=============');
         writelnPerso(' ' + monstre.pseudo + ' PV : ' + IntToStr(monstre.pv) + ' / ' + IntToStr(monstre.pvMax));
         writelnPerso('=============');
         writelnPerso();
         writelnPerso('Choisissez une option : ');
         writelnPerso('1 - Attaquer');
         writelnPerso('2 - Se defendre');
         writelnPerso('3 - Utiliser une potion');
         writelnPerso('4 - Fuite');
         readlnPerso(choix);
         case choix of
              1:
              begin
                attaque:= perso.attaque + random(perso.attaque div 2);
                monstre.pv := monstre.pv - attaque;
                if monstre.pv <= 0 then
                  monstre.pv :=  0;
                writelnPerso('Vous attaquez ' + monstre.pseudo + ' il subit ' + IntToStr(attaque) + ' pv. Il lui reste ' + IntToStr(monstre.pv) + ' pv.');
                attaque:= monstre.attaque + random(monstre.attaque div 2);
                perso.pv:= perso.pv - attaque;
                writelnPerso();
                writelnPerso(monstre.pseudo + ' vous attaque, ' + ' vous subissez ' + IntToStr(attaque) + ' pv. Il vous reste ' + IntToStr(perso.pv) + ' pv.');
              end;
              2:
              begin
                attaque:= (perso.attaque div 2) + random(perso.attaque div 2);
                monstre.pv := monstre.pv - attaque;
                writelnPerso('Vous contrez ' + monstre.pseudo + ' il subit ' + IntToStr(attaque) + '. Il lui reste ' + IntToStr(monstre.pv));
                attaque:= (monstre.attaque + random(monstre.attaque div 2)) - perso.defense;
                perso.pv:= perso.pv - attaque;
                writelnPerso(monstre.pseudo + ' vous attaque, ' + ' vous subissez ' + IntToStr(attaque) + ' pv. Il vous reste ' + IntToStr(perso.pv) + ' pv.');
              end;
              3:
              begin
                if inventairePerso.possession[3] = 0 then
                  begin
                  writelnPerso('Vous N''avez pas de potion...');
                  writelnPerso('Choissiser une autre option.');
                  end
                else
                  begin
                  writelnPerso('Vous consommer une potion !');
                  writelnPerso('Vous regagnez 30 PV !');
                  inventairePerso.possession[3] := inventairePerso.possession[3]-1;
                  perso.pv := perso.pv + 30;
                  if perso.pv > perso.pvMax then
                    perso.pv := perso.pvMax;
                  attaque:= monstre.attaque + random(monstre.attaque div 2);
                  perso.pv:= perso.pv - attaque;
                  writelnPerso();
                  writelnPerso(monstre.pseudo + ' vous attaque, vous subissez ' + IntToStr(attaque) + ' pv. Il vous reste ' + IntToStr(perso.pv) + ' pv.');
                  end;
              end;
              4:
              begin
                rng := random(2);
                if rng = 1 then
                  begin
                  writelnPerso('Vous vous enfuyez !');
                  sortie:=TRUE;
                  fuite := True;
                  end
                else
                  begin
                  writelnPerso('Vous n''avez pas reussi a vous enfuir...');
                  attaque:= (monstre.attaque + random(monstre.attaque div 2)) - perso.defense;
                  perso.pv:= perso.pv - attaque;
                  writelnPerso(monstre.pseudo + ' vous attaque, vous subissez ' + IntToStr(attaque) + ' pv. Il vous reste ' + IntToStr(perso.pv) + ' pv.');
                  end;
              end;
       end;
         IF monstre.pv<=0 then
           begin
             sortie := True;
             writelnPerso('Vous avez gagnez !!');
             writelnPerso('Vous gagnez ' + IntToStr(monstre.argent) + ' or !');
             perso.argent := perso.argent + monstre.argent;
         if perso.pv <= 0 then
           begin
           writelnPerso('Vous êtes mort...');
           // QuitGame();
           end;
           end;
         writelnPerso();
end;
end;
end.
