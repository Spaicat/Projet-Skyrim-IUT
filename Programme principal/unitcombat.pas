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
     monstre.pseudo:= 'Illyar';
     monstre.pv:= 120;
     monstre.pvMax:=120;
     monstre.attaque:=10;
     monstre.argent:=12;
     Illyar := monstre;
end;

function Qjard():Personnage;

var
   monstre : Personnage;

begin
     monstre.pseudo := 'Qjard';
     monstre.pv := 125;
     monstre.pvMax := 125;
     monstre.attaque := 11;
     monstre.argent := 12;
     Qjard := monstre;
end;

function Ksiorn():Personnage;

var
   monstre : Personnage;

begin
     monstre.pseudo := 'Ksiorn';
     monstre.pv := 130;
     monstre.pvMax := 130;
     monstre.attaque := 20;
     monstre.argent := 12;
     Ksiorn := monstre;
end;
function Ivrogne():Personnage;
var
   monstre : Personnage;
begin
   monstre.pseudo := 'L''Ivrogne';
   monstre.pv := 75;
   monstre.pvMax := 75;
   monstre.attaque := 15;
   monstre.argent := 30;
   Ivrogne := monstre;
end;


//Procedure gérant tous les combats
procedure combat(var perso,monstre: personnage;var inventairePerso : Inventaire;var fuite : Boolean);

var
   sortie: Boolean;     //Variable de sortie de boucle
   choix: Integer;      //Variable qui definie les choix du joueur
   attaque: Integer;     //Variable qui stock l'attaque du personnage et du monstre
   rng : Integer;        //Variable qui stokera une valeur aleatoire
   effet : Integer;     //Variable qui définie l'effet du personnage //0 = rien //1 = étourdissement
   effetDuree : Integer;  //Variable qui compte la duree de l'effet

begin
      randomize;
      sortie := False;
      fuite := False;
      effet := 0;
      effetDuree := 0;

       while sortie=FALSE DO
       begin
         attendre(3000);
         setPersonnage(perso);
         InterfaceInGame();
         writelnPerso();
         writelnPerso('=============');
         writelnPerso(' ' + monstre.pseudo + ' PV : ' + IntToStr(monstre.pv) + ' / ' + IntToStr(monstre.pvMax));
         writelnPerso('=============');
         writelnPerso();

         writelnPerso('Choisissez une option : ');
         writelnPerso(' >  Attaquer');
         writelnPerso(' >  Se defendre');
         writelnPerso(' >  Utiliser une potion');
         writelnPerso(' >  Fuite');
         choix := selectionMenu(posXY(positionCurseur().x, positionCurseur().y-3), 4, 1, 2, LightBlue, White) + 1;

         case choix of
              1:
              begin
                if effet = 1 then
                  begin
                  writelnPerso('Vous etes etoudit');
                  rng := random(2);
                  if rng = 1 then
                    begin
                    writelnPerso('Vous n''avez pas reussie a frapper...');
                    effetDuree := effetDuree + 1;
                    attaque:= monstre.attaque + random(monstre.attaque div 2);
                    if attaque < 0 then
                      attaque := 0;
                    perso.pv:= perso.pv - attaque;
                    writelnPerso();
                    writelnPerso(monstre.pseudo + ' vous attaque, ' + ' vous subissez ' + IntToStr(attaque) + ' pv. Il vous reste ' + IntToStr(perso.pv) + ' pv.');
                    if effetDuree = 3 then
                      effet := 0;
                    end
                  else
                    begin
                    writelnPerso('Vous frapper malgre l''etourdissement');
                    attaque:= perso.attaque + random(perso.attaque div 2);
                    monstre.pv := monstre.pv - attaque;
                    if monstre.pv <= 0 then
                      monstre.pv :=  0;
                    writelnPerso('Vous attaquez ' + monstre.pseudo + ' il subit ' + IntToStr(attaque) + ' pv. Il lui reste ' + IntToStr(monstre.pv) + ' pv.');
                    attaque:= monstre.attaque + random(monstre.attaque div 2);
                    if attaque < 0 then
                      attaque := 0;
                    perso.pv:= perso.pv - attaque;
                    writelnPerso();
                    writelnPerso(monstre.pseudo + ' vous attaque, ' + ' vous subissez ' + IntToStr(attaque) + ' pv. Il vous reste ' + IntToStr(perso.pv) + ' pv.');
                    effetDuree := effetDuree + 1;
                    if effetDuree = 3 then
                      effet := 0;
                    end;
                  end
                else
                  begin
                  attaque:= perso.attaque + random(perso.attaque div 2);
                  monstre.pv := monstre.pv - attaque;
                  if monstre.pv <= 0 then
                    monstre.pv :=  0;
                  writelnPerso('Vous attaquez ' + monstre.pseudo + ' il subit ' + IntToStr(attaque) + ' pv. Il lui reste ' + IntToStr(monstre.pv) + ' pv.');
                  attaque:= monstre.attaque + random(monstre.attaque div 2);
                  if attaque < 0 then
                    attaque := 0;
                  perso.pv:= perso.pv - attaque;
                  writelnPerso();
                  writelnPerso(monstre.pseudo + ' vous attaque, ' + ' vous subissez ' + IntToStr(attaque) + ' pv. Il vous reste ' + IntToStr(perso.pv) + ' pv.');
                  rng := random(4);
                  if rng = 1 then
                    begin
                    writelnPerso('Le coup vous a etoudit !');
                    effet := 1;
                    end;
                  end;
              end;
              2:
              begin
                if effet = 1 then
                  begin
                  writelnPerso('Vous etes etoudit');
                  rng := random(2);
                  if rng = 1 then
                    begin
                    writelnPerso('Vous n''avez pas reussie a frapper...');
                    effetDuree := effetDuree + 1;
                    attaque:= monstre.attaque + random(monstre.attaque div 2);
                    if attaque < 0 then
                      attaque := 0;
                    perso.pv:= perso.pv - attaque;
                    writelnPerso();
                    writelnPerso(monstre.pseudo + ' vous attaque, ' + ' vous subissez ' + IntToStr(attaque) + ' pv. Il vous reste ' + IntToStr(perso.pv) + ' pv.');
                    if effetDuree = 3 then
                      effet := 0;
                    end
                  else
                    begin
                    writelnPerso('Vous frapper malgre l''etourdissement');
                    attaque:= perso.attaque + random(perso.attaque div 2);
                    monstre.pv := monstre.pv - attaque;
                    if monstre.pv <= 0 then
                      monstre.pv :=  0;
                    writelnPerso('Vous attaquez ' + monstre.pseudo + ' il subit ' + IntToStr(attaque) + ' pv. Il lui reste ' + IntToStr(monstre.pv) + ' pv.');
                    attaque:= monstre.attaque + random(monstre.attaque div 2);
                    if attaque < 0 then
                      attaque := 0;
                    perso.pv:= perso.pv - attaque;
                    writelnPerso();
                    writelnPerso(monstre.pseudo + ' vous attaque, ' + ' vous subissez ' + IntToStr(attaque) + ' pv. Il vous reste ' + IntToStr(perso.pv) + ' pv.');
                    effetDuree := effetDuree + 1;
                    if effetDuree = 3 then
                      effet := 0;
                    end;
                  end
                else
                  begin
                  attaque:= (perso.attaque div 2) + random(perso.attaque div 2);
                  monstre.pv := monstre.pv - attaque;
                  writelnPerso('Vous contrez ' + monstre.pseudo + ' il subit ' + IntToStr(attaque) + '. Il lui reste ' + IntToStr(monstre.pv));
                  attaque:= (monstre.attaque + random(monstre.attaque div 2)) - perso.defense;
                  if attaque < 0 then
                    attaque := 0;
                  perso.pv:= perso.pv - attaque;
                  writelnPerso(monstre.pseudo + ' vous attaque, ' + ' vous subissez ' + IntToStr(attaque) + ' pv. Il vous reste ' + IntToStr(perso.pv) + ' pv.');
                  end;
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
                  writelnPerso('Vous regagnez 100 PV !');
                  inventairePerso.possession[3] := inventairePerso.possession[3]-1;
                  perso.pv := perso.pv + 100;
                  if perso.pv > perso.pvMax then
                    perso.pv := perso.pvMax;
                  attaque:= monstre.attaque + random(monstre.attaque div 2);
                  if attaque < 0 then
                    attaque := 0;
                  perso.pv:= perso.pv - attaque;
                  writelnPerso();
                  writelnPerso(monstre.pseudo + ' vous attaque, vous subissez ' + IntToStr(attaque) + ' pv. Il vous reste ' + IntToStr(perso.pv) + ' pv.');
                  rng := random(4);
                  if rng = 1 then
                    begin
                    writelnPerso('Le coup vous a etoudit !');
                    effet := 1;
                    end;
                  end;
              end;
              4:
              begin
                rng := random(2);
                if rng = 1 then
                  begin
                  writelnPerso('Vous vous enfuyez !');
                  sortie:= True;
                  fuite := True;
                  readlnPerso();
                  end
                else
                  begin
                  writelnPerso('Vous n''avez pas reussi a vous enfuir...');
                  attaque:= (monstre.attaque + random(monstre.attaque div 2)) - perso.defense;
                  perso.pv:= perso.pv - attaque;
                  writelnPerso(monstre.pseudo + ' vous attaque, vous subissez ' + IntToStr(attaque) + ' pv. Il vous reste ' + IntToStr(perso.pv) + ' pv.');
                  rng := random(5);
                  if rng = 1 then
                    begin
                    writelnPerso('Le coup vous a etoudit !');
                    effet := 1;
                    end;
                  end;
              end;
       end;
         if monstre.pv<=0 then
           begin
             sortie := True;
             writelnPerso('Vous avez gagnez !!');
             writelnPerso('Vous gagnez ' + IntToStr(monstre.argent) + ' or !');
             perso.argent := perso.argent + monstre.argent;
             readlnPerso();
           end;
         if perso.pv <= 0 then
           begin
           writelnPerso('Vous êtes mort...');
           readlnPerso();
           Halt(1);
           end;
         writelnPerso();
       end;
end;
end.
