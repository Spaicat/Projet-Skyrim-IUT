unit unitFonctionGeneral;


interface
uses TypInfo, Keyboard, Classes, SysUtils;
function Key() : TKeyEvent;
procedure redo();

uses
  Classes, SysUtils;

implementation
function Key() : TKeyEvent;
var
  K:TKeyEvent;
begin
InitKeyBoard;
  Repeat
    K:=GetKeyEvent;
    K:=TranslateKeyEvent(K);
  until (GetKeyEventChar(K)<>'');
  Key :=K;
DoneKeyBoard;
end;

procedure redo();
var
  coorC,
  coorC2 : coordonnees;
  largeur,
  hauteur : Integer;
begin
  coorC.x := 2;      //Coor 1
  coorC.y := 0;
  coorC2.x := 197;     //Coor 2
  coorC2.y := 58;
  largeur := 200;
  hauteur := 60;

  effacerEcran();
  changerTailleConsole(largeur,hauteur);
  dessinerCadre(coorC,coorC2,double,4,0);
end;

end.

