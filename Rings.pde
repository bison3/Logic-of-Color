Ring[] rings; //declares array
int numRings = 75;
int currentRing = 0;

/*void mouseMoved() {
  rings[currentRing].start(mouseX, mouseY);
  currentRing++;
  if (currentRing >= numRings) {
    currentRing = 0;
  }
}*/
///////////////////////////////
float xRing;
float yRing;

void triggerRing() {
  xRing = random(300, width-300);
  yRing = random(200, height-200);
  rings[currentRing].start(xRing, yRing);
  currentRing++;
  if (currentRing >= numRings) {
    currentRing = 0;
  }
}
/////////////////////////////////

class Ring {
  float x, y, diameter;
  boolean on = false; //turns display on and off
  int selector;
  
  void start(float xpos, float ypos) {
    x = xpos;
    y = ypos;
    diameter = 1;
    selector = int(random(0, 3));
    on = true;
  }

  void grow() {
    if (on == true) {
      diameter += .5;
      if (diameter > 50) {
        on = false;
        diameter = 1;
      }
    }
  }

  void display() {
    if (on == true) {
      noFill();
      strokeWeight(5);
      stroke(randomColor(50, 255), random(125));
      if (selector == 0) {
        ellipse(x, y, diameter, diameter);
      } else if (selector == 1) {
        triangle(x, y, x+diameter, y, (x+diameter/2), y+diameter);
      } else {
        rect(x,y, diameter, diameter);
      }
      //text("♥",x,y);
      /*translate(mouseX, mouseY);
      for (int i=0; i<61; i++) {
        float x = 0.25 * (-pow(i,2) + 40*i + 1200)*sin((PI*i)/180);
        float y = -0.25 * (-pow(i,2) + 40*i + 1200)*cos((PI*i)/180);
        point(x,y); // use these to place your little hearts
        point(-x,y); // use these to place your little hearts
      }*/
    }
  }
}
