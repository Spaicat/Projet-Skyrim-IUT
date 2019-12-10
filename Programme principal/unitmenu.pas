unit UnitMenu;

interface
uses UnitPersonnage, GestionEcran, unitLieu, TypInfo, Keyboard, Classes, SysUtils;

//Procédure qui affiche le menu initial
procedure menuInitial();
//Procédure pour lancer le jeu
procedure LaunchGame();
//Procédure pour quitter le jeu
procedure QuitGame();
//Procédure pour afficher l'interface du jeu
procedure InterfaceInGame(position : TInformation);
//Procédure qui permet d'afficher un menu à partir d'une liste de texte (par exemple pour le menu initial)
procedure afficherListeMenu(ListeTexte : array of String; coordMenuInitial : coordonnees; distanceEntreTexte : Integer);

function selectionMenu(coordMin : coordonnees; nbText : Integer; distanceEntreTexte, couleurFondTexte, couleurTexte : Integer) : Integer;

function Key() : TKeyEvent;
procedure redo();

implementation

//Procédure qui affiche le menu initial
procedure menuInitial();
var
  rep : Integer;
  coorT : coordonnees;
  coorTMax : coordonnees;
  coorT3 : coordonnees;
  volonte : Integer;
  lancement : Boolean;
  touche : TKeyEvent;
  ListeMenuInitial : array of String;
  choiceMenu : Integer;

 // personnageCree : personnageStat;

begin
  coorT.x := 96;      //Coor Texte
  coorT.y := 30 - 5;

  coorTMax.x := coorT.x;    // Coor Texte2
  coorTMax.y := coorT.y + 5;

  redo();
  couleurTexte(White);

  setLength(ListeMenuInitial, 2);
  ListeMenuInitial[0] := 'Jouer ?';
  ListeMenuInitial[1] := 'Quitter ?';
  afficherListeMenu(ListeMenuInitial, coorT, 5);
  choiceMenu := selectionMenu(coorT, 2, 5, LightBlue, White);

  if choiceMenu = 0 then
    LaunchGame()
  else
    QuitGame();

  readln;
end;


//Procédure pour quitter le jeu
procedure LaunchGame();
begin
  redo();
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
  coorC,
  coorC2 : coordonnees;
  largeur,
  hauteur : Integer;
begin
  coorC.x := 2;      //Coor 1
  coorC.y := 0;
  coorC2.x := 197;     //Coor 2
  coorC2.y := 58;
  largeur := 200;
  hauteur := 60;

  effacerEcran();
  changerTailleConsole(largeur,hauteur);
  dessinerCadre(coorC,coorC2,double,4,0);
  couleurTexte(White);
end;

//Procédure qui permet d'afficher un menu à partir d'une liste de texte (par exemple pour le menu initial)
procedure afficherListeMenu(ListeTexte : array of String; coordMenuInitial : coordonnees; distanceEntreTexte : Integer);
var
  i : Integer;
  coordTemp : coordonnees;
begin
  coordTemp.x := coordMenuInitial.x;
  coordTemp.y := coordMenuInitial.y;
  for i:=low(ListeTexte) to high(ListeTexte) do
      begin
      ecrireEnPosition(coordTemp, ListeTexte[i]);
      coordTemp.x := coordTemp.x;
      coordTemp.y := coordTemp.y + distanceEntreTexte;
      end;
end;

function selectionMenu(coordMin : coordonnees; nbText, distanceEntreTexte: Integer; couleurFondTexte, couleurTexte : Integer) : Integer;
var
  coordTemp,
  coordMax : coordonnees;
  selectedChoice : Integer;
  Touche : TKeyEvent;
begin
  deplacerCurseur(CoordMin);
  coordTemp.x := coordMin.x;
  coordTemp.y := coordMin.y;
  ColorierZone(couleurFondTexte, couleurTexte, coordTemp.x, coordTemp.x+10, coordTemp.y);
  coordMax.y := coordMin.y + (nbText-1)*distanceEntreTexte;
  coordMax.x := coordMin.x;
  repeat
    Touche := Key();
    if (KeyEventToString(Touche)='Up') then
       if coordTemp.y = coordMin.y then
          begin
          ColorierZone(0, 15, coordTemp.x, coordTemp.x+10, coordTemp.y);
          coordTemp := coordMax;
          deplacerCurseur(coordTemp);
          ColorierZone(couleurFondTexte, couleurTexte, coordTemp.x, coordTemp.x+10, coordTemp.y);
          end
       else
          begin
          ColorierZone(0, 15, coordTemp.x, coordTemp.x+10, coordTemp.y);
          coordTemp.y := coordTemp.y-distanceEntreTexte;
          deplacerCurseur(coordTemp);
          ColorierZone(couleurFondTexte, couleurTexte, coordTemp.x, coordTemp.x+10, coordTemp.y);
          end
    else if (KeyEventToString(Touche)='Down') then
       if coordTemp.y = coordMax.y then
          begin
          ColorierZone(0, 15, coordTemp.x, coordTemp.x+10, coordTemp.y);
          coordTemp := coordMin;
          deplacerCurseur(coordTemp);
          ColorierZone(couleurFondTexte, couleurTexte, coordTemp.x, coordTemp.x+10, coordTemp.y);
          end
       else
          begin
          ColorierZone(0, 15, coordTemp.x, coordTemp.x+10, coordTemp.y);
          coordTemp.y := coordTemp.y+distanceEntreTexte;
          deplacerCurseur(coordTemp);
          ColorierZone(couleurFondTexte, couleurTexte, coordTemp.x, coordTemp.x+10, coordTemp.y);
          end;

  until (KeyEventToString(Touche)=chr(13));
  selectedChoice := (coordTemp.y - CoordMin.y) div distanceEntreTexte;
  selectionMenu:=selectedChoice;
end;

end.

