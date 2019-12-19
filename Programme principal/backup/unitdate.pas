unit unitDate;

interface

  uses SysUtils;

  type
    jour =(Morndas,Tirdas,Middas,Turdas,Fredas,Loredas,Sundas);
    mois = (Primetoile,Clairciel,Semailles,Ondepluie,Plantaisons,Mi_lan,Hautzenith,Vifazur,Atrefeu,Soufflegivre,Sombreciel,Soiretoile);


  type
    Time = record
      heure:Integer;
      minute:Integer;
    end;
    dateCourante = record
      t:Time;
      j:jour;
      i:Integer;//numéro du jour
      m:mois;
      a:Integer;
    end;

  function getDate():dateCourante;
  procedure initDate();
  procedure incrementeDate();
  procedure writeDate();
  procedure waitUneHeure();


implementation

  uses UnitMenu;

  var
    temps:dateCourante;

  procedure initDate();
  begin
    temps.j:=Morndas;
    temps.i:=12;
    temps.m:=Clairciel;
    temps.t.heure:=10;
    temps.a:=156;

  end;

  function getDate():dateCourante;
  begin
    getDate:=temps;
  end;



  function bissextile(annee : integer) : boolean;
  begin
    bissextile := ((annee mod 400 = 0) or ((annee mod 100 <> 0) and (annee mod 4 = 0)));
  end;

  function jourSuivant(j : jour) : jour;
  begin
    if (j = Sundas)
    then jourSuivant := Morndas
    else jourSuivant := Succ(j);
  end;

  function moisSuivant(m : mois) : mois;
  begin
    if (m = Soiretoile)
    then moisSuivant := Primetoile
    else moisSuivant := Succ(m)
  end;

  function nbJours(m : mois; annee : integer) : integer;
  begin
    case m of
      Ondepluie, Mi_lan, Sombreciel: nbJours := 30;
      Clairciel:
      begin
        if(bissextile(annee))
        then nbJours := 29
        else nbJours := 28;
      end;
      else nbJours := 31 ;
    end;
  end;

  procedure incrementeDate();
  begin
    randomize();
    temps.t.minute:=temps.t.minute+random(5)+6;
    if temps.t.minute>=60 then
    begin
      temps.t.minute:=0;
      temps.t.heure:=temps.t.heure+1;
    end;
    if temps.t.heure>=24 then
    begin
      temps.t.heure:=0;
      temps.j:=jourSuivant(temps.j);
      temps.i:=temps.i+1;
      if temps.i>nbJours(temps.m,temps.a) then
      begin
        temps.i:=1;
        temps.m:=moisSuivant(temps.m);
        if ord(temps.m)=1 then
        begin
          temps.a:=temps.a+1;
        end;
      end;
    end;
  end;
  procedure writeJour(j : jour);
  begin
    case j of
      Morndas: write('Morndas');
      Tirdas: write('Tirdas');
      Middas: write('Middas');
      Turdas: write('Turdas');
      Fredas: write('Fredas');
      Loredas: write('Loredas');
      Sundas: write('Sundas');
    end;
  end;
  procedure waitUneHeure();
  var
    i:Integer;
  begin
    for i:=0 to 60 do
        incrementeDate();
  end;

  procedure writeMois(m : mois);
  begin
    case m  of
      Primetoile: write('Primetoile');
      Clairciel: write('Clairciel');
      Semailles: write('Semailles');
      Ondepluie: write('Ondepluie');
      Plantaisons: write('Plantaisons');
      Mi_lan: write('Mi_lan');
      Hautzenith: write('Hautzenith');
      Vifazur: write('Vifazur');
      Atrefeu: write('Atrefeu');
      Soufflegivre: write('Soufflegivre');
      Sombreciel: write('Sombreciel');
      Soiretoile: write('Soiretoile');
    end;
  end;

  procedure writeDate();
  begin
    writeJour(temps.j);write(' ',temps.i,' ');write(temps.m);writelnPerso(' de l''an ' + IntToStr(temps.a));
    writelnPerso(IntToStr(temps.t.heure) + 'h' + IntToStr(temps.t.minute));
  end;

end.
