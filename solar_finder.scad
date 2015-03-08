
module aronde(longueur,h1,h_tot,largeur_base,largeur_haut)
{
hauteur_base_1=h1;
hauteur_base_2=h_tot;

dy=(largeur_base-largeur_haut)*0.5;

rotate([90,0,90])
linear_extrude(height=longueur)
{
polygon(points = [[0,0],[largeur_base,0],
                  [largeur_base,hauteur_base_1],
                   [largeur_base-dy,hauteur_base_2],
                  [dy,hauteur_base_2],[0,hauteur_base_1]]);
}
}


module bout(taille,ep,diam)
{
  r=2;
  translate([0,-taille/2,r])
  difference()
  {
    translate([0,0,0])
    rotate([0,-90,0])
    minkowski()
    {
      cube([taille,taille,ep],$color="blue");
      cylinder(h=ep,r=r,$fn=50);
    }
    translate([-50,taille/2,taille/2])
    rotate([0,90,0])
    cylinder(h=100,d=diam,$fn=100);
  }
}

// queue d'aronde
h_aronde=10;
L_aronde=40;
largueur_aronde=30;
aronde(L_aronde,3,h_aronde,largueur_aronde,22);

taille=45;
ep=2;
diam=3;
l_tot=100;
longueur_barre = l_tot-2*ep;
largeur_barre=20;

h_rehausse=5;

dx=-(longueur_barre-L_aronde)/2;
dy=(largueur_aronde-largeur_barre)/2;

translate([0,dy,h_aronde])  
cube([L_aronde,largeur_barre,h_rehausse]);
translate([dx,dy,h_aronde+h_rehausse])
{
  cube([longueur_barre,largeur_barre,10]);
  translate([0,largeur_barre/2,0])
  bout(taille,ep,diam);
  translate([longueur_barre+2*ep,largeur_barre/2,0])
  bout(taille,ep,diam);
}
