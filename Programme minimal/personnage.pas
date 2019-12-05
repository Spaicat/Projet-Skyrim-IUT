unit Personnage;

interface
  uses GestionEcran, TypInfo;

  type race = (elfe, nain, humain);

  type persoJouable = Record
                  race : race;
                  pseudo : String;
                  PV : Integer;
                  end;


  //Procédure pour créer le personnage
  procedure createCharacter();

implementation

  //Procédure pour créer le personnage
  procedure createCharacter();
  var
    raceActuel : race;
    repUtilisateur : Integer; //Reponse saisis par l'utilisateur
  begin
    for raceActuel := low(race) to high(race) do
        begin
        writeln(GetEnumName(typeinfo(race), ord(raceActuel)), ' - ', ord(raceActuel)+1);
        end;
    write('Choisissez une race : ');
    readln(repUtilisateur);
    raceActuel := race(repUtilisateur-1);
    writeln('Vous avez choisi la race ', raceActuel);
  end;

end.

