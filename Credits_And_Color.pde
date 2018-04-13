//////////////////
float endCreditStart;
color[] randCo;
float endCreditOffset;
int opacity = 255;
int ys = height + 700;
int yi = 50;
int textOffset = 250;
float sec;
float creditDuration = 8.0;

void titleDisplay() {
if (sec > 3.0 && sec < 8.0 || sec > endCreditStart + 3.0) {
    opacity--;
  }
  
  int letterOffset;
  int y = ys;
  fill(255, opacity);
  text(meta.author(), textOffset, y+=yi);
  
  y += yi;
  letterOffset = textOffset;
  for (int i = 0; i < meta.title().length(); i++) {
    if (frameCount % 5 == 0) {
      randCo[i] = randomColor(140, 220);
    }
    fill(randCo[i], opacity);
    text(meta.title().charAt(i), letterOffset, y);
    letterOffset += textWidth(meta.title().charAt(i));
  }
  
  fill(255, opacity);
  text(meta.album() + " (" + meta.date() + ")", textOffset, y+=yi);
}

//////////////////////
color randomColor(float lower, float upper) {
  float r, g, b;
  color returnCo;
  if (sec > 22.5) {
    r = random(lower, upper);
    g = random(lower, upper);
    b = random(lower, upper);
    returnCo = color(r, g, b);
  } else {
    returnCo = color(random(150, 255));
  }

  
  return(returnCo);
}
