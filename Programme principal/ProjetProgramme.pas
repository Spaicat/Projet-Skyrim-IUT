program ProjetProgramme;

uses UnitMenu, UnitPersonnage, UnitMagasin, unitCombat, unitLieu, unitInventaire,
     GestionEcran, TypInfo, Keyboard, Classes, SysUtils, Windows;

var
  i : Integer;
  scenario : Integer; //Varaible qui definiera ou le joueur en est dans l'histoire
  anciennePosition : TInformation;
  dragonFeu : Personnage;
  fuite : Boolean;


  nChoix : Integer;

  o1,
  o2,
  o3 : Objet;
  inventairePerso : Inventaire;
  inventaireMagasin : Inventaire;
  indicateur : Integer; //Vraiable qui indique si le joueur a un objet equiper ou non
  nomEquipement : String;

  coorMenuTexte1 : coordonnees;
  coorMenuTexte2 : coordonnees;

  stdOutputHandle : Cardinal;
  Buffer : CONSOLE_SCREEN_BUFFER_INFO;
  LastMode: Word;
  cursorPos: TCoord;
  TextAttr: Byte;
  nbChars: Cardinal;

begin
  coorMenuTexte1.x := 50;
  coorMenuTexte1.y := 18 - 5;

  coorMenuTexte2.x := 50;
  coorMenuTexte2.y := 18 + 5;

  writeln('Bonjour, ceci est un test pour tester');
  writeln('Ne faites pas attention à moi');
  writeln();

  readln;

  menuInitial();            //Creation du Menu Principal avec selection du personnage
  
  anciennePosition := lieu1;
  initLieu();
  indicateur := 0;
  nomEquipement := '';
  initObjet(o1,o2,o3);
  initInventaire(inventairePerso,o1,o2,o3);
  initInventaire(inventaireMagasin,o1,o2,o3);
  inventaireMagasin.possession[1]:=3;
  inventaireMagasin.possession[2]:=3;
  inventaireMagasin.possession[3]:=3;
  scenario := 1;

  InterfaceInGame(position); //Creation de l'interface
  writeln();
  writeln('En vous promenant devant la porte de Blancherive vous voyer un Garde mourrant');
  writeln('En allant a sa rencontre vous remarquer d''etrange brulure sur le corp...');
  writeln('Alors qu''il est au bord du malaise il vous dit :');               //Affichage du scenario
  writeln('Ils arrivent....Les dragons.....');
  writeln('Il vous tendit alors un parchemin scelle.. ');
  writeln('Vous comprirent donc qu''ils faut le livrer au Jarl de Blancherive');
  writeln();
  deplacement();


  while scenario = 1 do
    begin
    case position.nom of

    'Boutique' :
      begin
      effacerEcran();
      InterfaceInGame(position);
      writeln('Que voulez-vous faire');
      writeln();
      writeln('1 Pour vendre');
      writeln('2 pour acheter');
      writeln('0 pour quitter');
      readln(nChoix);

      case nChoix of
      0 :
        begin
        position := lieu1;
        effacerEcran();
        end;
      1 :
        begin
        vente(persoChoose,inventairePerso,inventaireMagasin);
        effacerEcran();
        end;
      2 :
        begin
        achat(persoChoose,inventairePerso,inventaireMagasin);
        effacerEcran();
        end;

      end;
      end;

    'Inventaire' :
      begin
      afficheInventaire(inventairePerso);
      equipement(persoChoose,inventairePerso,indicateur,nomEquipement);
      effacerEcran();
      deplacement();
      end;

    'Porte de Blancherive' :
      begin
      writeln();
      anciennePosition.nom := 'Porte de Blancherive';
      InterfaceInGame(position);
      writeln('Bienvenue devant la porte de Blancherive');
      writeln('Sortir maintenant serai une perte de temps...');
      writeln();
      writeln('Ou voulez-vous aller ?');
      writeln();
      deplacement();
      end;

    'Bourg de Blancherive' :
      begin
      writeln();
      anciennePosition.nom := 'Bourg de Blancherive';
      InterfaceInGame(position);   //Creation de l'interface
      writeln('Vous revoila a l''entre de Blancherive');
      writeln('Vous devez donnez le message au jarl le plus vite possible');

      writeln();
      writeln('Ou voulez-vous aller ?');
      writeln();
      deplacement();
      end;


    'Marche de Blancherive' :
      begin
      writeln();
      anciennePosition.nom := 'Marche de Blancherive';
      InterfaceInGame(position);
      writeln('Bienvenue au marché de Blancherive');
      writeln('Vous voila au grand marche de Blancherive');
      writeln('D''ici vous pouvez vous le Chateau emblematique de Blancherive : Fort-Dragon');
      writeln();
      writeln('Ou voulez-vous aller ?');
      writeln();
      deplacement();
      end;

    'Chateau de Blancherive' :
      begin
      writeln();
      anciennePosition.nom := 'Chateau de Blancherive';
      InterfaceInGame(position);
      writeln('Bienvenue au Chateux de Blancherive');
      writeln('En arrivant a Fort-Dragon les garde vous arrête un instant et vous laisse passer a la vu du parchemin');
      writeln('Vous donner le parchemin au jarl il vous dit alors panique a situation');
      couleurTexte(4);
      writeln('LES DRAGONS SONT DE RETOUR');
      couleurTexte(15);
      writeln('Vous vous proposez donc d''aller a la porte de la ville pour le retarder');
      scenario:= scenario+1;
      writeln();
      writeln('Ou voulez-vous aller ?');
      writeln();
      deplacement();
      end;

    end;  // Fin du case
    end;  // Fin du while scenario = 1

  while scenario = 2 do
    begin
    case position.nom of

    'Boutique' :
      begin
      InterfaceInGame(position);
      writeln('Que voulez-vous faire');
      writeln();
      writeln('1 Pour vendre');
      writeln('2 pour acheter');
      writeln('0 pour quitter');
      readln(nChoix);

      case nChoix of
      0 : position := lieu1;

      1 :
      begin
      vente(persoChoose,inventairePerso,inventaireMagasin);
      effacerEcran();
      end;
      2 :
      begin
      achat(persoChoose,inventairePerso,inventaireMagasin);
      effacerEcran();
      end;

      end;
      end;

    'Inventaire' :
      begin
      afficheInventaire(inventairePerso);
      equipement(persoChoose,inventairePerso,indicateur,nomEquipement);
      readln;
      effacerEcran();
      position := anciennePosition;
      deplacement();
      end;


    'Porte de Blancherive' :
      begin
      writeln();
      dragonFeu.pv := 70;
      dragonFeu.pvMax := 70;
      dragonFeu.attaque := 20;
      dragonFeu.pseudo := 'Dragon De Feu';
      dragonFeu.argent := 100;
      writeln('Il est la !!!');
      writeln('Le ',dragonFeu.pseudo,' vous attaque !');
      combat(persoChoose,dragonFeu,inventairePerso,fuite);
      effacerEcran();
      if fuite = False then
        begin
        writeln('Vous avez accomplie l''impossible !!');
        writeln('Le jarl vous a fait chevalier d''elite de Blancherive !!');
        couleurTexte(4);
        writeln('CONGLATURATION');
        couleurTexte(15);
        readln();
        Halt(1);
        end
      else
        begin
        writeln('Vous avez faillit a votre quete...');
        writeln('La ville a ete detruite...');
        couleurTexte(4);
        writeln('FIN');
        couleurTexte(15);
        readln();
        Halt(1);
        end;

      end;

    'Bourg de Blancherive' :
      begin
      writeln();
      anciennePosition.nom := 'Bourg de Blancherive';
      InterfaceInGame(position);   //Creation de l'interface
      writeln('Vers la porte de la ville vous entender un grand bruit...');
      couleurTexte(4);
      writeln('La BETE EST ARRIVE !');
      couleurTexte(15);
      writeln('Si vous y aller il n''y aura plus de retour en arriere...');
      writeln();
      writeln('Ou voulez-vous aller ?');
      writeln();
      deplacement();
      end;


    'Marche de Blancherive' :
      begin
      writeln();
      anciennePosition.nom := 'Marche de Blancherive';
      InterfaceInGame(position);
      writeln('Bienvenue au marché de Blancherive');
      writeln('Vous voila au grand marche de Blancherive');
      writeln('D''ici vous pouvez vous le Chateau emblematique de Blancherive : Fort-Dragon');
      writeln();
      writeln('Ou voulez-vous aller ?');
      writeln();
      deplacement();
      end;

    'Chateau de Blancherive' :
      begin
      writeln();
      anciennePosition.nom := 'Chateau de Blancherive';
      InterfaceInGame(position);
      writeln('Diriger vous au plus vite au porte de la ville !');
      writeln();
      writeln('Ou voulez-vous aller ?');
      writeln();
      deplacement();
      end;

    end;  // Fin du case
    end;  // Fin du while scenario = 2 




readln;
end.

