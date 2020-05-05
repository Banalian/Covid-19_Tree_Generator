//**************************************************************************************************//
//**************************************************************************************************//
//***********************Code réalisé par Lilian "Banalian" Pouvreau********************************//
//*******************************Durant le mois d'avril 2020****************************************//
//**************************************************************************************************//








// import libraries
//import java.net.*;
//import java.io.*;
 
 
int sizey=800;
//URL url;
HScrollbar hs1;
PImage img;
PImage explications;
PImage credits;
PImage cancel32;
PImage cancel64;

boolean expC = false;
boolean credC = false;
boolean drawexp=true;
boolean drawcred=true;

Checkbox cbPeople = new Checkbox(40,500,0);
//Checkbox cbSizey = new Checkbox(40,100,1);

int daychoosen;
float sliderpos;
int nombreTotal = 0, nombreMorts = 0, nombreGueris = 0;
float popMonde= 7800000000.;

JSONArray tableau;
JSONObject urlFile, newurlFile, tempObj, dateObj;
IntList feuillesCas = new IntList();
IntList feuillesMorts = new IntList();
IntList feuillesGueris = new IntList();
float[][] caslist = new float[7784][3];
float[][] cherrylist = new float[7784][3];
float[][] deathlist = new float[7784][3];
int clIndex = 0;
int lIndex = 0;
int dlIndex = 0;
int nbleaf0=0, nbleaf1=0,nbleaf3=0,nbcherry=0;

ArrayList <JSONArray> listepays =  new ArrayList<JSONArray>();
String pays[] = { "Afghanistan", "Albania", "Algeria", "Andorra", "Angola", "Antigua and Barbuda", "Argentina", "Armenia", "Australia", 
                  "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Benin",  "Bhutan", 
                  "Bolivia", "Bosnia and Herzegovina", "Brazil", "Brunei", "Bulgaria",  "Burkina Faso", "Cabo Verde", "Cambodia", 
                  "Cameroon", "Canada", "Central African Republic", "Chad", "Chile", "China", "Colombia", "Congo (Brazzaville)", 
                  "Congo (Kinshasa)", "Costa Rica", "Cote d'Ivoire", "Croatia", "Diamond Princess", "Cuba", "Cyprus", "Czechia",
                  "Denmark",  "Djibouti", "Dominican Republic", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea",
                  "Estonia", "Eswatini", "Ethiopia", "Fiji", "Finland", "France", "Gabon", "Gambia", "Georgia", "Germany", "Ghana",
                  "Greece", "Guatemala", "Guinea", "Guyana", "Haiti", "Holy See", "Honduras", "Hungary", "Iceland", "India", "Indonesia",
                  "Iran", "Iraq", "Ireland", "Israel", "Italy", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Korea, South",
                  "Kuwait", "Kyrgyzstan", "Latvia", "Lebanon", "Liberia", "Liechtenstein","Lithuania","Luxembourg","Madagascar","Malaysia",
                  "Maldives","Malta","Mauritania","Mauritius","Mexico","Moldova","Monaco","Mongolia","Montenegro","Morocco","Namibia",
                  "Nepal","Netherlands","New Zealand","Nicaragua","Niger","Nigeria","North Macedonia","Norway","Oman","Pakistan","Panama",
                  "Papua New Guinea","Paraguay","Peru","Philippines","Poland","Portugal","Qatar","Romania","Russia","Rwanda","Saint Lucia",
                  "Saint Vincent and the Grenadines","San Marino","Saudi Arabia","Senegal","Serbia","Seychelles","Singapore","Slovakia",
                  "Slovenia","South Africa","Spain","Sri Lanka","Sudan","Suriname","Sweden","Switzerland", "Taiwan*","Tanzania","Thailand",
                  "Togo","Trinidad and Tobago","Tunisia","Turkey","Uganda","Ukraine","United Arab Emirates","United Kingdom","Uruguay","US",
                  "Uzbekistan","Venezuela","Vietnam","Zambia","Zimbabwe","Dominica","Grenada","Mozambique","Syria","Timor-Leste","Belize",
                  "Laos","Libya","West Bank and Gaza","Guinea-Bissau","Mali","Saint Kitts and Nevis","Kosovo","Burma","MS Zaandam","Botswana"
                  ,"Burundi","Sierra Leone","Malawi","South Sudan","Western Sahara","Sao Tome and Principe","Yemen"} ;
                  //je n'ai pas réussi à lire un .txt, j'avais un NULLpointer apres 83-84 lignes. 
                  
                  
void setup() {
  
  size(1000,800);
  surface.setLocation(400, 100);
  img = loadImage("banalian.png");
  explications = loadImage("explications.png");
  credits = loadImage("credits.png");
  cancel32 = loadImage("cancel32.png");
  cancel64 = loadImage("cancel64.png");
  background(255,255,255);
  fill(255,0,0);
  stroke(255,0,0);
  text("Loading", 480,400);
  L=(int)(height*.25);
  strokeJoin(ROUND);// les jointure entre 2 segment sreont arrondi
  
  
  hs1 = new HScrollbar(50, 50, width-100, 16      , 1);
  //      Slider      (x , y , largeur  , hauteur , "loose" : lache ou pas)
  
  
  
//..............................Ancienne Récupération des informations d'un site internet...........................//
 /* try {
    //creation d'un objet de type URL, dont on renseigne le lien
    
    //URL url = new URL("https://www.worldometers.info/coronavirus/");
    URL url = new URL("https://ncov2019.live/data/global");
    //URL url = new URL("https://www.worldometers.info/world-population/");
    //on se connecte en se faisant passer pour un navigateur, afin de récuperer le code HTML et le déchiffrer
    URLConnection conn = url.openConnection();
    conn.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.1; en-GB;     rv:1.9.2.13) Gecko/20101203 Firefox/3.6.13 (.NET CLR 3.5.30729)");
    
    //on récupere le code HTML
    BufferedReader in = new BufferedReader
      (new InputStreamReader(conn.getInputStream(), "UTF-8"));
 
    String htmlText="",nombreTotal="",casAjd="",pr100casAjd="",morts="",mortAjd="",pr100mortAjd="",gueris="",serieux="";
 
 //ayant déjà lu le code, je sais quelle ligne je dois récuperer pour obtenir les nombres que je veux
 //trim sert à enlever tout les espaces
    for(int i=0;i<355;i++){
      htmlText = in.readLine ();
       switch(i) {
          case 333:
            nombreTotal = trim(htmlText);
            break;
          case 336:
            casAjd = trim(htmlText);
            break;
          case 339:
            pr100casAjd = trim(htmlText);
            break;
          case 342:
            morts = trim(htmlText);
            break;
          case 345:
            mortAjd = trim(htmlText);
            break;
          case 348:
            pr100mortAjd = trim(htmlText);
            break;
          case 351:
            gueris = trim(htmlText);
            break;
          case 354:
            serieux = trim(htmlText);
            break;
          default:
            
       }
      //System.out.println(htmlText);
    }
    //System.out.println(htmlText);
    
    //nombreTotal = trim(htmlText);
    System.out.println("Nombre de cas : "+nombreTotal);
    System.out.println("Nombre de Morts : "+morts);
    System.out.println("Nombre de gueris : "+gueris);
    System.out.println("Nombre de cas serieux : "+serieux);

    
    
    //while ( (htmlText = in.readLine ()) != null) {
      // on affiche TOUT le code, soit beaucoup de ligne ici
      //System.out.println(htmlText);
    //}
    in.close();
  } 
  //en cas d'erreur, explication de celle-ci
  catch (MalformedURLException e) {
    e.printStackTrace();
  } 
  catch (IOException e) {
    e.printStackTrace();
  }
  */
//..................................................................................................................//  
  
  //..............................Nouvelle Récupération des informations d'un site internet...........................//
  urlFile = loadJSONObject("https://pomber.github.io/covid19/timeseries.json");
 
  for(int i = 0;i<pays.length;i++){
    //println(i);
    if(pays[i].length()==0)println("string vide pour i = "+i);
    listepays.add(urlFile.getJSONArray(pays[i]));
    tableau = listepays.get(i);
    tempObj = tableau.getJSONObject(tableau.size()-1);
    //mise à jour du nombre
    nombreTotal += tempObj.getInt("confirmed");
    nombreMorts += tempObj.getInt("deaths");
    nombreGueris += tempObj.getInt("recovered");
  }
   dateObj = tableau.getJSONObject(tableau.size()-1);
 
  println("number of confirmed cases : "+nombreTotal+" and deaths : "+nombreMorts+" and saved : " + nombreGueris);
  //..................................................................................................................//
  
  //dessiner l'arbre
  Draw();
  println("leafs : "+nbleaf);
  
  
  
  thread("udpdateEachHour");
  
  
}


void mousePressed(){
  
  cbPeople.click();
  //cbSizey.click();
  
  //pas le droit de le faire
  /*if(cbSizey.isChecked()){
    size(1000,700);
    sizey=700;
  }else{
    size(1000,800);
    sizey=800;
  }*/
  
  
  if(sizey==700){
    if(mouseX>110 && mouseX <164 && mouseY>(height-75) && mouseY <(height-11)){
      expC=!expC;
      if (!drawexp){
        drawexp = true;
      }
    }
    
    if(mouseX>(width -290) && mouseX <(width -258) && mouseY>(height - 45) && mouseY <(height - 13)){
      credC=!credC;
      if (!drawcred){
        drawcred = true;
      }
    }
  
  }else{
    if(mouseX>20 && mouseX <84 && mouseY>(height-75) && mouseY <(height-11)){
      expC=!expC;
      if (!drawexp){
        drawexp = true;
      }
    }
    
    if(mouseX>(width -240) && mouseX <(width -208) && mouseY>(height - 45) && mouseY <(height - 13)){
      credC=!credC;
      if (!drawcred){
        drawcred = true;
      }
    }
  
  }

  
 if(mouseButton==RIGHT){
   
   fill(255,0,0);
   textSize(32);
   text("Loading",100,100);
   delay(10);
   Draw();
   surface.setLocation(410, 100);
   delay(50);
   surface.setLocation(400, 100);
   println("Leafs : "+nbleaf);
 }
}

void draw(){
   hs1.update();
   hs1.display();
   
   cbPeople.render();
   //cbSizey.render();
   
   //println(hs1.getPos());
   sliderpos = hs1.getPos();
   daychoosen = (int)map(sliderpos,50,950,0,tableau.size()-1);
   //println(tableau.size()-1);
   //println(daychoosen);
   
   dateObj = tableau.getJSONObject(daychoosen);
   //println(dateObj.getString("date"));
   
   if(credC){
     if(drawcred){
        fill(255);
        stroke(0);
        if(sizey==700){
          rect(width-300, height-80,245,75);
          fill(0);
          textSize(14);
          text("Banalian icon by Diego Macgregor",width - 290,height -65);
          textSize(15);
          text("Icons from friconix.com",width - 250,height -45);
          text("Data given by Pomber",width - 250,height -30);
          text("OG tree by Emory Lewis",width - 250,height -15);
          image(cancel32,width -290, height - 45);
        }else{
          rect(width-250, height-80,245,75);
          fill(0);
          textSize(14);
          text("Banalian icon by Diego Macgregor",width - 240,height -60);
          textSize(15);
          text("Icons from friconix.com",width - 200,height -45);
          text("Data given by Pomber",width - 200,height -30);
          text("OG tree by Emory Lewis",width - 200,height -15);
          image(cancel32,width -240, height - 45);
        }
        
     }
    
  }else{
    if(drawcred){
      fill(0,200,0);
      stroke(0,200,0);
      if(sizey==700){
        rect(width-300, height-80,245,75);
        fill(0);
        textSize(9);
        text("Click me ! ",width-295,height -50);
        textSize(15);
        text("Made by         Banalian",width-250,height -25);
        image(img, width-185, height-55);
        image(credits, width -290, height - 45);
        drawcred = false;
      
      }else{
        rect(width-250, height-80,245,75);
        fill(0);
        textSize(9);
        text("Click me ! ",width-245,height -50);
        textSize(15);
        text("Made by         Banalian",width-200,height -25);
        image(img, width-135, height-55);
        image(credits, width -240, height - 45);
        drawcred = false;
      
      
      }
      
    }
  }
  if(sizey==700){
    if(expC){
      if(drawexp){
          fill(255);
          stroke(0);
          rect(65, height-80,250,75);
          fill(0);
          text("This tree represents the",136,height-55);
          text("world population and",136,height-40);
          text("how Covid-19 change it",136,height-25);
          image(cancel64,70,height-75);
      }
    }else{
      if(drawexp){
        fill(0,200,0);
        stroke(0,200,0);
        rect(65,height-80,250,75);
        fill(0);
        text("Click me ! ",135,height -40);
        stroke(0,0,127);
        image(explications, 70,height-75);
        drawexp = false;
      }
      
    }
  }else{
    if(expC){
      if(drawexp){
          fill(255);
          stroke(0);
          rect(15, height-80,250,75);
          fill(0);
          text("This tree represents the",86,height-55);
          text("world population and",86,height-40);
          text("how Covid-19 change it",86,height-25);
          image(cancel64,20,height-75);
      }
    }else{
      if(drawexp){
        fill(0,200,0);
        stroke(0,200,0);
        rect(15,height-80,250,75);
        fill(0);
        text("Click me ! ",85,height -40);
        stroke(0,0,127);
        image(explications, 20,height-75);
        drawexp = false;
      }
      
    }
  }
    
}

void viderlistepays(){
  for (int i = listepays.size() - 1; i >= 0; i--) {    
      listepays.remove(i);
  }

}
void getDataOfDay(){
  println(dateObj.getString("date"));
  viderlistepays();
  nombreTotal = nombreMorts = nombreGueris = 0;
  
  //urlFile = loadJSONObject("https://pomber.github.io/covid19/timeseries.json");
 
  for(int i = 0;i<pays.length;i++){
    //println(i);
    if(pays[i].length()==0)println("string vide pour i = "+i);
    listepays.add(urlFile.getJSONArray(pays[i]));
    tableau = listepays.get(i);
    tempObj = tableau.getJSONObject(daychoosen);
    //mise à jour du nombre
    nombreTotal += tempObj.getInt("confirmed");
    nombreMorts += tempObj.getInt("deaths");
    nombreGueris += tempObj.getInt("recovered");
  }
  println("number of confirmed cases : "+nombreTotal+" and deaths : "+nombreMorts+" and saved : " + nombreGueris);
}



void udpdateEachHour(){
  while(true){
    delay(7200000);
    newurlFile = loadJSONObject("https://pomber.github.io/covid19/timeseries.json");
    if(newurlFile != urlFile){
      urlFile = newurlFile;
      getDataOfDay();
    }
  }
  
  
}





//----------------------------------------------------------------------//
// arbre de Emorylewis

//tout les commentaires ont été créer à la main, il n'y en a pas dans le programme original

//principe des "matrix" : sauvegarde l'etat de la grille, puis en creer une copie, comme une pile de grille, et on utilise que la grille du dessus. permet d'utiliser facilement rotate(),translate() et scale() sans déformer la grille originelle
//translate : deplace la grille en x et y, pour changer l'origine
//scale : change l'unité de mesure de la grille
//rotate : rotationne la grille



int L;

int nbleaf=0;


void Draw(){
  
  
  nbleaf=0;
  clIndex = 0;
  lIndex = 0;
  dlIndex = 0;
  nbleaf0=0;
  nbleaf1=0;
  nbleaf3=0;
  nbcherry=0;
  backG();
  
  
  
  if(!cbPeople.isChecked()){
  
      //choix des leafs touchées
      //for(int i=feuillesCas.size()-1;i>=0;i--)feuillesCas.remove(i);
      feuillesCas.clear();
      
      for(int i = 0;i<nombreTotal/1000000;i++){
        int rdnb = (int)random(0,7785);
        while(feuillesCas.hasValue(rdnb))rdnb = (int)random(0,7785);
        feuillesCas.append(rdnb);
            
      }
      feuillesCas.sort();
      
      
      //Choix des feuilles mortes
      //for(int i=feuillesMorts.size()-1;i>=0;i--)feuillesMorts.remove(i);
      feuillesMorts.clear();
      
      for(int i = 0;i<nombreMorts/1000000;i++){
        int rdnb = (int)random(0,feuillesCas.size());
        while(feuillesMorts.hasValue(feuillesCas.get(rdnb))) rdnb = (int)random(0,feuillesCas.size());
        feuillesMorts.append(feuillesCas.get(rdnb));
            
      }
      feuillesMorts.sort();
      
      
      //choix des feuilles gueris
      //println(feuillesGueris.size());
      //println(feuillesGueris.get(feuillesGueris.size()));
      //if(feuillesGueris.size()>0)for(int i=feuillesGueris.size()-1;i>=0;i--)feuillesGueris.remove(i);
      feuillesGueris.clear();
      
    
      
      for(int i = 0;i<nombreGueris/1000000;i++){
        int rdnb = (int)random(0,feuillesCas.size());
        while(feuillesGueris.hasValue(feuillesCas.get(rdnb)) || feuillesMorts.hasValue(feuillesCas.get(rdnb)))rdnb = (int)random(0,feuillesCas.size());
        feuillesGueris.append(feuillesCas.get(rdnb));
            
      }
      feuillesGueris.sort();
  
  }
   //<>// //<>// //<>//
   

  pushMatrix();
  translate(width/2, height*.825);//déplacement de l'origine jusqu'au départ de l'arbre
  tree1(0, 0, L, -90);
  //roots(0,0,L);
  popMatrix();
  
  if(sizey==700){
    for(int i=dlIndex;i>0;i--){
      leaf(random(330,width-325),random(175, 300),random(0,360),4);
    }  
  }else{
    for(int i=dlIndex;i>0;i--){
      leaf(random(280,width-275),random(175, 300),random(0,360),4);
    }  
  }

  /*for(;dlIndex>=0;dlIndex--){
    deathlist[dlIndex][0] = 0;
    deathlist[dlIndex][1] = 0;
    deathlist[dlIndex][2] = 0;
  }*/
  
  fill(0,0,127);
  textSize(15);
  text("Mouse Right-click to redraw the tree",5,20);
  
  String datetochange = dateObj.getString("date");
  String changedDate  = datetochange.substring(7)+"/"+datetochange.substring(5,6)+"/"+datetochange.substring(0,4);
  
  text("Date : "+changedDate,width-180,40);
  
  leaf(width-275,height-220,-90,0);
  text("Normal  : "+(cbPeople.isChecked() ? 0 : (popMonde-nombreTotal) )+"/"+(cbPeople.isChecked() ? 0 : nbleaf - nbleaf1-nbleaf3-nbcherry )+" leafs",width-250,height-220);
  leaf(width-275,height-200,-90,1);
  text("Cases  : "+nombreTotal+"/"+(cbPeople.isChecked() ? nbleaf-nbleaf3-nbcherry : nbleaf1)+" leafs",width-250,height-200);
  if(sizey==700){
    leaf(width-275,height-575,-90,4);
  }else{
    leaf(width-275,height-675,-90,4);
  }
  
  text("Deaths : "+nombreMorts+"/"+nbleaf3+" leafs",width-250,height-175);
  cherry(width-275,height-160,0);
  text("Cured  : "+nombreGueris+"/"+nbcherry+" cherrys",width-250,height-150);
  
  
  //if(cbPeople.isChecked()){
    text("Caution : long loads if checked",5,490);
  //} 
  drawcred =true;
  drawexp = true;
  
  
  
  
  
  
}


void backG(){
  L=(int)(height*.25);
  
  //choix de 2 couleurs
  color c1=color(215, 245, 255);
  color c2=color(90,175,255);
  
  for(int i=height;i>=0;i--){
    float l=map(i,(height),0,0,1);
    color c= lerpColor(c1,c2,l); //création d'une couleur "dégradé"
    stroke(c);
    line(0,i,width,i); //on dessine un trait très lont avec cette couleur, ce qui créée l'illusion d'un dégradé au final
  }
  noStroke();
  fill(0, 200, 0);
  
  //création du sol
  beginShape();
  vertex(0, height);
  vertex(0, height*.9);
  bezierVertex(0, height*.9, width*.25, height*.8, width/2, height*.8);
  bezierVertex((width/2), height*.8, width*.75, height*.8, width, height*.9);
  vertex(width, height);
  endShape(CLOSE);
}

void tree1(float x, float y, float l, float ang) {
  float ex=x+(l*cos(radians(ang)));
  float ey=y+(l*sin(radians(ang)));
  strokeWeight(1);
  stroke(50, 10, 0);
  fill(75, 35, 0);
  pushMatrix();
  translate(x,y);
  rotate(radians(ang)); // la rotation est en radian, donc on transforme notre chiffre (ex :  premiere utilisation : radion(90);)
  rect(-(l/10),-(l/10),l*1.2,l/5,l/10);
  popMatrix();
  float a=random(20, 50);
  float a1=random(-50, -20);
  if(l==L){
    tree1(ex, ey, l/1.5, ang); //Tronc
   
  }
  if ((l/1.5)>8) {
    tree1(ex, ey, l/1.5, a+ang); //dessiner une branche à droite
    tree1(ex, ey, l/1.5, a1+ang);  //dessiner une branche à gauche
    a=random(20, 50)+ang;
    a1=random(-50, -20)+ang;
    tree1(ex, ey, l/2, (a));
    tree1(ex, ey, l/2, (a1)); //branche plus petite
    
  }
  if (((l/1.5)>=66)) {
    a=random(20, 50)+ang;
    a1=random(-50, -20)+ang;
    tree1(ex, ey, l/3, (a));
    tree1(ex, ey, l/3, (a1));
    
  }
  if (l==L) {
    a=random(10, 30)+ang;
    a1=random(-30, -10)+ang;
    tree1(ex, ey, l/4.5, (a));
    tree1(ex, ey, l/4.5, (a1));
    
  }
  
  if ((l/1.5)<=12) {
    
    if(cbPeople.isChecked()){
      /*int randnb = (int)random(0,4);
      if (randnb==4){
        cherry(ex,ey,ang);
      }else{
        leaf(ex, ey, ang,randnb); //dessiner plusieurs feuilles à l'extremité
      }
      */
      float newMorts = nombreMorts*7784/nombreTotal;
      float newGueris = nombreGueris*7784.0/nombreTotal;
      
      //Choix des feuilles mortes
      //for(int i=feuillesMorts.size()-1;i>=0;i--)feuillesMorts.remove(i);
      feuillesMorts.clear();
      
      for(int i = 0;i<newMorts;i++){
        int rdnb = (int)random(0,7785);
        while(feuillesMorts.hasValue(rdnb)) rdnb = (int)random(0,7785);
        feuillesMorts.append(rdnb);
            
      }
      feuillesMorts.sort();
      
      
      //choix des feuilles gueris
      //println(feuillesGueris.size());
      //println(feuillesGueris.get(feuillesGueris.size()));
      //if(feuillesGueris.size()>0)for(int i=feuillesGueris.size()-1;i>=0;i--)feuillesGueris.remove(i);
      feuillesGueris.clear();
      
    
      
      for(int i = 0;i<newGueris;i++){
        int rdnb = (int)random(0,7785);
        while(feuillesGueris.hasValue(rdnb) || feuillesMorts.hasValue(rdnb))rdnb = (int)random(0,7785);
        feuillesGueris.append(rdnb);
            
      }
      feuillesGueris.sort();
      
      
      
      if(feuillesGueris.hasValue(nbleaf)){
        
        cherry(ex,ey,ang);
        nbcherry++;
        //println("feuille Guerie");
      }else if(feuillesMorts.hasValue(nbleaf)){
        //leaf(ex,ey,ang,3);
        dlIndex++;
        nbleaf3++;
        //println("feuille Morte");
      }else {
        leaf(ex,ey,ang,1);
        nbleaf1++;
        //println("feuille touchee");
      }
      
      
    }else{

      if(feuillesGueris.hasValue(nbleaf)){
        
        //cherrylist[clIndex][0]=ex;
        //cherrylist[clIndex][1]=ey;
        //cherrylist[clIndex][2]=ang;
        //clIndex++;
        cherry(ex,ey,ang);
        nbcherry++;
        //println("feuille Guerie");
      }else if(feuillesMorts.hasValue(nbleaf)){
        leaf(ex,ey,ang,3);
        nbleaf3++;
        //println("feuille Morte");
      }else if(feuillesCas.hasValue(nbleaf)){
        
        //caslist[lIndex][0]=ex;
        //caslist[lIndex][1]=ey;
        //caslist[lIndex][2]=ang;
        //lIndex++;
        leaf(ex,ey,ang,1);
        nbleaf1++;
        //println("feuille touchee");
      }else{
        leaf(ex,ey,ang,0);
        nbleaf0++;
        //println("feuille normale");
      }
      

    
    }
    
    
    
  }
}

void leaf(float x, float y, float ang,int etat){
  nbleaf++;
  switch(etat) {
    case 0 : fill(0,155,0);
             stroke(0,125,0);
             break;//normal
             
    case 1 : fill(250, 143, 4);
             stroke(246, 77, 13);
             break;//contaminé
             
    case 2 : fill(219,167,46);
             stroke(201, 151, 32);
             break;//contaminé grave
             
    case 3 : dlIndex++;
             break;//morts
             
    case 4 : fill(152,72,43);
             stroke(122,58,34);
             y+=height-300;
             break;//morts (
  
  }
    
  for(int i= -1;i<2;i++){//i<x : nombre de feuille -1
    float l=random(10,19);
    float a=random(30,61);
    pushMatrix();
    translate(x,y);
    rotate(radians(ang+(i*a)));
    //rotate(radians(ang));
    
    
    //dessin d'une feuille
    beginShape();
    vertex(0,0);
    bezierVertex(0,0,(l/4),(l/2),l,0);
    bezierVertex(l,0,(l/4),-(l/2),0,0);
    vertex(0,0);
    endShape();
    
    //stroke(0,125,0);
    line(0,0,12,0);
    popMatrix();
  }
}


void cherry(float x, float y, float ang){
    nbleaf++;
    float l=random(10,19);
    float a=random(30,61);
    pushMatrix();
    translate(x,y);
    rotate(radians(ang+a));
    //rotate(radians(ang));
    stroke(0,125,0);
    line(0,0,-5,10);
    line(0,0,7,8);
    stroke(200,0,0);
    fill(220,0,0);
    circle(-5,10,l/(random(20,30)/10));
    circle(7,8,l/(random(20,30)/10));
    popMatrix();
}

void roots(float x, float y, float l){
  stroke(75, 35, 0);
  for(int i=0;i<4;i++){
    int a=(int)random(5,9);
    float ang=-(random(0,30))-(45*i);
    float x1=0;
    float y1=0;
    float ex=x1+(-l/10)*cos(radians(ang));
    float ey=y1+(-l/10)*sin(radians(ang));
    for(int j=0;j<a;j++){
      float w=(l/2)/(j+3);
      strokeWeight(w);
      line(x1,y1,ex,ey);
      x1=ex;
      y1=ey;
      ang+=(random(-25,25));  
      ex=x1+(-l/10)*cos(radians(ang));
      ey=y1+(-l/10)*sin(radians(ang));
    }
  }
}
//-----------------------------------------------------------------------------------------------------------------//

//------------------CLASSE TROUVEE SUR PROCESSING.ORG  "https://processing.org/examples/scrollbar.html"-------------//
class HScrollbar {
  int swidth, sheight;    // width and height of bar
  float xpos, ypos;       // x and y position of bar
  float spos, newspos;    // x position of slider
  float sposMin, sposMax; // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;
  
  
  
  boolean newposition = false;// pour savoir s'il y a un changement

  HScrollbar (float xp, float yp, int sw, int sh, int l) {
    swidth = sw;
    sheight = sh;
    int widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp;
    ypos = yp-sheight/2;
    spos = xpos + swidth/2 - sheight/2;
    newspos = spos;
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;
    newspos = sposMax;
    loose = l;
  }

  void update() {
    if (overEvent()) {
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over) {
      locked = true;
      newposition = true;
    }
    if (!mousePressed) {
      locked = false;
      if(newposition){
        getDataOfDay();
        Draw();
        newposition = false;
      }
    }
    if (locked) {
      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }
  }

  float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }

  boolean overEvent() {
    if (mouseX > xpos && mouseX < xpos+swidth &&
       mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    noStroke();
    fill(204);
    rect(xpos, ypos, swidth, sheight);
    if (over || locked) {
      fill(0, 0, 0);
    } else {
      fill(102, 102, 102);
    }
    rect(spos, ypos, sheight, sheight);
  }

  float getPos() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    return spos * ratio;
  }
  
  void setPos(int val){
    spos = newspos  = val;
  }
}

//---------------------------------------------------------//


//-------------------Checkbox par TfGuy44---------------------//
class Checkbox {
  int x, y, etat;
  boolean b;
  Checkbox(int _x, int _y, int _etat){
    x = _x;
    y = _y;
    etat=_etat;
    b = false;
  }
  void render(){
    fill(255);
    rect(x-5,y-5,150,50);
    stroke(255);
    fill(isOver()?128:64);
    rect(x, y, 20, 20);
    if(b){
      line(x, y, x+20, y+20);
      line(x, y+20, x+20, y);
    }
    
    if(etat==1){
      if(b){
        fill(25);
        text("Y Screen : 700",x+25,y+20);
      }else{
        fill(25);
        text("Y Screen : 800",x+25,y+20);
      }
    }else{
      if(b){
        fill(225);
        text("Real World Scale",x+25,y+20);
        fill(25);
        text("Cases Scale",x+25,y+40);
      }else{
        fill(25);
        text("Real World Scale",x+25,y+20);
        fill(225);
        text("Cases Scale",x+25,y+40);
    }
    }
    
  }
  void click(){
    if(isOver()){
      b=!b;
    nbleaf=0;
    Draw();
    }
  }
  boolean isOver(){
    return(mouseX>x&&mouseX<x+20&&mouseY>y&&mouseY<y+20);
  }
  
  boolean isChecked(){
    return b;
  }
}
