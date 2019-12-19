unit unitAuberge;



interface
uses GestionEcran, unitPersonnage, UnitMenu, unitLieu, SysUtils;

procedure LancerAuberge(var perso : personnage);


implementation

procedure LancerAuberge(var perso : personnage);
var
  coorTexte : Coordonnees;
  coorTexte2 : Coordonnees;
  temp : Integer;
begin
  coorTexte := positionCurseur();

  coorTexte2.x := positionCurseur().x;
  coorTexte2.y := positionCurseur().y + 5;

  InterfaceInGame(position);

  writelnPerso('Bienvenue dans mon auberge !');
  writelnPerso('Voulez-vous vous reposez ?');
    writelnPerso('Cela vous coutera 20 or');
    ecrireEnPosition(coorTexte,'Se Reposer');
    ecrireEnPosition(coorTexte2,'Partir');

    temp := selectionMenu(coorTexte,2,5, 20, 3,15);

    if temp <> 1 then
      begin
      if perso.argent >= 20 then
        begin
        effacerEcran();
        perso.argent := perso.argent - 20;
        perso.pv := perso.pvMax;
        writelnPerso('Vous vous etes bien reposer vous regagner toute votre vie !');
        end
      else
         begin
         effacerEcran();
         writelnPerso('Vous n''avez pas asser d''or...');
         end;
       end
    else
      begin
      effacerEcran();
      writelnPerso('Au revoir !');
      end;
    writelnPerso('' + BoolToStr(sortie));
    readlnPerso();


  end;
end.

