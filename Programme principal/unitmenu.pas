unit UnitMenu;

interface
uses UnitPersonnage, GestionEcran, unitLieu, TypInfo, Keyboard, Classes, SysUtils, unitInventaire, unitDate;

//Procédure qui affiche le menu initial
procedure menuInitial();
//Procédure pour lancer le jeu
procedure LaunchGame();
//Procédure pour quitter le jeu
procedure QuitGame();
//Procédure pour afficher l'interface du jeu
procedure InterfaceInGame(position : TInformation);
procedure gestionMenu(var perso : Personnage; var inventairePerso : Inventaire; var indicateur : Integer; var nomEquipement : String);
//Procédure qui permet d'afficher un menu à partir d'une liste de texte (par exemple pour le menu initial)
procedure afficherListeMenu(ListeTexte : array of String; coordMenuInitial : coordonnees; distanceEntreTexte : Integer);

function selectionMenu(coordMin : coordonnees; nbText, distanceEntreTexte, distanceDuFond, couleurFondTexte, couleurTexte : Integer) : Integer;

function selectionMenuEtInterface(coordMin : coordonnees; nbText, distanceEntreTexte, distanceDuFond, couleurFondTexte, couleurTexte : Integer) : Integer;

procedure ecrireTexte(posCoord : coordonnees; textToWrite : String; largeur : Integer);

//Fonction writeln mais saute d'abord une ligne et marche avec des coordonnées non fixe (juste pour sauter une ligne)
procedure writelnPerso();
//Fonction writeln mais saute d'abord une ligne et marche avec des coordonnées non fixe
procedure writelnPerso(ligneAEcrire : String);

procedure readlnPerso();
//Fonction readln mais saute d'abord une ligne et marche avec des coordonnées non fixe (pour une chaine de caractères)
procedure readlnPerso(var ligneAEnregistrer : String);
//Fonction readln mais saute d'abord une ligne et marche avec des coordonnées non fixe (pour un entier)
procedure readlnPerso(var ligneAEnregistrer : Integer);

function Key() : TKeyEvent;
//Efface l'écran et reconstitue le cadre
procedure redo();

implementation

//Procédure qui affiche le menu initial
procedure menuInitial();
var
  rep : Integer;
  coorT : coordonnees;
  coorTTest : coordonnees;
  coorT3 : coordonnees;
  volonte : Integer;
  lancement : Boolean;
  touche : TKeyEvent;
  ListeMenuInitial : array of String;
  choiceMenu : Integer;
  asciiText : String;

 // personnageCree : personnageStat;

begin
  coorT.x := 96;      //Coor Texte
  coorT.y := 35;

  coorTTest.x := 40;
  coorTTest.y := 5;

  redo();
  couleurTexte(White);

  asciiText :=             '      #######      /                            ##### ##                                                              ';
  asciiText := asciiText + '    /       ###  #/                          ######  /###                          #                                  ';
  asciiText := asciiText + '   /         ##  ##                         /#   /  /  ###                        ###                           #     ';
  asciiText := asciiText + '   ##        #   ##                        /    /  /    ###                        #                           ##     ';
  asciiText := asciiText + '    ###          ##                            /  /      ##                                                    ##     ';
  asciiText := asciiText + '   ## ###        ##  /##  ##   ####           ## ##      ## ###  /###     /###   ###      /##       /###     ######## ';
  asciiText := asciiText + '    ### ###      ## / ###  ##    ###  /       ## ##      ##  ###/ #### / / ###  / ###    / ###     / ###  / ########  ';
  asciiText := asciiText + '      ### ###    ##/   /   ##     ###/      /### ##      /    ##   ###/ /   ###/   ##   /   ###   /   ###/     ##     ';
  asciiText := asciiText + '        ### /##  ##   /    ##      ##      / ### ##     /     ##       ##    ##    /   ##    ### ##            ##     ';
  asciiText := asciiText + '          #/ /## ##  /     ##      ##         ## ######/      ##       ##    ##   /    ########  ##            ##     ';
  asciiText := asciiText + '           #/ ## ## ##     ##      ##         ## ######       ##       ##    ##  ###   #######   ##            ##     ';
  asciiText := asciiText + '            # /  ######    ##      ##         ## ##           ##       ##    ##   ###  ##        ##            ##     ';
  asciiText := asciiText + '  /##        /   ##  ###   ##      ##         ## ##           ##       ##    ##    ### ####    / ###     /     ##     ';
  asciiText := asciiText + ' /  ########/    ##   ### / #########         ## ##           ###       ######      ### ######/   ######/      ##     ';
  asciiText := asciiText + '/     #####       ##   ##/    #### ###   ##   ## ##            ###       ####        ##  #####     #####        ##    ';
  asciiText := asciiText + '|                                   ### ###   #  /                                   ##                               ';
  asciiText := asciiText + ' \)                          #####   ### ###    /                                    /                                ';
  asciiText := asciiText + '                           /#######  /#   #####/                                    /                                 ';
  asciiText := asciiText + '                          /      ###/       ###                                    /                                  ';
  ecrireTexte(coorTTest, asciiText, 118);

  setLength(ListeMenuInitial, 2);
  ListeMenuInitial[0] := 'Jouer ?';
  ListeMenuInitial[1] := 'Quitter ?';
  afficherListeMenu(ListeMenuInitial, coorT, 5);
  choiceMenu := selectionMenu(coorT, 2, 5, 8, LightBlue, White);

  if choiceMenu = 0 then
    LaunchGame()
  else
    QuitGame();
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
var
  posTemp,
  posInterface, //Position du contenu de l'interface
  posCadre1 : coordonnees; //Position du coin haut gauche
  i : Integer; //Variable de boucle
  textTemp : String; //Variable qui affiche chaque ligne de l'inventaire
  listeInterface : array of String;
begin
  redo();
  posInterface.x := 5;
  posInterface.y := 4;
  posCadre1.x := 3;

  textTemp := 'Pseudo : ' + persoChoose.pseudo;
  ecrireEnPosition(posInterface, textTemp);
  posInterface.y := posInterface.y+1;

  textTemp := 'Race : ' + GetEnumName(TypeInfo(race), Ord(persoChoose.race));
  ecrireEnPosition(posInterface, textTemp);
  posInterface.y := posInterface.y+1;

  textTemp := 'PV : ' + IntToStr(persoChoose.pv) + ' / ' + IntToStr(persoChoose.pvMax);
  ecrireEnPosition(posInterface, textTemp);
  posInterface.y := posInterface.y+1;

  textTemp := 'Bourse : ' + IntToStr(persoChoose.argent) + ' Gold';
  ecrireEnPosition(posInterface, textTemp);
  posInterface.y := posInterface.y+1;

  textTemp := 'Position : ' + position.nom;
  ecrireEnPosition(posInterface, textTemp);
  posInterface.y := posInterface.y+1;

  textTemp := 'Date : ';
  ecrireEnPosition(posInterface, textTemp);
  writeDate();
  posInterface.y := posInterface.y+1;

  posCadre1.y := posInterface.y+2;
  couleurTexte(Red);
  deplacerCurseur(posCadre1);
  for i := posCadre1.x-1 to 195 do //On dessine la ligne du bas
    write(#205);

  posTemp := posCadre1;
  posCadre1.x := 25;
  for i := posCadre1.y to 56 do
    begin
    posCadre1.y := posCadre1.y + 1;
    deplacerCurseur(posCadre1);
    write(#186);
    end;
  couleurTexte(White);

  setLength(listeInterface, 2);
  listeInterface[0] := 'Personnage';
  listeInterface[1] := 'Inventaire';

  posCadre1.x := 9;
  posCadre1.y := posTemp.y + 3;
  afficherListeMenu(listeInterface, posCadre1, 5);

  posCadre1.x := 28;
  posCadre1.y := posTemp.y+1;
  deplacerCurseur(posCadre1);
end;

procedure afficheMenuPersonnage();
begin
  InterfaceInGame(position);
  writelnPerso('Pseudo : ' + persoChoose.pseudo);
  writelnPerso('Race : ' + GetEnumName(TypeInfo(race), Ord(persoChoose.race)));
  writelnPerso('PV : ' + IntToStr(persoChoose.pv) + ' / ' + IntToStr(persoChoose.pvMax));
  writelnPerso('Bourse : ' + IntToStr(persoChoose.argent) + ' Gold');
  writelnPerso();
  writelnPerso('Attaque : ' + IntToStr(persoChoose.attaque));
  writelnPerso('Defense : ' + IntToStr(persoChoose.defense));
  readlnPerso();
end;

procedure gestionMenu(var perso : Personnage; var inventairePerso : Inventaire; var indicateur : Integer; var nomEquipement : String);
begin
  if GetChoixMenu() = -1 then
    afficheMenuPersonnage()
  else if GetChoixMenu() = -2 then
    begin
      InterfaceInGame(position);
      afficheInventaire(inventairePerso);
      equipement(persoChoose,inventairePerso,indicateur,nomEquipement);
      readlnPerso();
    end;
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

//Efface l'écran et reconstitue le cadre
procedure redo();
var
  coorC,
  coorC2 : coordonnees;
  largeur,
  hauteur : Integer;
begin
  largeur := 200;
  hauteur := 60;
  coorC.x := 2;      //Coor 1
  coorC.y := 1;
  coorC2.x := largeur-3;     //Coor 2
  coorC2.y := hauteur-2;

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
      ecrireTexte(coordTemp, ListeTexte[i], 120);
      coordTemp.y := coordTemp.y + distanceEntreTexte;
      end;
end;

//Affiche une selection pour un menu (Pour l'esthetique du choix et pour savoir quel choix est selectionné)
function selectionMenu(coordMin : coordonnees; nbText, distanceEntreTexte, distanceDuFond, couleurFondTexte, couleurTexte : Integer) : Integer;
var
  coordTemp,
  coordMax : coordonnees;
  selectedChoice : Integer;
  Touche : TKeyEvent;
begin
  deplacerCurseur(CoordMin);
  coordTemp.x := coordMin.x;
  coordTemp.y := coordMin.y;
  ColorierZone(couleurFondTexte, couleurTexte, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
  coordMax.y := coordMin.y + (nbText-1)*distanceEntreTexte;
  coordMax.x := coordMin.x;
  repeat
    Touche := Key();
    if (KeyEventToString(Touche)='Up') then
       if coordTemp.y = coordMin.y then
          begin
          ColorierZone(0, 15, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
          coordTemp := coordMax;
          deplacerCurseur(coordTemp);
          ColorierZone(couleurFondTexte, couleurTexte, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
          end
       else
          begin
          ColorierZone(0, 15, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
          coordTemp.y := coordTemp.y-distanceEntreTexte;
          deplacerCurseur(coordTemp);
          ColorierZone(couleurFondTexte, couleurTexte, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
          end
    else if (KeyEventToString(Touche)='Down') then
       if coordTemp.y = coordMax.y then
          begin
          ColorierZone(0, 15, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
          coordTemp := coordMin;
          deplacerCurseur(coordTemp);
          ColorierZone(couleurFondTexte, couleurTexte, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
          end
       else
          begin
          ColorierZone(0, 15, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
          coordTemp.y := coordTemp.y+distanceEntreTexte;
          deplacerCurseur(coordTemp);
          ColorierZone(couleurFondTexte, couleurTexte, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
          end;

  until (KeyEventToString(Touche)=chr(13));
  selectedChoice := (coordTemp.y - CoordMin.y) div distanceEntreTexte;
  deplacerCurseur(coordMax);
  selectionMenu:=selectedChoice;
end;

//Affiche une selection pour un menu (Pour l'esthetique du choix et pour savoir quel choix est selectionné) et en plus affiche le menu du jeu (Quêtes, Inventaire ...) (suivant le même fonctionnement)
function selectionMenuEtInterface(coordMin : coordonnees; nbText, distanceEntreTexte, distanceDuFond, couleurFondTexte, couleurTexte : Integer) : Integer;
var
  coordTempInterface,
  coordMinInterface,
  coordMaxInterface,
  coordTemp,
  coordMax : coordonnees;
  menuSelectionne,
  selectedChoice : Integer;
  Touche : TKeyEvent;
begin
  deplacerCurseur(CoordMin);
  coordTemp.x := coordMin.x;
  coordTemp.y := coordMin.y;
  ColorierZone(couleurFondTexte, couleurTexte, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
  coordMax.y := coordMin.y + (nbText-1)*distanceEntreTexte;
  coordMax.x := coordMin.x;


  coordTempInterface.x := 7;
  coordTempInterface.y := 15;
  coordMinInterface := coordTempInterface;
  coordMaxInterface.x := coordTempInterface.x;
  coordMaxInterface.y := coordTempInterface.y + 5;
  menuSelectionne := 0;

  repeat
    Touche := Key();
    if (menuSelectionne = 1) then //On teste si le menu selectionné correspond au menu du jeu (Quêtes, Inventaire ...)
       begin
       if (KeyEventToString(Touche)=chr(9)) then //On teste si la touche pressée est tab
          begin
          ColorierZone(0, 15, coordTempInterface.x, coordTempInterface.x+13, coordTempInterface.y);
          menuSelectionne := 0;
          ColorierZone(couleurFondTexte, couleurTexte, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
          end
       else if (KeyEventToString(Touche)='Up') then //On teste si la touche pressée est la flêche du haut
         if coordTempInterface.y = coordMinInterface.y then
            begin
            ColorierZone(0, 15, coordTempInterface.x, coordTempInterface.x+13, coordTempInterface.y);
            coordTempInterface := coordMaxInterface;
            deplacerCurseur(coordTempInterface);
            ColorierZone(couleurFondTexte, couleurTexte, coordTempInterface.x, coordTempInterface.x+13, coordTempInterface.y);
            end
         else
            begin
            ColorierZone(0, 15, coordTempInterface.x, coordTempInterface.x+13, coordTempInterface.y);
            coordTempInterface.y := coordTempInterface.y-5;
            deplacerCurseur(coordTempInterface);
            ColorierZone(couleurFondTexte, couleurTexte, coordTempInterface.x, coordTempInterface.x+13, coordTempInterface.y);
            end
      else if (KeyEventToString(Touche)='Down') then //On teste si la touche pressée est la flêche du bas
         if coordTempInterface.y = coordMaxInterface.y then
            begin
            ColorierZone(0, 15, coordTempInterface.x, coordTempInterface.x+13, coordTempInterface.y);
            coordTempInterface := coordMinInterface;
            deplacerCurseur(coordTempInterface);
            ColorierZone(couleurFondTexte, couleurTexte, coordTempInterface.x, coordTempInterface.x+13, coordTempInterface.y);
            end
         else
            begin
            ColorierZone(0, 15, coordTempInterface.x, coordTempInterface.x+13, coordTempInterface.y);
            coordTempInterface.y := coordTempInterface.y+5;
            deplacerCurseur(coordTempInterface);
            ColorierZone(couleurFondTexte, couleurTexte, coordTempInterface.x, coordTempInterface.x+13, coordTempInterface.y);
            end;
       end
    else //Sinon on est dans le menu qu'on veut implémenter (donc pas du jeu)
    begin;
      if (KeyEventToString(Touche)=chr(9)) then //On teste si la touche pressée est tab
         begin
         ColorierZone(0, 15, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
         menuSelectionne := 1;
         ColorierZone(couleurFondTexte, couleurTexte, coordTempInterface.x, coordTempInterface.x+13, coordTempInterface.y);
         end
      else if (KeyEventToString(Touche)='Up') then //On teste si la touche pressée est la flêche du haut
         if coordTemp.y = coordMin.y then
            begin
            ColorierZone(0, 15, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
            coordTemp := coordMax;
            deplacerCurseur(coordTemp);
            ColorierZone(couleurFondTexte, couleurTexte, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
            end
         else
            begin
            ColorierZone(0, 15, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
            coordTemp.y := coordTemp.y-distanceEntreTexte;
            deplacerCurseur(coordTemp);
            ColorierZone(couleurFondTexte, couleurTexte, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
            end
      else if (KeyEventToString(Touche)='Down') then //On teste si la touche pressée est la flêche du bas
         if coordTemp.y = coordMax.y then
            begin
            ColorierZone(0, 15, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
            coordTemp := coordMin;
            deplacerCurseur(coordTemp);
            ColorierZone(couleurFondTexte, couleurTexte, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
            end
         else
            begin
            ColorierZone(0, 15, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
            coordTemp.y := coordTemp.y+distanceEntreTexte;
            deplacerCurseur(coordTemp);
            ColorierZone(couleurFondTexte, couleurTexte, coordTemp.x, coordTemp.x+distanceDuFond, coordTemp.y);
            end;
    end;

  until (KeyEventToString(Touche)=chr(13));

  if (menuSelectionne = 1) then
     selectedChoice := ((coordTempInterface.y - coordMinInterface.y) div 5)*(-1) - 1 //La fonction va renvoyer un nombre négatif si on selectionne le menu du jeu (Quêtes, Inventaire ...)
  else
     selectedChoice := (coordTemp.y - CoordMin.y) div distanceEntreTexte;  //La fonction va renvoyer un nombre positif ou nul si on selectionne le menu qu'on veut implémenter (donc pas du jeu)
  deplacerCurseur(coordMax);
  selectionMenuEtInterface:=selectedChoice;
end;



//Procédure pour écrire un texte sur une largeur donnée (justifié)
procedure ecrireTexte(posCoord : coordonnees; textToWrite : String; largeur : Integer);
var
  tempText : String;
  tempPosCoord : coordonnees;
begin
  tempPosCoord.y := posCoord.y - 1;
  tempPosCoord.x := posCoord.x;
  tempText := textToWrite;
  while length(tempText) > largeur do
    begin
    tempPosCoord.y := tempPosCoord.y + 1;
    ecrireEnPosition(tempPosCoord, copy(tempText, 0, largeur));
    tempText := copy(tempText, largeur+1, length(tempText)-largeur);
    end;
  if length(tempText) <> 0 then
     begin
     tempPosCoord.y := tempPosCoord.y + 1;
     ecrireEnPosition(tempPosCoord, tempText);
     end;
end;

//Fonction writeln mais saute d'abord une ligne et marche avec des coordonnées non fixe (juste pour sauter une ligne)
procedure writelnPerso();
begin
  deplacerCurseurXY(positionCurseur.x, positionCurseur.y+1);
end;
//Fonction writeln mais saute d'abord une ligne et marche avec des coordonnées non fixe
procedure writelnPerso(ligneAEcrire : String);
var
  posTemp : Integer; //Position en x du premier caractère de la ligne
begin
  posTemp := positionCurseur.x;
  deplacerCurseurXY(positionCurseur.x, positionCurseur.y+1);
  write(ligneAEcrire);
  deplacerCurseurXY(posTemp, positionCurseur.y);
end;
//Fonction readln qui marche avec des coordonnées non fixe (juste pour sauter une ligne)
procedure readlnPerso();
var
  posTemp : coordonnees;
begin
  posTemp := positionCurseur;
  deplacerCurseurXY(positionCurseur.x, positionCurseur.y+1);
  readln();
  deplacerCurseur(posTemp);
end;
//Fonction readln mais saute d'abord une ligne et marche avec des coordonnées non fixe (pour une chaine de caractères)
procedure readlnPerso(var ligneAEnregistrer : String);
var
  posTemp : Integer;
begin
  posTemp := positionCurseur.x;
  deplacerCurseurXY(positionCurseur.x, positionCurseur.y+1);
  readln(ligneAEnregistrer);
  deplacerCurseurXY(posTemp, positionCurseur.y);
end;
//Fonction readln mais saute d'abord une ligne et marche avec des coordonnées non fixe (pour un entier)
procedure readlnPerso(var ligneAEnregistrer : Integer);
var
  posTemp : Integer;
begin
  posTemp := positionCurseur.x;
  deplacerCurseurXY(positionCurseur.x, positionCurseur.y+1);
  readln(ligneAEnregistrer);
  deplacerCurseurXY(posTemp, positionCurseur.y);
end;

end.

