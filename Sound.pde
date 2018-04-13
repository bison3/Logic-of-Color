////////////////////////
int randCo2;
int waveSize = 100;
int waveOffsetX = 200;
int waveOffsetY;
int fuckUpper = 1;
int movement = 1;

void waveform() {   
  int bufferLength = song.bufferSize() - 1;
  waveOffsetY = (height - song.bufferSize()) / 2;
  
  if (frameCount % (FR/10) == 0) {
    randCo2 = randomColor(100, 220);
  }
  stroke(randCo2);
  fill(randCo2);
  strokeWeight(1);
  /*for (int i = 0; i < song.bufferSize() - 1; i++) {
    line(i, 50  + song.left.get(i)  * waveSize, i + 1, 50  + song.left.get(i + 1)  * waveSize);
    line(i, 150 + song.right.get(i) * waveSize, i + 1, 150 + song.right.get(i + 1) * waveSize);    
  }*/ 
  
  if (sec > 125) {
    fuckUpper = 2;
    waveOffsetX += 60/FR * movement;
    if (waveOffsetX < 200 || waveOffsetX > width/2-1) movement *= -1; 
  }
  for (int i = 0; i < bufferLength; i++) {
    line(waveOffsetX + song.left.get(i) * waveSize * fuckUpper, waveOffsetY + i, waveOffsetX  + song.left.get(i + 1)  * waveSize, waveOffsetY + i + 1);
    line((width - waveOffsetX) + song.right.get(i) * waveSize * fuckUpper, waveOffsetY + i, (width - waveOffsetX) + song.right.get(i + 1) * waveSize, waveOffsetY + i + 1);
  }
  strokeWeight(2);
  for (float i = waveOffsetX + song.left.get(0) * waveSize; i < width - waveOffsetX + song.right.get(0) * waveSize +5; i += ((width - waveOffsetX + song.right.get(0) * waveSize) - (waveOffsetX + song.left.get(0) * waveSize))/25) {
    line(i, waveOffsetY, i + 2, waveOffsetY);
    line(i, height - waveOffsetY, i + 2, height - waveOffsetY);
  }
  strokeWeight(1);
}

///////////////////////////
float leftLevel, rightLevel;
float barSize, cirSize;

void levelBar() {
  //fill(randCo2, 100); 
  leftLevel = song.left.level();
  rightLevel = song.right.level();
  fill(randCo2, 150);
  strokeWeight(2);
  stroke(randCo2, 50);
  rect(fftLeft.specSize()/2, height, (width - fftLeft.specSize())/2, -leftLevel*height/4);
  rect(width/2, height, (width - fftRight.specSize())/2, -rightLevel*height/4);
  
  noFill();
  strokeWeight(1);
  stroke(randCo2);
  ellipse(width/2-400, height/2, leftLevel*1000, leftLevel*1000);
  ellipse(width/2+400, height/2, rightLevel*1000, rightLevel*1000);
}
//////////////////////////////////
FFT fftLeft;
FFT fftRight;
int frequencySize = 5;
float leftFreq, rightFreq;
color newColor;
color currentColor = color(204);
color lastColor = currentColor;
float transition = 0;

void frequency() {
  fftLeft.forward(song.left);
  fftRight.forward(song.right);
  

  if (frameCount % (FR*5) == 0) {
    lastColor = currentColor;
    newColor = randomColor(80, 150);
    //text("wtf man", 200, 200);
    transition = 0;
  }
  transition += .005;
  currentColor = lerpColor(lastColor, newColor, transition);
  stroke(currentColor);
  
  for (int i = 0; i < fftLeft.specSize(); i++) {
    leftFreq = fftLeft.getBand(i);
    line(i, height, i, height - (leftFreq * frequencySize));
    line(i, 0, i, 0 + (leftFreq * frequencySize));
    
    rightFreq = fftRight.getBand(i);
    line(width - i, height, width - i, height - (rightFreq * frequencySize));
    line(width - i, 0, width - i, 0 + (rightFreq * frequencySize));
  }
}

//////////////////////////
void beats() {
  beat.setSensitivity(300);
  beat.detect(song.mix);
  if (beat.isOnset(2)) {
    triggerRing();
  }
}
