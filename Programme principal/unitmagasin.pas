unit unitMagasin;



interface

uses unitInventaire, unitPersonnage, SysUtils, TypInfo;

procedure initMagasin(var listePerso,listeMagasin:Inventaire);
procedure achat(var p:Personnage; var listePer,listeMagasin:Inventaire);
procedure vente(var p:Personnage; var listePer,listeMagasin:Inventaire);




implementation
uses UnitMenu;

   procedure initMagasin(var listePerso,listeMagasin:Inventaire);
   var
     i:Integer;
   begin
     for i:=0 to length(listePerso.listeObjets) do
     begin
         listeMagasin.listeObjets[i]:=listePerso.listeObjets[i];
         listeMagasin.possession[i]:=3;
     end;
   end;



   procedure achat(var p:Personnage; var listePer,listeMagasin:Inventaire);
   var
     nChoix:Integer;
     sortie:boolean;
   begin
     sortie:=false;

     afficheInventaire(listePer);
     writelnPerso('1 : Epee --> 5 or');
     writelnPerso('2 : Bouclier --> 3 or');
     writelnPerso('3 : Potion --> 5 or');
     while(sortie=false) do
     begin
       writelnPerso();
       write('Faites votre choix (pour sortir saisir 0) :');
       readlnPerso(nChoix);
       if (nChoix=0) then sortie:=true

       else if p.argent>=listeMagasin.listeObjets[nChoix].valeur then
       begin
          listePer.possession[nChoix]:=listePer.possession[nChoix]+1; //ajout à l'inventaire du personnage
          p.argent:=p.argent-listeMagasin.listeObjets[nChoix].valeur; //diminution de la bourse du personnage
          listeMagasin.possession[nChoix]:=listeMagasin.possession[nChoix]-1;//diminution des stocks
          writelnPerso('Vous avez acquis un/une ' + listePer.listeObjets[nChoix].nom + '  pour ' + IntToStr(listeMagasin.listeObjets[nChoix].valeur) + ' or ' + 'Vous en avez actuellement ' + IntToStr(listePer.possession[nChoix]) + ' et il vous reste maintenant ' + IntToStr(p.argent) + ' or');
       end
       else if (p.argent<listeMagasin.listeObjets[nChoix].valeur) then
       begin
            writelnPerso('Vous n''avez pas l''argent necessaire.');
       end;
   end;
   end;

  procedure vente(var p:Personnage; var listePer,listeMagasin:Inventaire);
  var
     nChoix:Integer;
     sortie:boolean;

  begin
     afficheInventaire(listePer);
     sortie := False;
     writelnPerso('1 - Vendre une epee pour 3 or ? Vous en avez ' + IntToStr(listePer.possession[1]));
     writelnPerso('1 - Vendre un Bouclier pour 1 or ? Vous en avez ' + IntToStr(listePer.possession[2]));
     writelnPerso('1 - Vendre une potion pour 3 or ? Vous en avez ' + IntToStr(listePer.possession[3]));
     while(sortie=false) do
     begin
       writelnPerso;
       write('Faites votre choix (pour sortir saisir 0) : ');
       writelnPerso();
       readlnPerso(nChoix);
       if (nChoix=0) then sortie:=true

     else if (nChoix = 1) AND (listePer.possession[1] > 0) then
       begin
       writelnPerso('Vous vender une epee pour 3 or');
       p.argent := p.argent + 3;
       end
     else if (nChoix = 2) AND (listePer.possession[2] > 0) then
       begin
       writelnPerso('Vous vender un Bouclier pour 1 or');
       p.argent := p.argent + 1;
       end
      else if (nChoix = 3) AND (listePer.possession[3] > 0) then
       begin
       writelnPerso('Vous vender une potion pour 3 or');
       p.argent := p.argent + 3;
       end
     end;
  end;

end.
