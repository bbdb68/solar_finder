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

// queue d'aronde
h_aronde=10;
L_aronde=40;
largueur_aronde=30;
aronde(L_aronde,3,h_aronde,largueur_aronde,22);

// rehausse
l_tot=100;
longueur_barre = l_tot;
largeur_barre=20;

h_rehausse=5;

dx=-(longueur_barre-L_aronde)/2;
dy=(largueur_aronde-largeur_barre)/2;
ecart=20;
translate([0,dy,h_aronde])  
cube([L_aronde,largeur_barre,h_rehausse]);

// tenon de la rehausse
h_tenon=10;
l_tenon=25;
ep_tenon=3;
tx= L_aronde/2;
ty = largueur_aronde/2;
tz=h_tenon/2+h_rehausse+h_aronde;
translate([tx,ty,tz])
cube([l_tenon,ep_tenon,h_tenon],center=true);


// poutre centrale
translate([0,0,40])
translate([tx,ty,0])
difference()
{
    union()
    {
      cube([longueur_barre,largeur_barre,h_tenon],center=true);
      cube([longueur_barre+2*ep_tenon,largeur_barre/2,h_tenon/3],center=true);
    }
    cube([l_tenon,ep_tenon,h_tenon],center=true);
}

// pieces de bout

module extremite()
{
   difference()
   {
    cube([ep_tenon,40,40],center=true);
    // trou de visee
    rotate([0,90,0])
    cylinder(d=3,h=100,center=true,$fn=100);
    // trou pour le tenon
    translate([0,0,-13])       
   cube([100,largeur_barre/2,h_tenon/3],center=true);
   }
}
translate([-40,largueur_aronde/2,55])
extremite();
translate([+80,largueur_aronde/2,55])
extremite();