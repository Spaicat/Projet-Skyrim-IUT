unit unitbenediction;


interface

uses unitpersonnage, UnitMenu,GestionEcran;

procedure Benediction(var perso: personnage);


implementation


procedure Benediction(var perso: personnage);

var
  texte1 :Coordonnees;
  texte2 :Coordonnees;
  texte3 : Coordonnees;
  temp : Integer;

begin
  texte1.x := 10;
  texte1.y := 10;

  texte2.x := 10;
  texte2.y := 15;

  texte3.x := 10;
  texte3.y := 20;

  writeln('De quelle bénédiction souhaitez-vous bénéficiez pour la suite de votre aventure ?');
  ecrireEnPosition(texte1,'Bénédiction d''Odin - Votre force prend exemple sur celle du Dieu de la guerre. Votre attaque est augmentée de 30');
  ecrireEnPosition(texte2,'Bénédiction d''Idunn - La déesse de la jeunesse immortelle améliore votre résistance. Votre vie sera augmentée de 30');
  ecrireEnPosition(texte3,'Bénédiction de Thor - Le tonnerre et la protection de Thor vous accompagne. Votre attaque, votre vie et votre défense sont augmenté de 10');

  temp := selectionMenu(texte1,3,5,20,3,15);

  case temp of
  0 :
    begin         //BENEDICTION D'ODIN
    writeln('Vous êtes bénis par Odin');
    perso.attaque:= perso.attaque + 30;
    end;
  1:
    begin         //BENEDICTION D'IDUNN
    writeln('Vous êtes bénis pas Idunn');
    perso.pv:= perso.pv + 30;
    perso.pvMax := perso.pvMax +30;
    end;
  2:
    begin         //BENEDICTION DE THOR
    writeln('Vous êtes bénis par Thor');
    perso.pv:= perso.pv + 10;
    perso.attaque:= perso.attaque + 10;
    perso.defense:= perso.defense +10;
    end;
  end;

end;

end.
