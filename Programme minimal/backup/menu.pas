unit Menu;

interface
uses UnitPersonnage, Magasin, unitCombat, GestionEcran;


//Procédure qui affiche le menu initial
procedure menuInitial();
//Procédure pour lancer le jeu
procedure LaunchGame();
//Procédure pour quitter le jeu
procedure QuitGame();

implementation

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
    attendre(1000);
    effacerEcran();
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
  effacerEcran();
  createCharacter();
end;


//Procédure pour quitter le jeu
procedure QuitGame();
var
  rep : Char;
begin
  effacerEcran();
  write('Etes vous sur de vouloir quitter ? [O/N] : ');
  readln(rep);
  case rep of
       'O':writeln('bye');
       'N':writeln('Re');
       else
         begin
         writeln('Veuillez saisir une réponse valide');
         attendre(1000);
         QuitGame();
         end;
  end;
end;

end.

