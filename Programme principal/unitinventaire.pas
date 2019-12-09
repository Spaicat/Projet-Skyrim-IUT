unit unitInventaire;


interface

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

      liste.possession[1]:=0;
      liste.possession[2]:=0;
      liste.possession[3]:=0;
  end;


   procedure afficheObjet(var o:Objet);
   begin
       writeln(o.nom,' : ',o.valeur,'or   ');
       writeln(o.cate,' : ',o.action);
   end;


   procedure afficheInventaire(var liste:Inventaire);
   var i:Integer;
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
end.

