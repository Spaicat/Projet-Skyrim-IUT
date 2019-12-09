unit UnitMenu;

interface
uses UnitPersonnage, UnitMagasin, unitCombat, GestionEcran, unitLieu, TypInfo, Keyboard, Classes, SysUtils;

//Procédure qui affiche le menu initial
procedure menuInitial();
//Procédure pour lancer le jeu
procedure LaunchGame();
//Procédure pour quitter le jeu
procedure QuitGame();
//Procédure pour afficher l'interface du jeu
procedure InterfaceInGame(position : TInformation);

function Key() : TKeyEvent;
procedure redo();
function lancerMenu():Boolean;

implementation
//Procédure qui affiche le menu initial
procedure menuInitial();
var
  rep : Integer;
  coorC : coordonnees;
  coorC2 : coordonnees;
  coorT : coordonnees;
  coorT2 : coordonnees;
  coorT3 : coordonnees;
  largeur : Integer;
  hauteur : Integer;
  volonte : Integer;
  lancement : Boolean;
  touche : TKeyEvent;
begin
  repeat
    writeln('Commencer une partie - 1');
    writeln('Quitter - 2');
    write('Choisissez votre action : ');
    readln(rep);
    if (rep<1) OR (rep>2) then //On teste si la réponse est bien ce que l'on veut
    begin
      writeln('Veuillez saisir une réponse valide');
      attendre(1000);
      effacerEcran();
    end;
  until (rep>=1) AND (rep<=2);
  case rep of //On lance les fonctions en conséquences
       1:LaunchGame();
       2:QuitGame();
  end;
end;


//Procédure pour quitter le jeu
procedure LaunchGame();
begin
  effacerEcran();
  createCharacter();
end;


//Procédure pour quitter le jeu
procedure QuitGame();
var
  rep : Char;
begin
  repeat
  effacerEcran();
  write('Etes vous sur de vouloir quitter ? [o/n] : ');
  readln(rep);
  if rep ='o' then
     writeln('Au plaisir de vous revoir')
  else if rep<>'n' then
      begin
      writeln('Veuillez saisir une réponse valide');
      attendre(1000);
      end;
  until (rep = 'o') OR (rep = 'n');
  effacerEcran();
  Halt(1);
end;

procedure InterfaceInGame(position : TInformation);
begin
  writeln('===========================');
  writeln('Pseudo : ', persoChoose.pseudo);
  writeln('Race : ', persoChoose.race);
  writeln('PV : ', persoChoose.pv, ' / ', persoChoose.pvMax);
  writeln('Bourse : ', persoChoose.argent, ' Gold');
  writeln('Vous vous-situez à ',position.nom);
  writeln('===========================');
end;

function Key() : TKeyEvent;
var
  K:TKeyEvent;
begin
InitKeyBoard;
  Repeat
    K:=GetKeyEvent;
    K:=TranslateKeyEvent(K);
  until (GetKeyEventChar(K)<>'');
  Key :=K;
DoneKeyBoard;
end;

procedure redo();

var
  coorC : coordonnees;
  coorC2 : coordonnees;
begin
  coorC.x := 2;      //Coor 1
  coorC.y := 2;
  coorC2.x := 95;     //Coor 2
  coorC2.y := 30;

  effacerEcran();
  dessinerCadre(coorC,coorC2,double,4,0);
end;

function lancerMenu():Boolean;
var
  coorC : coordonnees;
  coorC2 : coordonnees;
  coorT : coordonnees;
  coorT2 : coordonnees;
  coorT3 : coordonnees;
  largeur : Integer;
  hauteur : Integer;
  volonte : Integer;
  lancement : Boolean;
  touche : TKeyEvent;

 // personnageCree : personnageStat;

begin
  coorC.x := 2;      //Coor 1
  coorC.y := 0;
  coorC2.x := 197;     //Coor 2
  coorC2.y := 58;

  coorT.x := 50;      //Coor Texte
  coorT.y := 18 - 5;

  coorT2.x := 50 ;    // Coor Texte2
  coorT2.y := 18 + 5;

  largeur := 200;
  hauteur := 60;


  changerTailleConsole(largeur,hauteur);
  dessinerCadre(coorC,coorC2,double,4,0);
  couleurTexte(LightBlue);
  ecrireEnPosition(coorT,'Jouer ?');
  ecrireEnPosition(coorT2,'Quitter ?');

  repeat
  Touche := Key();
  if (KeyEventToString(Touche)='Up') then
    deplacerCurseur(coorT)
  else
    if (KeyEventToString(Touche)='Down') then
    deplacerCurseur(coorT2);

  until (KeyEventToString(Touche)=chr(13));
  if (positionCurseur().y = coorT.y) AND (positionCurseur().x = coorT.x) then
    lancement := True
  else
    lancement := False;
  lancerMenu := lancement;
end;

end.

