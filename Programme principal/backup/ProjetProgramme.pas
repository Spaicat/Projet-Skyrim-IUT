program ProjetProgramme;

{$codepage utf8}

uses UnitMenu, UnitPersonnage, UnitMagasin, unitCombat, unitLieu, unitInventaire, unitDate, unitAuberge,unitbenediction,
     GestionEcran, TypInfo, Keyboard, Classes, SysUtils, Windows;

var
  scenario : Integer; //Variable qui definiera ou le joueur en est dans l'histoire
  anciennePosition,
  posTemp : TInformation;
  persoTemp,
  monstre : Personnage;
  fuite : Boolean;
  fin : Boolean;
  lieuBourg : TInformation;

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

  anciennePosition := getLieu1();

  InterfaceInGame(); //Creation de l'interface

  writelnPerso('Vous êtes un habitant de Blancherive, votre femme, Alnya, vit auprès de vous depuis plusieurs années.');
  writelnPerso('Vous revenez de la chasse de la semaine. Un homme en fine armure se tient face à votre maison, tenant une hache couverte de sang');
  writelnPerso('Vous abandonnez toutes vos affaires sur le sol en voyant les cheveux d’Alnya noyés dans son sang aux pieds de l''homme. ');               //Affichage du scenario
  writelnPerso('Vous ne gardez que votre épée et courez pour vous jeter sur le meurtrier de votre bien aimé.');
  writelnPerso('Vous tranchez le corps de l''ennemi qui s''avérait être un soldat sombrage, il meurt sur le coup sans avoir le temps de se retourner.  ');
  writelnPerso();
  writelnPerso(' Le mélange de haine et de tristesse vous fait fondre en larme sur le corps sans vie de votre femme.');
  writelnPerso('Vous lui rendez hommage en immolant son corps et jetant ses cendres dans la riviere qu''elle adorait');
  writelnPerso('Vous gardez son talisman près de votre coeur. ');
  writelnPerso();
  deplacement();


  while (fin = False) do
    begin
    posTemp := getPosition();
    case posTemp.nom of

    'Auberge' :
    begin
    LancerAuberge(persoTemp);
    setPersonnage(persoTemp);
    lieuBourg := getLieu1();
    posTemp := getPosition();
    setLieu(posTemp, lieuBourg);
    setPosition(posTemp);
    end;

    'Boutique' :
    begin

      InterfaceInGame();

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
          setPosition(getLieu1());
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
      InterfaceInGame();
      deplacement();


    end;

    'Menu' :
      begin
      redo();
      gestionMenu(persoTemp,inventairePerso,indicateur,nomEquipement);
      setPersonnage(persoTemp);
      setPosition(anciennePosition);
      InterfaceInGame();
      end;

    'Porte de Blancherive' :
      begin
      if scenario = 1 then
        begin
        writelnPerso();
        anciennePosition := getPosition();
        InterfaceInGame();
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
        anciennePosition := getPosition();
        InterfaceInGame();
        scenario := scenario + 1;
        writelnPerso('Vous patrouillez autour de la ville pres de la foret.');
        writelnPerso('Un bruit retentit de derrière les fourrés, vous décidez de vous approcher mais un coup violent vous éjecte en arrière,');
        writelnPerso('vous tombez au sol. Vous reconnaissez un géant qui s''approche de vous. ');
        writelnPerso('Vous ne pouvez-vous défendre et êtes voués a mourir.');
        writelnPerso('Lorsque le géant s''apprète à vous tuer, un bruit d''aile se fait entendre à votre gauche.');
        writelnPerso('Vous n''avez pas le temps de vous retourner que le géant se fait repousser en arrière et immoler par de puissantes flammes.');
        writelnPerso('En levant les yeux vous pouvez observer un grand dragon se tenir devant vous, il vous observe quelques secondes');
        writelnPerso('Vous devez vous rendre au château pour faire votre rapport au Jarl.');
        writelnPerso(' avant de s''élancer dans les airs et disparaître dans la brume au-dessus des arbres.');

        writelnPerso();
        writelnPerso('Ou voulez-vous aller ?');
        writelnPerso();
        deplacement();
        end
      else if scenario = 3 then
        begin
        writelnPerso();
        anciennePosition := getPosition();
        InterfaceInGame();
        writelnPerso('Vous devez faire votre rapport au Jarl !');

        writelnPerso();
        writelnPerso('Ou voulez-vous aller ?');
        writelnPerso();
        deplacement();
        end
      else
        begin
        writelnPerso();
        anciennePosition := getPosition();
        InterfaceInGame();
        writelnPerso('Vous êtes un déserteur vous n''avez plus de raison de revenir ici...');

        writelnPerso();
        writelnPerso('Ou voulez-vous aller ?');
        writelnPerso();
        deplacement();
        end;
      end;

    'Bourg de Blancherive' :
      begin
      if scenario = 1 then
        begin
        redo();
        writelnPerso();
        anciennePosition := getPosition();
        InterfaceInGame();   //Creation de l'interface
        writelnPerso('Souhaitant vous débarrassez du corps sans vie de l''ennemi Sombrage,');
        writelnPerso('vous découvrez un plan stratégique expliquant le déroulement d''une prochaine attaque de Blancherive. ');
        writelnPerso('Vous devez vous présentez au Jarl situe dans le château de la ville pour lui remettre ce plan. ');
        writelnPerso();
        writelnPerso('Ou voulez-vous aller ?');
        writelnPerso();
        deplacement();
        end
      else if (scenario = 2) OR (scenario = 3) then
        begin
        writelnPerso();
        anciennePosition := getPosition();
        InterfaceInGame();
        writelnPerso('Vous voila en charge de la patrouille officiel de Blancherive');
        writelnPerso('Votre patrouille a lieu près de la porte de la ville');
        writelnPerso();
        writelnPerso('Ou voulez-vous aller ?');
        writelnPerso();
        deplacement();
        end
      else
        begin
        writelnPerso();
        anciennePosition := getPosition();
        InterfaceInGame();
        writelnPerso('Vous êtes un déserteur vous n''avez plus de raison de revenir ici...');

        writelnPerso();
        writelnPerso('Ou voulez-vous aller ?');
        writelnPerso();
        deplacement();
        end;
      end;


    'Marche de Blancherive' :
      begin
      writelnPerso();
      anciennePosition := getPosition();
      InterfaceInGame();

      writelnPerso('Vous voila au grand marché de Blancherive');
      writelnPerso('D''ici vous pouvez voir le Chateau emblématique de Blancherive : Fort-Dragon');
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
        anciennePosition := getPosition();
        InterfaceInGame();
        scenario:= scenario+1;
        writelnPerso('Vous vous approchez du Jarl et vous agenouillez devant lui.');
        writelnPerso('"Je me présente à vous pour vous remettre un plan découvert sur le corps d''un Sombrage. Celui-ci vise à attaquer notre ville. "');
        writelnPerso('Le Jarl récupère le plan entre vos mains et l''observe quelques secondes. ');
        writelnPerso('" Relevez-vous. Je vous remercie infiniment pour votre aide et votre fidelite à notre peuple. ');
        writelnPerso('Ce plan nous permettra de protéger la ville efficacement lors de cette attaque, et de riposter en retour.');
        writelnPerso('"Je souhaiterai que vous fassiez parti de mon armée. Vous serez assigné au titre de patrouilleur si vous acceptez, vous aurez de belles récompenses."');
        writelnPerso('Vous êtes maintenant assigné à l’armée Imperiale. Vous devez à présent patrouiller en dehors de la ville.');
        writelnPerso();
        writelnPerso('Ou voulez-vous aller ?');
        writelnPerso();
        deplacement();
        end
      else if scenario = 2 then
        begin
        writelnPerso();
        anciennePosition := getPosition();
        InterfaceInGame();
        writelnPerso('Vous êtes maintenant de patrouille devant la porte de la ville');
        writelnPerso('Vous feriez mieux d''y aller');
        writelnPerso();
        writelnPerso('Ou voulez-vous aller ?');
        writelnPerso();
        deplacement();
        end
      else if scenario = 3 then
        begin
        writelnPerso();
        anciennePosition := getPosition();
        InterfaceInGame();
        scenario := scenario +1;
        writelnPerso('Vous approchez du Jarl et lui faites votre rapport. Celui-ci décide de lancer une chasse contre le dragon.');
        writelnPerso('Vous refusez d''obéir à ses ordres et tentez de le convaincre, il vous menace de mise à mort mais vous décidez de partir tout de même.');
        writelnPerso('Vous êtes a présent deserteur de la Légion Impériale, vous devez impérativement sortir de la ville pour échapper aux gardes,');
        writelnPerso(' l''extérieur de celle-ci aura peut-être de quoi vous accueillir ...');

        writelnPerso();
        writelnPerso('Ou voulez-vous aller ?');
        writelnPerso();
        deplacement();
        end
       else
         begin
         writelnPerso();
         anciennePosition := getPosition();
         InterfaceInGame();
         writelnPerso('Vous êtes un déserteur vous n''avez plus de raison de revenir ici...');

         writelnPerso();
         writelnPerso('Ou voulez-vous aller ?');
         writelnPerso();
         deplacement();
         end;
      end;
    'Clan Drakion':
      begin
      if scenario <> 4 then
        begin
        writelnPerso();
        anciennePosition := getPosition();
        InterfaceInGame();
        writelnPerso('Vous n''avez aucune raison d''y aller maintenant');
        writelnPerso();
        writelnPerso('Ou voulez-vous aller ?');
        writelnPerso();
        deplacement();
        end
      else
        begin
        writelnPerso();
        anciennePosition := getPosition();
        InterfaceInGame();

        writelnPerso('Les membres du clan preparent votre rituel d’initiation, vous vous placez au centre des runes nordiques dessiner au sol. ');
        writelnPerso('Ils entreprennent un chant dans la langue draconienne.');
        writelnPerso('Etonnamment vous décrypter les paroles de celui-ci. ');
        writelnPerso('Lors du chant terminé, l''esprit d’Alduin et Orya apparaissent face à vous');
        writelnPerso('Vous les observez en silence avant qu’ils prennent la parole. ');
        writelnPerso();
        writelnPerso('Alduin : nous attendions ce moment avec impatience, Orya et moi ');
        writelnPerso('Tu ne comprends encore ce que je veux dire mais nous allons t’expliquer.');
        writelnPerso('Tu n’es réellement pas originaire de ce monde, tu es notre création, a Orya et moi.');
        writelnPerso();
        writelnPerso('Orya : : Je sais que ce que nous sommes en train de te dire parait iréel, mais tu es notre enfant, l''élu du clan Drakion');
        writelnPerso('Tu dois a présent assumer tes responsabilités, et suivre notre voie');
        writelnPerso('Je t''en prie, accepte-nous en tant que compagnon, nous serons à tes cotés pendant la destruction de ce monde.');
        readlnPerso();
        InterfaceInGame();
        writelnPerso();
        writelnPerso('Vous restez interloque jusqu''à entendre le mot ‘déstruction’.');
        writelnPerso('Ils vous expliquent alors que vous êtes voué à assouvir leur desir de déstruction');
        writelnPerso('déstruction mais vous refusez de les servir pour détruire ce monde où vous avez grandi. ');
        writelnPerso();
        writelnPerso('Alduin : Comment oses-tu refuser de servir tes créateurs ?');
        writelnPerso();
        writelnPerso('Alduin s''apprète à vous faire disparaître de ce monde lorsque Orya l’arrête. ');
        writelnPerso('Elle l’empèche de vous tuer et vous regarde, vous demandant des explications');
        writelnPerso();
        writelnPerso('J''ai grandi sur ce monde, il est si beau si l’on retire les guerres qui ravage les pays.');
        writelnPerso('J''ai vécu auprès de ma compagne, décédée, sur ce monde.');
        writelnPerso('Je ne veux pas le voir disparaître. J''ai prier les Dieux qui vous ont créée et je vous prie ,à votre tour,');
        writelnPerso('d’apprendre a voir la beauté de ces terres et acceptez, à mes cotés, de vaincre le mal qui ronge celles-ci.');
        writelnPerso('Apprenez le pardon auprès de nos Dieux et accompagnez-moi.');
        readlnPerso();
        InterfaceInGame();

        writelnPerso('Orya vous regarde avant de fixer ses yeux sur Alduin, qui observe les alentours. ');
        writelnPerso('Il transforme son esprit sous forme humaine avant de venir poser sa main sur votre visage');
        writelnPerso('Il s’excuse d’avoir laisser la haine, et la rage, avoir pris le dessus sur lui avant de regarder vos yeux');
        writelnPerso();
        writelnPerso('Alduin : Si tu tiens tant a ce monde, alors j''accepte de t''accompagner dans cette quête, mon fils.');
        writelnPerso('Nous te suivrons et t''offrirons notre force lors de tes combats. Nous serons toujours aupres de toi, ne l''oublie pas.');
        readlnPerso();
        InterfaceInGame();

        writelnPerso('L''esprit d’Alduin et Orya quitte ce monde afin de partir demander le pardon des Dieux.');
        writelnPerso('Ceux-ci leur accorde une seconde chance et décide de vous observer durant votre quête.');
        writelnPerso('Ces nouvelles ne plaisent pas à tous les dragons, certains se retournent contre vos créateurs,');
        writelnPerso('vous devez les vaincre afin de mettre fin à tout cela.');
        writelnPerso('Ces dragons sont Illyar, Qjard et Ksiorn, de puissants dragons que le clan vous aidera a invoquer.');
        writelnPerso();
        writelnPerso('Le clan vous aide à invoquer Illyar, le premier dragon. Il apparait et vous devez le combattre.');

        readlnPerso();
        InterfaceInGame();

        writelnPerso('Illyar Vous attaque');
        monstre := Illyar();
        combat(persoTemp,monstre,inventairePerso,fuite);
        setPersonnage(persoTemp);

        Benediction(persoTemp);
        setPersonnage(persoTemp);

        readlnPerso();
        InterfaceInGame();

        writelnPerso('Qjard à été invoque');
        writelnPerso('Qjard Vous attaque');
        monstre := Qjard();
        combat(persoTemp,monstre,inventairePerso,fuite);
        setPersonnage(persoTemp);

        Benediction(persoTemp);
        setPersonnage(persoTemp);

        readlnPerso();
        InterfaceInGame();

        writelnPerso('Ksiorn à été invoque');
        writelnPerso('Ksiorn Vous attaque');
        monstre := Ksiorn();
        combat(persoTemp,monstre,inventairePerso,fuite);
        setPersonnage(persoTemp);

        Benediction(persoTemp);
        setPersonnage(persoTemp);

        readlnPerso();
        InterfaceInGame();

        writelnPerso('Vous avez réussi a battre tous les dragons.');
        writelnPerso('Les Dieux vous promettent l''entrée au Valhalla lorsque votre heure sera venue. ');
        writelnPerso('Vous vivez au sein de ce clan le reste de votre vie, et combattez la guerre qui ravage votre monde');
        writelnPerso('avec Alduin et Orya a vos cotes et le talisman de votre femme près de votre cœur.');
        writelnPerso();
        writelnPerso('Vous avez atteint la fin du jeu, félicitations !!');
        fin := True;



        end;
      end;



    end;  // Fin du case
  end;  // Fin du while

readln;
end.

