unit unitbenediction;


interface

uses unitpersonnage;

procedure firstBenediction(var perso: personnage);
procedure secondBenediction(var perso: personnage);

implementation


procedure firstBenediction(var perso: personnage);

begin
  perso.pv:= perso.pv + 100;
  perso.pvMax := perso.pvMax + 100;
end;


procedure secondBenediction(var perso: personnage);

begin
  perso.attaque:= perso.attaque + 100;
end;
end.
