program ProjetProgramme;

uses UnitMenu, UnitPersonnage, UnitMagasin, unitCombat, GestionEcran, unitLieu;

var
  position : TInformation;    //Variable qui stokera la position du personnage dans le jeu
  i : Integer;
  scenario : Integer; //Varaible qui definiera ou le joueur en est dans l'histoire


//until (position.nom = Blancherive) OR (position.nom = Marche_De_Blancherive) OR (position.nom = Porte_De_Blancherive) OR (position.nom = Chateau_De_Blancherive);

begin
  changerTailleConsole(200,60);
  menuInitial();            //Creation du Menu Principal avec selection du personnage
  position.nom := Blancherive;
  InterfaceInGame(position);        //Creation de l'interface
  scenario := 1;
  writeln();
  writeln('Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
  writeln('Pellentesque quis aliquet elit. Donec nec mattis lorem, placerat hendrerit augue.');
  writeln('Fusce feugiat risus quis augue bibendum, id sagittis velit commodo.');               //Affichage du scenario
  writeln('Pellentesque sed aliquet dui. Phasellus dictum, ante eu tincidunt pharetra,');
  writeln('nibh mi posuere diam, sit amet egestas urna nibh a mauris. ');
  writeln();
  writeln('Ou voulez-vous aller ?');
  writeln();

  initLieu(position);
  writeln();

  repeat
    readln(position.nom);
  until (position.nom = Marche_De_Blancherive) OR (position.nom = Porte_De_Blancherive);
  effacerEcran();

  while scenario = 1 do
    begin
    case position.nom of
    Porte_De_Blancherive :
      begin
      writeln();
      InterfaceInGame(position);
      writeln('Bienvenue devant la porte de Blancherive');
      writeln('Le professeur Chen vous dit que ce n''est pas le bon moment pour faire ça');
      writeln();
      writeln('Ou voulez-vous aller ?');
      writeln();

      initLieu(position);
      writeln();
      repeat
        readln(position.nom);
      until (position.nom = Blancherive);
      effacerEcran();
      end;

    Blancherive :
      begin
      writeln();
      InterfaceInGame(position);   //Creation de l'interface
      writeln('Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
      writeln('Pellentesque quis aliquet elit. Donec nec mattis lorem, placerat hendrerit augue.');
      writeln('Fusce feugiat risus quis augue bibendum, id sagittis velit commodo.');               //Affichage du scenario
      writeln('Pellentesque sed aliquet dui. Phasellus dictum, ante eu tincidunt pharetra,');
      writeln('nibh mi posuere diam, sit amet egestas urna nibh a mauris. ');
      writeln();
      writeln('Ou voulez-vous aller ?');
      writeln();

      initLieu(position);
      writeln();

      repeat
        readln(position.nom);
      until (position.nom = Marche_De_Blancherive) OR (position.nom = Porte_De_Blancherive);
      effacerEcran();
      end;


    Marche_De_Blancherive :
      begin
      writeln();
      InterfaceInGame(position);
      writeln('Bienvenue au marché de Blancherive');
      writeln('Malheuresmet il n'' a encore rien a faire ¯\_(ツ)_/¯');
      writeln();
      writeln('Ou voulez-vous aller ?');
      writeln();

      initLieu(position);              createCharacter
      writeln();
      repeat
        readln(position.nom);
      until (position.nom = Blancherive) OR (position.nom = Chateau_De_Blancherive);
      effacerEcran();
      end;

    Chateau_De_Blancherive :
      begin
      writeln();
      InterfaceInGame(position);
      writeln('Bienvenue au Chateux de Blancherive');
      writeln('Vous avez parler au jarl de la ville il vous dit d''aller a la porte de la ville');
      writeln('Pour aller afronter le dragon');
      scenario:= scenario+1;
      writeln();
      writeln('Ou voulez-vous aller ?');
      writeln();

      initLieu(position);
      writeln();

      repeat
        readln(position.nom);
      until (position.nom = Marche_De_Blancherive);
      effacerEcran();
      end;

    end;  // Fin du case
    end;  // Fin du while scenario = 1

  while scenario = 2 do
    begin
    case position.nom of
    Porte_De_Blancherive :
      begin
      writeln();
      InterfaceInGame(position);
      writeln('Bienvenue devant la porte de Blancherive');
      writeln('Un dragon vous attaque !!');
      writeln('le Combat n''estpas tout a fait près ^^');
      writeln();
      writeln('Ou voulez-vous aller ?');
      writeln();

      initLieu(position);
      writeln();
      repeat
        readln(position.nom);
      until (position.nom = Blancherive);
      effacerEcran();
      end;

    Blancherive :
      begin
      writeln();
      InterfaceInGame(position);   //Creation de l'interface
      writeln('Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
      writeln('Pellentesque quis aliquet elit. Donec nec mattis lorem, placerat hendrerit augue.');
      writeln('Fusce feugiat risus quis augue bibendum, id sagittis velit commodo.');               //Affichage du scenario
      writeln('Pellentesque sed aliquet dui. Phasellus dictum, ante eu tincidunt pharetra,');
      writeln('nibh mi posuere diam, sit amet egestas urna nibh a mauris. ');
      writeln();
      writeln('Ou voulez-vous aller ?');
      writeln();

      initLieu(position);
      writeln();

      repeat
        readln(position.nom);
      until (position.nom = Marche_De_Blancherive) OR (position.nom = Porte_De_Blancherive);
      effacerEcran();
      end;


    Marche_De_Blancherive :
      begin
      writeln();
      InterfaceInGame(position);
      writeln('Bienvenue au marché de Blancherive');
      writeln('Malheuresmet il n'' a encore rien a faire ¯\_(ツ)_/¯');
      writeln();
      writeln('Ou voulez-vous aller ?');
      writeln();

      initLieu(position);
      writeln();
      repeat
        readln(position.nom);
      until (position.nom = Blancherive) OR (position.nom = Chateau_De_Blancherive);
      effacerEcran();
      end;

    Chateau_De_Blancherive :
      begin
      writeln();
      InterfaceInGame(position);
      writeln('Bienvenue au Chateux de Blancherive');
      writeln('Vous avez parler au jarl de la ville il vous dit d''aller a la porte de la ville');
      writeln('Pour aller afronter le dragon');
      scenario:= scenario+1;
      writeln();
      writeln('Ou voulez-vous aller ?');
      writeln();

      initLieu(position);
      writeln();

      repeat
        readln(position.nom);
      until (position.nom = Marche_De_Blancherive);
      effacerEcran();
      end;

    end;  // Fin du case
    end;  // Fin du while scenario = 2




readln;
end.

