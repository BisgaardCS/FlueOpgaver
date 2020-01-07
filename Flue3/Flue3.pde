//Array list som indeholder objekter
ArrayList<Flue> flueListe = new ArrayList<Flue>();

void setup() {
  size(800, 600);
}

// I draw ser man et loop som laver en ny plads
//og sammentidig tegner en ny grøn flue på den nye plads som er lavet
void draw() {
  fill(0, 255, 0);
  clear();
  for (int i=0; i<flueListe.size(); i++) {
    Flue f = flueListe.get(i);
    f.tegnFlue();
    f.Ryk();
  }
}

//Laver en random flue og placere den tilfældigt ved klik af en knap
void keyPressed() {
  if (key=='e') {
    flueListe.add(new Flue(1.8));
  } else {
    flueListe.add(new Flue());
  }
}

//Laver en flue der hvor musens placering er
void mousePressed() {
  flueListe.add(new Flue(mouseX, mouseY));
}

//Flue class
class Flue {
  //Variabler for min flue class
  int xSpeed = 3; 
  int ySpeed = 3;
  float positionX, positionY;
  float RykketDistance;
  float vinkel = 0; 
  float size = 1;
  int H = 599; 
  int W = 799;
  int x = 0;
  int y = 0; 

  //X og Y position af fluen, samt vinklens angivelse 
  Flue() {
    positionX  = random(0, height);
    positionY  = random(0, width);
    vinkel     = random(0, 2*PI);
  }

  //Angivelse af varierende x og y værdi for fluen ved placering
  Flue(float a, float b) {
    positionX = a;
    positionY = b;
    vinkel    = random(0, 2*PI);
  }

  //Scale
  Flue(float scale) {
    positionX  = random(0, height);
    positionY  = random(0, width);
    vinkel     = random(0, 2*PI);
    size = scale;
  }

  //Her sætter du fluernes fart, som den flyver med
  void Ryk() {
    RykketDistance = RykketDistance + xSpeed;

    //Dette er bounce af fluerne på væggen
    if ((cos(vinkel) * (RykketDistance*size)  + positionX) > width ||
      (cos(vinkel) * (RykketDistance*size)  + positionX) < 0) {
      xSpeed *= -1;
    }
    if ((sin(vinkel) * (RykketDistance*size)  + positionY) > height ||
      (sin(vinkel) * (RykketDistance*size)  + positionY) < 0) {
      xSpeed *= -1;
    }
  }

  //Dette er her fluen tegnes
  void tegnFlue() {
    pushMatrix();
    translate(positionX, positionY);
    rotate(vinkel);
    translate(RykketDistance, 0);

    scale(size);

    ellipse(0, 0, 20, 8);
    ellipse(0, 0-8, 15, 10);
    ellipse(0, 0+8, 15, 10);
    ellipse(0+6, 0, 8, 8);
    popMatrix();
    x = x + xSpeed; 
    y = y + ySpeed; 

    //Højre side af kassen
    if (positionX + 10 > W) { 
      xSpeed *= -1; 
      positionX = W -10;
    }
    
    //Venstre side af kassen
    if (positionX - 10 < 0) { 
      xSpeed *= -1; 
      positionX = 0 + 10;
    }
    
    //Nederste del af kassen
    if (positionY + 10 > H) { 
      ySpeed *= -1; 
      positionY = H - 10;
    }
    
    //Øverste del af kassen
    if (positionY - 10 < 0) { 
      ySpeed *= -1; 
      positionY = 0 + 10;
    }
  }
}
