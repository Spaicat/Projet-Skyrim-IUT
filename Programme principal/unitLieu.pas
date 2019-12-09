unit unitLieu;

interface

uses
    SysUtils;

type
  TLieu = (Blancherive,Marche_de_Blancherive,Chateau_de_Blancherive,Porte_De_Blancherive);
  TTableau = array [1..4] of Boolean;       // 1 = Blancherive // 2 = Marché de Blancherive // 3 = Chateau //4 = Porte de la ville

type
  TInformation = record
    nom : TLieu;
    possibiliteLieu : TTableau;
  end;

procedure initLieu(var position : TInformation);

implementation

procedure initLieu(var position : TInformation);
var
  lieu1 : TInformation;  //Information de 1 / Blancherive
  lieu2 : TInformation;	 //Information de 2 / Marche de Blancherive
  lieu3 : TInformation;  //Information de 3 / Chateau
  lieu4 : TInformation;
  i : Integer;

begin


    lieu1.nom := Blancherive;
  lieu1.possibiliteLieu[1] := False;
  lieu1.possibiliteLieu[2] := True;
  lieu1.possibiliteLieu[3] := False;
  lieu1.possibiliteLieu[4] := True;

  lieu2.nom := Marche_de_Blancherive;
  lieu2.possibiliteLieu[1] := True;
  lieu2.possibiliteLieu[2] := False;
  lieu2.possibiliteLieu[3] := True;
  lieu2.possibiliteLieu[4] := False;

  lieu3.nom := Chateau_de_Blancherive  ;
  lieu3.possibiliteLieu[1] := False;
  lieu3.possibiliteLieu[2] := True;
  lieu3.possibiliteLieu[3] := False;
  lieu3.possibiliteLieu[4] := False;

  lieu4.nom := Porte_De_Blancherive;
  lieu4.possibiliteLieu[1] := True;
  lieu4.possibiliteLieu[2] := False;
  lieu4.possibiliteLieu[3] := False;
  lieu4.possibiliteLieu[4] := False;

  if position.nom = lieu1.nom then
    position := lieu1;
  if position.nom = lieu2.nom then
    position := lieu2;
  if position.nom = lieu3.nom then
    position := lieu3;
  if position.nom = lieu4.nom then
    position := lieu4;

    for i:= 1 to 4 do
    if position.possibiliteLieu[i] = True then
      begin
      if i = 1 then
        writeln('Blancherive');
      if i = 2 then
        writeln('Marche_de_Blancherive');
      if i = 3 then
        writeln('Chateau_de_Blancherive');
      if i = 4 then
        writeln('Porte_De_Blancherive');
      end;
    end;

end.

