unit unitLieu;

interface

uses
    SysUtils,unitPersonnage,unitCombat,unitMagasin,unitInventaire,GestionEcran;

type
  cateLieu = (magasin,fight,autre);
  TTableau = array [1..6] of Boolean;       // 1 = Blancherive // 2 = Marché de Blancherive // 3 = Chateau //4 = Porte de la ville // 5 = Boutique // 6 = Inventaire

type
  TInformation = record
    nom : String;
    indice:Integer;
    possibiliteLieu : TTableau;
    cate:cateLieu;
  end;
var lieu1, lieu2, lieu3, lieu4,lieu5,lieu6,position : TInformation;

procedure initLieu();
procedure deplacement();
function afficheLieuxPossibles() : Integer;
procedure actionLieu();
procedure setLieu(var lieuAAffect,lieu:TInformation);

implementation
uses unitMenu;

procedure setLieu(var lieuAAffect,lieu:TInformation);
var
  i:Integer;//indice de parcours du tableau
begin
   lieuAAffect.nom:=lieu.nom;
   lieuAAffect.indice:=lieu.indice;
   for i:=low(lieu.possibiliteLieu) to high(lieu.possibilitelieu) do
   begin
     lieuAAffect.possibiliteLieu[i]:=lieu.possibiliteLieu[i];
   end;
end;

function afficheLieuxPossibles() : Integer;
var
  i : Integer;
  posInitial : coordonnees;
  listePos : String;
begin
    listePos := '';
    writelnPerso('Position : ' + position.nom);
    posInitial.x := positionCurseur().x;
    posInitial.y := positionCurseur().y+1;
    for i:= 1 to 6 do
      if position.possibiliteLieu[i] then
        case i of
          1:begin writelnPerso(lieu1.nom); listePos := listePos + IntToStr(i);end;
          2:begin writelnPerso(lieu2.nom); listePos := listePos + IntToStr(i);end;
          3:begin writelnPerso(lieu3.nom); listePos := listePos + IntToStr(i);end;
          4:begin writelnPerso(lieu4.nom); listePos := listePos + IntToStr(i);end;
          5:begin writelnPerso(lieu5.nom); listePos := listePos + IntToStr(i);end;
          6:begin writelnPerso(lieu6.nom); listePos := listePos + IntToStr(i);end;
        end;
    afficheLieuxPossibles := StrToInt(listePos[selectionMenu(posInitial, length(listePos), 1, 22, LightBlue, White)+1]);
end;

procedure deplacement();
var
  choix:Integer;

begin
  choix := afficheLieuxPossibles();
  while((choix<1) or (choix>6) or not(position.possibiliteLieu[choix])) do
  begin
    writelnPerso('Vous ne pouvez pas aller ici directement');
    afficheLieuxPossibles();
    writelnPerso('Ou voulez-vous aller ?');
    readlnPerso(choix);
  end;
  case choix of
       1:setLieu(position,lieu1);
       2:setLieu(position,lieu2);
       3:setLieu(position,lieu3);
       4:setLieu(position,lieu4);
       5:setLieu(position,lieu5);
       6:setLieu(position,lieu6);
  end;

  {writeln('Vous allez à ',position.nom);
  repeat
  writeln('Souhaitez vous rester ici pour voir ce qu''il y a a faire(1) ou souhaitez vous continuer votre chemin(2) ?');
  readln(choix);
  until(choix>=1) and (choix<=2);
  case choix of
       1:actionLieu();
       2:writeln('Continuons notre chemin');
  end;}


end;

procedure actionLieu();
var
  choix:Integer;

begin
     case position.cate of
          magasin:;//appeler procedure du marche pour acheter et vendre;
          autre:writelnPerso('Bon voyage ! autre');
          fight:writelnPerso('Combat');
     end;
end;





procedure initLieu();
begin


  lieu1.nom :='Bourg de Blancherive';
  lieu1.indice:=1;
  lieu1.cate:=autre;
  lieu1.possibiliteLieu[1] := False;
  lieu1.possibiliteLieu[2] := True;
  lieu1.possibiliteLieu[3] := False;
  lieu1.possibiliteLieu[4] := True;
  lieu1.possibiliteLieu[5] := True;
  lieu1.possibiliteLieu[6] := True;

  lieu2.nom := 'Marche de Blancherive';
  lieu2.indice:=2;
  lieu2.cate:=autre;
  lieu2.possibiliteLieu[1] := True;
  lieu2.possibiliteLieu[2] := False;
  lieu2.possibiliteLieu[3] := True;
  lieu2.possibiliteLieu[4] := False;
  lieu2.possibiliteLieu[5] := False;
  lieu2.possibiliteLieu[6] := True;

  lieu3.nom := 'Chateau de Blancherive';
  lieu3.indice:=3;
  lieu3.cate:=autre;
  lieu3.possibiliteLieu[1] := False;
  lieu3.possibiliteLieu[2] := True;
  lieu3.possibiliteLieu[3] := False;
  lieu3.possibiliteLieu[4] := False;
  lieu3.possibiliteLieu[5] := False;
  lieu3.possibiliteLieu[6] := True;

  lieu4.nom := 'Porte de Blancherive';
  lieu4.indice:=4;
  lieu4.cate:=fight;
  lieu4.possibiliteLieu[1] := True;
  lieu4.possibiliteLieu[2] := False;
  lieu4.possibiliteLieu[3] := False;
  lieu4.possibiliteLieu[4] := False;
  lieu4.possibiliteLieu[5] := False;
  lieu4.possibiliteLieu[6] := True;

  lieu5.nom := 'Boutique';
  lieu5.indice:=5;
  lieu5.cate:=magasin;
  lieu5.possibiliteLieu[1] := True;
  lieu5.possibiliteLieu[2] := False;
  lieu5.possibiliteLieu[3] := False;
  lieu5.possibiliteLieu[4] := False;
  lieu5.possibiliteLieu[5] := False;
  lieu5.possibiliteLieu[6] := False;

  lieu6.nom := 'Inventaire';
  lieu6.indice:=6;
  lieu6.cate:=autre;
  lieu6.possibiliteLieu[1] := True;
  lieu6.possibiliteLieu[2] := True;
  lieu6.possibiliteLieu[3] := True;
  lieu6.possibiliteLieu[4] := True;
  lieu6.possibiliteLieu[5] := False;
  lieu6.possibiliteLieu[6] := False;

  setLieu(position,lieu1);

end;
end.
