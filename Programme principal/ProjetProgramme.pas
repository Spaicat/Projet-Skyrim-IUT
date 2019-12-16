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

begin
  coorMenuTexte1.x := 10;
  coorMenuTexte1.y := 5;

  coorMenuTexte2.x := 50;
  coorMenuTexte2.y := 18 + 5;

  menuInitial();            //Creation du Menu Principal avec selection du personnage

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

  anciennePosition := lieu1;

  InterfaceInGame(position); //Creation de l'interface

  writelnPerso('En vous promenant devant la porte de Blancherive vous voyer un Garde mourrant');
  writelnPerso('En allant a sa rencontre vous remarquer d''etrange brulure sur le corp...');
  writelnPerso('Alors qu''il est au bord du malaise il vous dit :');               //Affichage du scenario
  writelnPerso('Ils arrivent....Les dragons.....');
  writelnPerso('Il vous tendit alors un parchemin scelle.. ');
  writelnPerso('Vous comprirent donc qu''ils faut le livrer au Jarl de Blancherive');
  writelnPerso();
  deplacement();


  while scenario = 1 do
    begin
    case position.nom of

    'Boutique' :
      begin
      redo();
      InterfaceInGame(position);
      writelnPerso('Que voulez-vous faire');
      writelnPerso();
      writelnPerso('1 Pour vendre');
      writelnPerso('2 pour acheter');
      writelnPerso('0 pour quitter');
      readlnPerso(nChoix);

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

    'Menu' :
      begin
      redo();
      InterfaceInGame(position);
      afficheInventaire(inventairePerso);
      equipement(persoChoose,inventairePerso,indicateur,nomEquipement);
      redo();
      position := anciennePosition;
      InterfaceInGame(position);
      end;

    'Porte de Blancherive' :
      begin
      writelnPerso();
      anciennePosition := position;
      InterfaceInGame(position);
      writelnPerso('Bienvenue devant la porte de Blancherive');
      writelnPerso('Sortir maintenant serai une perte de temps...');
      writelnPerso();
      writelnPerso('Ou voulez-vous aller ?');
      writelnPerso();
      deplacement();
      end;

    'Bourg de Blancherive' :
      begin
      writelnPerso();
      anciennePosition := position;
      InterfaceInGame(position);   //Creation de l'interface
      writelnPerso('Vous revoila a l''entre de Blancherive');
      writelnPerso('Vous devez donnez le message au jarl le plus vite possible');

      writelnPerso();
      writelnPerso('Ou voulez-vous aller ?');
      writelnPerso();
      deplacement();
      end;


    'Marche de Blancherive' :
      begin
      writelnPerso();
      anciennePosition := position;
      InterfaceInGame(position);
      writelnPerso('Bienvenue au marché de Blancherive');
      writelnPerso('Vous voila au grand marche de Blancherive');
      writelnPerso('D''ici vous pouvez vous le Chateau emblematique de Blancherive : Fort-Dragon');
      writelnPerso();
      writelnPerso('Ou voulez-vous aller ?');
      writelnPerso();
      deplacement();
      end;

    'Chateau de Blancherive' :
      begin
      writelnPerso();
      anciennePosition := position;
      InterfaceInGame(position);
      writelnPerso('Bienvenue au Chateux de Blancherive');
      writelnPerso('En arrivant a Fort-Dragon les garde vous arrête un instant et vous laisse passer a la vu du parchemin');
      writelnPerso('Vous donner le parchemin au jarl il vous dit alors panique a situation');
      couleurTexte(4);
      writelnPerso('LES DRAGONS SONT DE RETOUR');
      couleurTexte(15);
      writelnPerso('Vous vous proposez donc d''aller a la porte de la ville pour le retarder');
      scenario:= scenario+1;
      writelnPerso();
      writelnPerso('Ou voulez-vous aller ?');
      writelnPerso();
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
      writelnPerso('Que voulez-vous faire');
      writelnPerso();
      writelnPerso('1 Pour vendre');
      writelnPerso('2 pour acheter');
      writelnPerso('0 pour quitter');
      readlnPerso(nChoix);

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
      redo();
      position := anciennePosition;
      InterfaceInGame(position);
      end;


    'Porte de Blancherive' :
      begin
      writelnPerso();
      dragonFeu.pv := 70;
      dragonFeu.pvMax := 70;
      dragonFeu.attaque := 20;
      dragonFeu.pseudo := 'Dragon De Feu';
      dragonFeu.argent := 100;
      writelnPerso('Il est la !!!');
      writelnPerso('Le ' + dragonFeu.pseudo + ' vous attaque !');
      combat(persoChoose,dragonFeu,inventairePerso,fuite);
      effacerEcran();
      if fuite = False then
        begin
        writelnPerso('Vous avez accomplie l''impossible !!');
        writelnPerso('Le jarl vous a fait chevalier d''elite de Blancherive !!');
        couleurTexte(4);
        writelnPerso('CONGLATURATION');
        couleurTexte(15);
        readln();
        Halt(1);
        end
      else
        begin
        writelnPerso('Vous avez faillit a votre quete...');
        writelnPerso('La ville a ete detruite...');
        couleurTexte(4);
        writelnPerso('FIN');
        couleurTexte(15);
        readln();
        Halt(1);
        end;

      end;

    'Bourg de Blancherive' :
      begin
      writelnPerso();
      anciennePosition := position;
      InterfaceInGame(position);   //Creation de l'interface
      writelnPerso('Vers la porte de la ville vous entender un grand bruit...');
      couleurTexte(4);
      writelnPerso('La BETE EST ARRIVE !');
      couleurTexte(15);
      writelnPerso('Si vous y aller il n''y aura plus de retour en arriere...');
      writelnPerso();
      writelnPerso('Ou voulez-vous aller ?');
      writelnPerso();
      deplacement();
      end;


    'Marche de Blancherive' :
      begin
      writelnPerso();
      anciennePosition := position;
      InterfaceInGame(position);
      writelnPerso('Bienvenue au marché de Blancherive');
      writelnPerso('Vous voila au grand marche de Blancherive');
      writelnPerso('D''ici vous pouvez vous le Chateau emblematique de Blancherive : Fort-Dragon');
      writelnPerso();
      writelnPerso('Ou voulez-vous aller ?');
      writelnPerso();
      deplacement();
      end;

    'Chateau de Blancherive' :
      begin
      writelnPerso();
      anciennePosition := position;
      InterfaceInGame(position);
      writelnPerso('Diriger vous au plus vite au porte de la ville !');
      writelnPerso();
      writelnPerso('Ou voulez-vous aller ?');
      writelnPerso();
      deplacement();
      end;

    end;  // Fin du case
    end;  // Fin du while scenario = 2 




readln;
end.

