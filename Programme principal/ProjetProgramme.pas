program ProjetProgramme;

uses UnitMenu, UnitPersonnage, UnitMagasin, unitCombat, unitLieu, unitInventaire, unitDate, unitAuberge,
     GestionEcran, TypInfo, Keyboard, Classes, SysUtils, Windows;

var
  scenario : Integer; //Variable qui definiera ou le joueur en est dans l'histoire
  anciennePosition : TInformation;
  persoTemp,
  monstre : Personnage;
  fuite : Boolean;
  fin : Boolean;


  nChoix : Integer;

  o1,
  o2,
  o3 : Objet;
  inventairePerso : Inventaire;
  inventaireMagasin : Inventaire;
  indicateur : Integer; //Variable qui indique si le joueur a un objet equiper ou non
  nomEquipement : String;

  coorMenuTexte1 : coordonnees;

begin
  coorMenuTexte1.x := 10;
  coorMenuTexte1.y := 5;

  menuInitial();            //Creation du Menu Principal avec selection du personnage
  persoTemp := getPersonnage();

  initLieu();
  indicateur := 0;
  nomEquipement := '';
  fuite := False;
  fin := False;
  initObjet(o1,o2,o3);
  initInventaire(inventairePerso,o1,o2,o3);
  initInventaire(inventaireMagasin,o1,o2,o3);
  inventaireMagasin.possession[1]:=3;
  inventaireMagasin.possession[2]:=3;
  inventaireMagasin.possession[3]:=3;
  initDate();
  scenario := 1;

  anciennePosition := lieu1;

  InterfaceInGame(position); //Creation de l'interface

  writelnPerso('Vous etes un habitant de Blancherive, votre femme, Alnya, vit aupres de vous depuis plusieurs annees.');
  writelnPerso('Vous revenez de la chasse de la semaine. Un homme en fine armure se tient face a votre maison, tenant une hache couverte de sang');
  writelnPerso('Vous abandonnez toutes vos affaires sur le sol en voyant les cheveux d’Alnya noyes dans son sang aux pieds de l''homme. ');               //Affichage du scenario
  writelnPerso('Vous ne gardez que votre epee et courez pour vous jeter sur le meurtrier de votre bien aime.');
  writelnPerso('Vous tranchez le corps de l''ennemi qui s''averait etre un soldat sombrage, il meurt sur le coup sans avoir le temps de se retourner.  ');
  writelnPerso();
  writelnPerso(' Le melange de haine et de tristesse vous fait fondre en larme sur le corps sans vie de votre femme.');
  writelnPerso('Vous lui rendez hommage en immolant son corps et jetant ses cendres dans la riviere qu''elle adorait');
  writelnPerso('Vous gardez son talisman pres de votre coeur. ');
  writelnPerso();
  deplacement();


  while (fin = False) do
    begin
    case position.nom of

    'Auberge' :
    begin
    LancerAuberge(persoTemp);
    setPersonnage(persoTemp);
    setLieu(position, lieu1);
    end;

    'Boutique' :
    begin
      redo();
      InterfaceInGame(position);

      if not(getOuverture()) then
      begin
           writeln('LE MAGASIN EST FERME ! REVENEZ A 8H DEMAIN MATIN !');
           readln();
           effacerEcran();
      end
      else
      begin
        writelnPerso('Que voulez-vous faire');
        writelnPerso();
        writelnPerso('1 - Vendre');
        writelnPerso('2 - Acheter');
        writelnPerso('3 - Negocier');
        writelnPerso('0 - Quitter');
        repeat
          readlnPerso(nChoix);
        until ((nChoix>=0) and (nChoix<=3));

        case nChoix of
        0 :
          begin
          position := lieu1;
          effacerEcran();
          end;
        1 :
          begin
          vente(persoTemp,inventairePerso,inventaireMagasin);
          setPersonnage(persoTemp);
          effacerEcran();
          end;
        2 :
          begin
          achat(persoTemp,inventairePerso,inventaireMagasin);
          setPersonnage(persoTemp);
          effacerEcran();
          end;
        3 :
          begin
          negociation();
          effacerEcran();
          end;
        end;

      end;
      readlnPerso();
      deplacement();


    end;

    'Menu' :
      begin
      redo();
      gestionMenu(persoTemp,inventairePerso,indicateur,nomEquipement);
      setPersonnage(persoTemp);
      position := anciennePosition;
      InterfaceInGame(position);
      end;

    'Porte de Blancherive' :
      begin
      if scenario = 1 then
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
        end
      else if scenario = 2 then
        begin
        writelnPerso();
        anciennePosition := position;
        InterfaceInGame(position);
        writelnPerso('Vous patrouillez autour de la ville pres de la foret.');
        writelnPerso('Un bruit retentit de derriere les fourres, vous decidez de vous approcher mais un coup violent vous ejecte en arriere,');
        writelnPerso('vous tombez au sol. Vous reconnaissez un geant qui s''approche de vous. ');
        writelnPerso('Vous ne pouvez-vous defendre et êtes voues a mourir.');
        writelnPerso('Lorsque le geant s''apprete à vous tuer, un bruit d''aile se fait entendre a votre gauche.');
        writelnPerso();

        writelnPerso();
        writelnPerso('Ou voulez-vous aller ?');
        writelnPerso();
        deplacement();
        end
      else if scenario = 3 then
        begin
        writelnPerso('Il est la !!!');
        writelnPerso('Le ' + monstre.pseudo + ' vous attaque !');
        combat(persoTemp,monstre,inventairePerso,fuite);
        setPersonnage(persoTemp);
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
      end;

    'Bourg de Blancherive' :
      begin
      if scenario = 1 then
        begin
        redo();
        writelnPerso();
        anciennePosition := position;
        InterfaceInGame(position);   //Creation de l'interface
        writelnPerso('Souhaitant vous debarrassez du corps sans vie de l''ennemi Sombrage,');
        writelnPerso('vous decouvrez un plan stratégique expliquant le déroulement d''une prochaine attaque de Blancherive. ');
        writelnPerso('Vous devez vous présentez au Jarl situe dans le chateau de la ville pour lui remettre ce plan. ');
        writelnPerso();
        writelnPerso('Ou voulez-vous aller ?');
        writelnPerso();
        deplacement();
        end
      else if scenario = 2 then
        begin
        redo();
        writelnPerso();
        anciennePosition := position;
        writelnPerso('Vous voila en charge de la patrouille officiel de Blancherive');
        writelnPerso('Votre patrouille a lieu pres de la porte de la ville');
        writelnPerso();
        writelnPerso('Ou voulez-vous aller ?');
        writelnPerso();
        deplacement();
        end;
      end;


    'Marche de Blancherive' :
      begin
      writelnPerso();
      anciennePosition := position;
      InterfaceInGame(position);

      writelnPerso('Vous voila au grand marche de Blancherive');
      writelnPerso('D''ici vous pouvez vous le Chateau emblematique de Blancherive : Fort-Dragon');
      writelnPerso();
      writelnPerso('Ou voulez-vous aller ?');
      writelnPerso();
      if not getOuverture() then
      begin
           writelnPerso('Un Ivrogne vous attaque !!');
           monstre:=Ivrogne();
           combat(persoTemp,monstre,inventairePerso,fuite);
           setPersonnage(persoTemp);
      end;
      deplacement();
      waitUneHeure();
      end;

    'Chateau de Blancherive' :
      begin
      if scenario = 1 then
        begin
        writelnPerso();
        anciennePosition := position;
        InterfaceInGame(position);
        scenario:= scenario+1;
        writelnPerso('Vous vous approchez du Jarl et vous agenouillez devant lui.');
        writelnPerso('"Je me presente à vous pour vous remettre un plan decouvert sur le corps d''un Sombrage. Celui-ci vise à attaquer notre ville. "');
        writelnPerso('Le Jarl récupère le plan entre vos mains et l''observe quelques secondes. ');
        writelnPerso('" Relevez-vous. Je vous remercie infiniment pour votre aide et votre fidelité à notre peuple. ');
        writelnPerso('Ce plan nous permettra de proteger la ville efficacement lors de cette attaque, et de riposter en retour.');
        writelnPerso('"Je souhaiterai que vous fassiez parti de mon armee. Vous serez assigne au titre de patrouilleur si vous acceptez, vous aurez de belles recompenses."');
        writelnPerso('Vous etes maintenant assigne à l’armee Imperiale. Vous devez à present patrouiller en dehors de la ville.');
        writelnPerso();
        writelnPerso('Ou voulez-vous aller ?');
        writelnPerso();
        deplacement();
        end
      else if scenario = 2 then
        begin
        writelnPerso();
        anciennePosition := position;
        InterfaceInGame(position);
        writelnPerso('Vous etes maintenant de patrouille devant la porte de la ville');
        writelnPerso('Vous feriz mieux d''y aller');
        writelnPerso();
        writelnPerso('Ou voulez-vous aller ?');
        writelnPerso();
        deplacement();
        end;
      end;
    'Clan Drakion':
      begin
      redo();
      writelnPerso('Vous n''avez aucune raison d''y aller maintenant');
      writelnPerso();
      writelnPerso('Ou voulez-vous aller ?');
      writelnPerso();
      deplacement();
      end;
    end;  // Fin du case

  end;  // Fin du while

readln;
end.

