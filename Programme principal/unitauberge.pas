unit unitAuberge;



interface
uses GestionEcran, unitPersonnage, UnitMenu;

procedure LancerAuberge(var perso : personnage);


implementation

procedure LancerAuberge(var perso : personnage);
var
  coorTexte : Coordonnees;
  coorTexte2 : Coordonnees;
  temp : Integer;
  sortie : Boolean;
begin
  coorTexte.x := 10;
  coorTexte.y := 10;

  coorTexte2.x := 10;
  coorTexte2.y := 15;

  sortie := False;

  while sortie = False do
    begin
    writeln('Bienvenue dans mon auberge !');
    writeln('Voulez-vous vous reposez ?');
    writeln('Cela vous coutera 20 or');
    ecrireEnPosition(coorTexte,'Se Reposer');
    ecrireEnPosition(coorTexte2,'Partir');

    temp := selectionMenu(coorTexte,2,5,3,15);

    if temp <> 1 then
      begin
      if perso.argent >= 20 then
        begin
        effacerEcran();
        perso.argent := perso.argent - 20;
        perso.pv := perso.pvMax;
        writeln('Vous vous etes bien reposer vous regagner toute votre vie !');
        sortie := True;
        end
    else
       begin
       effacerEcran();
       writeln('Vous n''avez pas asser d''or...');
       end;
       end
    else
      begin
      effacerEcran();
      writeln('Au revoir !');
      sortie:= True;
      end;


  end;
  end;
end.

