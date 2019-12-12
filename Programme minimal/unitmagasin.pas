unit unitMagasin;



interface

uses unitInventaire, unitPersonnage;

procedure initMagasin(var listePerso,listeMagasin:Inventaire);
procedure achat(var p:Personnage; var listePer,listeMagasin:Inventaire);





implementation
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

     afficheInventaire(listeMagasin);
     writeln('1 vous permettra d''acheter une epee');
     writeln('2 vous permettra d''acheter un bouclier');
     writeln('3 vous permettra d''acheter une potion');
     while(sortie=false) do
     begin
         writeln;
       write('Faites votre choix (pour sortir saisir 0) :');
       readln(nChoix);
       if (nChoix=0) then sortie:=true

       else if p.argent>=listeMagasin.listeObjets[nChoix].valeur then
       begin
          listePer.possession[nChoix]:=listePer.possession[nChoix]+1; //ajout à l'inventaire du personnage
          p.argent:=p.argent-listeMagasin.listeObjets[nChoix].valeur; //diminution de la bourse du personnage
          listeMagasin.possession[nChoix]:=listeMagasin.possession[nChoix]-1;//diminution des stocks
          writeln('Vous avez acquis un/une ',listePer.listeObjets[nChoix].nom,'  pour ',listeMagasin.listeObjets[nChoix].valeur,' or ','Vous en avez actuellement ',listePer.possession[nChoix],' et il vous reste maintenant ',p.argent,' or');
       end
       else if (p.argent<listeMagasin.listeObjets[nChoix].valeur) then
       begin
            writeln('Vous n''avez pas l''argent necessaire.');
       end;
   end;
   end;

   {procedure vente(var p:Personnage; var listeMagasin:Inventaire);
   var
     i:Integer //permet de lire et de connaître le numéro de l'objet

   begin




   end;}
end.

