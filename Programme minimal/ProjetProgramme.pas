program ProjetProgramme;

uses UnitMenu, UnitPersonnage, UnitMagasin, unitCombat, GestionEcran, unitLieu,unitInventaire;

var
  position : TInformation;    //Variable qui stokera la position du personnage dans le jeu
  i : Integer;
  scenario : Integer; //Varaible qui definiera ou le joueur en est dans l'histoire

  dragonFeu : Personnage;
  fuite : Boolean;

  anciennePosition : TInformation;

   o1,
  o2,
  o3 : Objet;
  inventairePerso : Inventaire;
  inventaireMagasin : Inventaire;
  indicateur : Integer; //Vraiable qui indique si le joueur a un objet equiper ou non
  nomEquipement : String;


//until (position.nom = Blancherive) OR (position.nom = Marche_De_Blancherive) OR (position.nom = Porte_De_Blancherive) OR (position.nom = Chateau_De_Blancherive);

begin
  changerTailleConsole(200,60);
  fuite := False;
  menuInitial();   //Creation du Menu Principal avec selection du personnage
  position.nom := Blancherive;
  anciennePosition.nom := position.nom;
  indicateur := 0;
  nomEquipement := '';
  InterfaceInGame(position);        //Creation de l'interface
  initObjet(o1,o2,o3);
  initInventaire(inventairePerso,o1,o2,o3);
  initInventaire(inventaireMagasin,o1,o2,o3);
  inventaireMagasin.possession[1]:=3;
  inventaireMagasin.possession[2]:=3;
  inventaireMagasin.possession[3]:=3;
  scenario := 1;
  writeln();
  writeln('En vous promenant devant la porte de Blancherive vous voyer un Garde mourrant');
  writeln('En allant a sa rencontre vous remarquer d''etrange brulure sur le corp...');
  writeln('Alors qu''il est au bord du malaise il vous dit :');               //Affichage du scenario
  writeln('Ils arrivent....Les dragons.....');
  writeln('Il vous tendit alors un parchemin scelle.. ');
  writeln('Vous comprirent donc qu''ils faut le livrer au Jarl de Blancherive');
  writeln();
  writeln('Ou voulez-vous aller ?');
  writeln();
  couleurTexte(4);
  writeln('Vous pouvez regarder a tous moment votre inventaire avec la commande : AccesInventaire');
  couleurTexte(15);
  writeln();

  initLieu(position);
  writeln();

  repeat
    readln(position.nom);
  until (position.nom = Marche_De_Blancherive) OR (position.nom = Porte_De_Blancherive) OR (position.nom = Boutique) OR (position.nom = AccesInventaire);
  effacerEcran();

  while scenario = 1 do
    begin
    case position.nom of

    Boutique :
      begin
      InterfaceInGame(position);
      achat(persoChoose,inventairePerso,inventaireMagasin);
      writeln();
      effacerEcran();
      position.nom := Blancherive;
      end;

    AccesInventaire :
      begin
      afficheInventaire(inventairePerso);
      equipement(persoChoose,inventairePerso,indicateur,nomEquipement);
      readln;
      effacerEcran();
      position.nom := anciennePosition.nom;
      end;

    Porte_De_Blancherive :
      begin
      writeln();
      anciennePosition.nom := position.nom;
      InterfaceInGame(position);
      writeln('Bienvenue devant la porte de Blancherive');
      writeln('Sortir maintenant serai une perte de temps...');
      writeln();
      writeln('Ou voulez-vous aller ?');
      writeln();

      initLieu(position);
      writeln();
      repeat
        readln(position.nom);
      until (position.nom = Blancherive) OR (position.nom = AccesInventaire);
      effacerEcran();
      end;

    Blancherive :
      begin
      writeln();
      anciennePosition.nom := position.nom;
      InterfaceInGame(position);   //Creation de l'interface
      writeln('Vous revoila a l''entre de Blancherive');
      writeln('Vous devez donnez le message au jarl le plus vite possible');

      writeln();
      writeln('Ou voulez-vous aller ?');
      writeln();

      initLieu(position);
      writeln();

      repeat
        readln(position.nom);
      until (position.nom = Marche_De_Blancherive) OR (position.nom = Porte_De_Blancherive) OR (position.nom = Boutique) OR (position.nom = AccesInventaire);
      effacerEcran();
      end;


    Marche_De_Blancherive :
      begin
      writeln();
      anciennePosition.nom := position.nom;
      InterfaceInGame(position);
      writeln('Bienvenue au marché de Blancherive');
      writeln('Vous voila au grand marche de Blancherive');
      writeln('D''ici vous pouvez vous le Chateau emblematique de Blancherive : Fort-Dragon');
      writeln();
      writeln('Ou voulez-vous aller ?');
      writeln();

      initLieu(position);
      writeln();
      repeat
        readln(position.nom);
      until (position.nom = Blancherive) OR (position.nom = Chateau_De_Blancherive) OR (position.nom = AccesInventaire);
      effacerEcran();
      end;

    Chateau_De_Blancherive :
      begin
      writeln();
      anciennePosition.nom := position.nom;
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

      initLieu(position);
      writeln();

      repeat
        readln(position.nom);
      until (position.nom = Marche_De_Blancherive) OR (position.nom = AccesInventaire);
      effacerEcran();
      end;

    end;  // Fin du case
    end;  // Fin du while scenario = 1

  while scenario = 2 do
    begin
    case position.nom of

    Boutique :
      begin
      InterfaceInGame(position);
      achat(persoChoose,inventairePerso,inventaireMagasin);
      writeln();
      effacerEcran();
      position.nom := Blancherive;
      end;

    AccesInventaire :
      begin
      afficheInventaire(inventairePerso);
      equipement(persoChoose,inventairePerso,indicateur,nomEquipement);
      readln;
      effacerEcran();
      position.nom := anciennePosition.nom;
      end;


    Porte_De_Blancherive :
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

    Blancherive :
      begin
      writeln();
      anciennePosition.nom := position.nom;
      InterfaceInGame(position);   //Creation de l'interface
      writeln('Vers la porte de la ville vous entender un grand bruit...');
      couleurTexte(4);
      writeln('La BETE EST ARRIVE !');
      couleurTexte(15);
      writeln('Si vous y aller il n''y aura plus de retour en arriere...');
      writeln();
      writeln('Ou voulez-vous aller ?');
      writeln();

      initLieu(position);
      writeln();

      repeat
        readln(position.nom);
      until (position.nom = Marche_De_Blancherive) OR (position.nom = Porte_De_Blancherive) OR (position.nom = Boutique) OR (position.nom = AccesInventaire);
      effacerEcran();
      end;


    Marche_De_Blancherive :
      begin
      writeln();
      anciennePosition.nom := position.nom;
      InterfaceInGame(position);
      writeln('Bienvenue au marché de Blancherive');
      writeln('Vous voila au grand marche de Blancherive');
      writeln('D''ici vous pouvez vous le Chateau emblematique de Blancherive : Fort-Dragon');
      writeln();
      writeln('Ou voulez-vous aller ?');
      writeln();

      initLieu(position);
      writeln();
      repeat
        readln(position.nom);
      until (position.nom = Blancherive) OR (position.nom = Chateau_De_Blancherive) OR (position.nom = AccesInventaire);
      effacerEcran();
      end;

    Chateau_De_Blancherive :
      begin
      writeln();
      anciennePosition.nom := position.nom;
      InterfaceInGame(position);
      writeln('Diriger vous au plus vite au porte de la ville !');
      writeln();
      writeln('Ou voulez-vous aller ?');
      writeln();

      initLieu(position);
      writeln();

      repeat
        readln(position.nom);
      until (position.nom = Marche_De_Blancherive) OR (position.nom = AccesInventaire);
      effacerEcran();
      end;

    end;  // Fin du case
    end;  // Fin du while scenario = 2




readln;
end.

