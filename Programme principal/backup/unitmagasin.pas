unit unitMagasin;



interface

uses unitInventaire, unitPersonnage, SysUtils, TypInfo;

procedure initMagasin(var listePerso,listeMagasin:Inventaire);
procedure achat(var p:Personnage; var listePer,listeMagasin:Inventaire);
procedure vente(var p:Personnage; var listePer,listeMagasin:Inventaire);
procedure negociation();




implementation
uses UnitMenu;
   var
      remise:boolean; //booléen qui vérifie si le joueur a une remise sur son prochain achat.

   procedure initMagasin(var listePerso,listeMagasin:Inventaire);
   var
     i:Integer;
     {On récupère de l'inventaire du joueur, les différents objets qu'il peut possèder
     et pour chaque objet on met la quantité d'objets disponible à 3.}
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

       repeat
       writelnPerso('Faites votre choix (pour sortir saisir 0) :');
       if remise then
       begin
          writelnPerso('N''oublier pas ! Vous avez 30% de remise sur un article au choix.');

       end;
       readlnPerso(nChoix);
       until((nChoix>=0) and (nChoix<=3));
       if (nChoix=0) then
          sortie:=true
       else if p.argent>=listeMagasin.listeObjets[nChoix].valeur then
       begin
         if remise then
         begin
            remise:=false;
            listePer.possession[nChoix]:=listePer.possession[nChoix]+1; //ajout à l'inventaire du personnage
            p.argent:=p.argent-listeMagasin.listeObjets[nChoix].valeur*7 div 10; //diminution de la bourse du personnage
            listeMagasin.possession[nChoix]:=listeMagasin.possession[nChoix]-1;//diminution des stocks
            writelnPerso('Vous avez acquis un/une ' + listePer.listeObjets[nChoix].nom + '  pour ' + IntToStr(listeMagasin.listeObjets[nChoix].valeur*7 div 10) + ' or. Vous en avez actuellement ' + IntToStr(listePer.possession[nChoix]) + ' et il vous reste maintenant ' + IntToStr(p.argent) +' or.');
         end
         else
         begin
            listePer.possession[nChoix]:=listePer.possession[nChoix]+1; //ajout à l'inventaire du personnage
            p.argent:=p.argent-listeMagasin.listeObjets[nChoix].valeur; //diminution de la bourse du personnage
            listeMagasin.possession[nChoix]:=listeMagasin.possession[nChoix]-1;//diminution des stocks
            writelnPerso('Vous avez acquis un/une ' + listePer.listeObjets[nChoix].nom + '  pour ' + IntToStr(listeMagasin.listeObjets[nChoix].valeur) + ' or. Vous en avez actuellement ' + IntToStr(listePer.possession[nChoix]) + ' et il vous reste maintenant ' + IntToStr(p.argent) + ' or.');
         end;
         if (p.argent<listeMagasin.listeObjets[nChoix].valeur) then
         begin
              writelnPerso('Vous n''avez pas l''argent necessaire.');
         end;
       end; //Fin cas achat possible
     end; //Fin while(sortie=false)
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

  procedure negociation();
  var

     nbADeviner:Integer;
     nbEssais:Integer;
     sortie:boolean;
     nb:Integer;
  begin
     sortie:=false;
     nbEssais:=1;
     randomize();
     writelnPerso('Ah vous voulez jouer, ... sachez que je suis joueur moi aussi et si vous gagner contre moi vous gagnerez 30% de remise sur n''importe quel article pour votre prochain achat');
     readlnPerso();
     writelnPerso(' _____');
     writelnPerso('|  _  |');
     writelnPerso('|  ?  |');
     writelnPerso('|_____|');
     writelnPerso();
     nbADeviner:=random(50)+1;
     writelnPerso('Les regles sont simples, vous devez trouver le nombre écrit au dos de ce tableau');
     writelnPerso('Vous avez 4 essais, le nombre est compris entre 1 et 50. C''est parti ! Proposez un nombre !');
     repeat
       readlnPerso(nb);
       if (nbEssais>4) then
       begin
            writelnPerso('Dommage ! Vous avez dépassé le nombre d''essais ! Vous paierez les articles au prix fort !');
            sortie:=true;
            writelnPerso('Le nombre était ' + IntToStr(nbADeviner) + '.');
       end
       else
       begin
            if nb=nbADeviner then
            begin
                 remise:=true;
                 sortie:=true;
                 writelnPerso('Bien joué ! Vous avez 30% de remise sur n''importe quel article.')
            end
            else
            begin
                 nbEssais:=nbEssais+1;
                 if nb>nbADeviner then
                 begin
                      writelnPerso('Raté le nombre est plus petit que ' + IntToStr(nb) + '.');
                 end
                 else
                 begin
                      writelnPerso('Raté le nombre est plus grand que ' + IntToStr(nb) + '.');
                 end;
            end;
       end;
     until(sortie);
     readlnPerso();

  end;

end.
