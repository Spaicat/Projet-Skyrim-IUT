unit ProgrammeMinimal;

interface
//Procédure qui affiche le menu initial
procedure menuInitial();
//Procédure pour lancer le jeu
procedure LaunchGame();
//Procédure pour quitter le jeu
procedure QuitGame();
//Procédure pour créer le personnage
procedure createCharacter();

implementation
uses Crt;

const
  TableauRace : array[1..3] of string = ('Elfe', 'Orque', 'Humain');

//Procédure qui affiche le menu initial
procedure menuInitial();
var
  rep : Integer;
begin
  writeln('Commencer une partie - 1');
  writeln('Quitter - 2');
  write('Choisissez votre action : ');
  readln(rep);
  if (rep<1) OR (rep>2) then //On teste si la réponse est bien ce que l'on veut
  begin
    writeln('Veuillez saisir une réponse valide');
    Delay(1000);
    ClrScr;
    menuInitial();
  end;
  case rep of //On lance les fonctions en conséquences
       1:LaunchGame();
       2:QuitGame();
  end;
end;


//Procédure pour quitter le jeu
procedure LaunchGame();
begin
  ClrScr();
  createCharacter();
end;


//Procédure pour quitter le jeu
procedure QuitGame();
var
  rep : Char;
begin
  ClrScr();
  write('Etes vous sur de vouloir quitter ? [O/N] : ');
  readln(rep);
  case rep of
       'O':writeln('bye');
       'N':writeln('Re');
       else
         begin
         writeln('Veuillez saisir une réponse valide');
         Delay(1000);
         QuitGame();
         end;
  end;
end;


//Procédure pour créer le personnage
procedure createCharacter();
var
  i : Integer;
begin
  for i:=1 to Length(TableauRace) do
      begin
      writeln(TableauRace[i], ' - ', i);
      end;
  writeln('Choisissez une race : ');
end;

end.

