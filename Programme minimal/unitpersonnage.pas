unit UnitPersonnage;

interface
  uses GestionEcran, TypInfo;

  type race = (elfe, nain, humain);

  type personnage = Record
                  race : race;
                  pseudo : String;
                  PV : Integer;
                  end;

  var
    persoChoose : personnage; //Variable qui enregistre le personnage créé par l'utilisateur

  //Procédure pour créer le personnage
  procedure createCharacter();

implementation

  //Procédure pour créer le personnage
  procedure createCharacter();
  var
    raceActuel : race;
    repUtilisateur : Integer; //Reponse saisis par l'utilisateur
    repUtilisateurChar : String;
  begin
    write('Choisissez le pseudonyme de votre personnage : ');
    readln(persoChoose.pseudo);
    for raceActuel := low(race) to high(race) do
        begin
        writeln(GetEnumName(typeinfo(race), ord(raceActuel)), ' - ', ord(raceActuel)+1);
        end;
    write('Choisissez une race : ');
    readln(repUtilisateur);
    persoChoose.race := race(repUtilisateur-1);
    writeln('Vous avez choisi la race ', persoChoose.race);
    write('Voulez-vous confirmez ? [o/n] ');
    readln(repUtilisateurChar);
    if repUtilisateurChar='n' then
       createCharacter()
    else if repUtilisateurChar<>'o' then
       begin
       writeln('Veuillez saisir une réponse valide');
       attendre(1000);
       effacerEcran();
       end;
  end;

end.

