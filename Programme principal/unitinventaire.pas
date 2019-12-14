unit unitInventaire;


interface
  uses unitPersonnage;
  // TYPES

  type categorie=(Soin,Protection,Degats);

  type Objet = record
     nom: String;
     valeur: Integer;
     cate: Categorie;
     action: Integer;
  end;

    type listeObj = array[1..3] of Objet;

    type poss = array[1..3] of Integer;

  type inventaire = record
     listeObjets : listeObj;
     possession : poss;
     end;

  // FONCTIONS ET PROCEDURES

  procedure initInventaire(var liste:Inventaire; var o1,o2,o3:Objet);
  procedure initObjet(var o1,o2,o3:Objet);
  procedure afficheObjet(var o:Objet);
  procedure afficheInventaire(var liste:Inventaire);
  procedure equipement(var perso : Personnage;var inventairePerso : Inventaire; var indicateur : Integer; var nomEquipement : String);

implementation


  procedure initObjet(var o1,o2,o3:Objet);
  begin
      o1.nom:='Epee';
      o1.valeur:=5;
      o1.cate:=Degats;
      o1.action:=20;

      o2.nom:='Bouclier';
      o2.valeur:=3;
      o2.cate:=Protection;
      o2.action:=10;

      o3.nom:='Potions de soin';
      o3.valeur:=5;
      o3.cate:=Soin;
      o3.action:=30;
  end;


  procedure initInventaire(var liste:Inventaire; var o1,o2,o3:Objet);

  begin
      liste.listeObjets[1]:=o1;
      liste.listeObjets[2]:=o2;
      liste.listeObjets[3]:=o3;

      liste.possession[1]:=1;
      liste.possession[2]:=0;
      liste.possession[3]:=0;
  end;

   procedure afficheObjet(var o:Objet);
   begin
       writeln(o.nom,' : ',o.valeur,'or   ');
       writeln(o.cate,' : ',o.action);
   end;


   procedure afficheInventaire(var liste:Inventaire);
   var
     i:Integer;
   begin
     for i:=1 to length(liste.listeObjets) DO
     begin
        if (liste.possession[i]>0) then
        begin
            // writeln('N° d''article : ',i);
             afficheObjet(liste.listeObjets[i]);
             writeln('Quantite : ',liste.possession[i],' ');
             writeln;
        end;
     end;
   end;

   procedure equipement(var perso : Personnage;var inventairePerso : Inventaire; var indicateur : Integer; var nomEquipement : String);
   var
     option : Integer;
     sortie : Boolean;
   begin
   sortie := False;
   writeln('De quel objet voulez-vous vous equiper ?');
   writeln();
   writeln('1 - Epee');
   writeln('2 - Bouclier');
   writeln('3 - Potion');
   readln(option);

   while sortie = False do
   begin
   case option of
   0: sortie := True;

   1 :
     begin
     if inventairePerso.possession[1] > 0 then
     begin
       if indicateur = 1 then
         begin
         if nomEquipement = 'Epee' then
           begin
           writeln('Elle est deja equiper');
           sortie := True;
           end
         else
           begin
           writeln('Vous vous en Equiper');
           readln();
           perso.defense := perso.defense - 10;
           perso.attaque := perso.attaque + 20;
           indicateur := indicateur + 1;
           nomEquipement := 'Epee';
           sortie := True;
           end;
         end
       else
         begin
         writeln('Vous vous equiper de l''eppe !');
         readln();
         perso.attaque := perso.attaque + 20;
         indicateur := indicateur + 1;
         nomEquipement := 'Epee';
         sortie := True;
         end;
      end
     else
       begin
       writeln('Vous n''avez pas cet objet...');
       sortie := True;
       end;
     end;
   2 :
     begin
     if inventairePerso.possession[2] > 0 then
       begin
       if indicateur = 1 then
         begin
         if nomEquipement = 'Bouclier' then
           begin
           writeln('Elle est deja equiper');
           sortie := True;
           end
         else
           begin
           writeln('Vous vous en Equiper');
           readln();
           perso.defense := perso.defense + 10;
           perso.attaque := perso.attaque - 20;
           indicateur := indicateur + 1;
           nomEquipement := 'Bouclier';
           sortie := True;
           end;
         end
       else
         begin
         writeln('Vous vous equiper du Bouclier !');
         readln();
         perso.defense := perso.defense + 10;
         indicateur := indicateur + 1;
         nomEquipement := 'Bouclier';
         sortie := True;
         end;

       end
      else
         begin
         writeln('Vous n''avez pas cet objet...');
         sortie := True;
         end;
     end;
  3 :
    begin
    if inventairePerso.possession[3] > 0 then
      begin
      sortie := True;
      writeln('Vous consommer une potion !');
      writeln('Vous regagner 30 PV !');
      perso.pv := perso.pv + 30;
      if perso.pv > perso.pvMax then
        perso.pv := perso.pvMax;
      inventairePerso.possession[3] := inventairePerso.possession[3]-1
      end
    else
      begin
      sortie := True;
      writeln('Vous n''avez pas de potion...');
      end;
    end;
   end;
   end;
   end;
end.
