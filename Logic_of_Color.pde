import ddf.minim.*;
import ddf.minim.analysis.*;
import com.hamoid.*;
 
Minim loc;
AudioPlayer song;
AudioMetaData meta;
BeatDetect beat;
VideoExport videoExport;
int FR = 30;

void setup() {
  size(1920, 1080);
  smooth();
  frameRate(FR);
 
 //Rings setup
 rings = new Ring[numRings]; //creats array
 for (int i = 0; i < rings.length; i++) {
   rings[i] = new Ring(); //creats an object for each element
  }
 
  //music setup 
  loc = new Minim(this);
  song = loc.loadFile("10 Logic Of Color.mp3");
  fftLeft = new FFT(song.bufferSize(), song.sampleRate());
  fftRight = new FFT(song.bufferSize(), song.sampleRate());
  meta = song.getMetaData();
  beat = new BeatDetect(song.bufferSize(), song.sampleRate());
  song.play();
  
  //credits setup
  textSize(52);
  endCreditOffset = creditDuration;
  endCreditStart = meta.length() / 1000 - endCreditOffset;
  randCo = new color[meta.title().length()];
  
  //video setup
  videoExport = new VideoExport(this);
  videoExport.setFrameRate(FR);
  videoExport.setAudioFileName("10 Logic Of Color.mp3");
  videoExport.startMovie();  
}


///////////////////////////////////////////////////////
void draw() {
  println(sec);
  sec = millis() / 1000.0;
  //background(50);
  fill(20, 10);
  rect(0, 0, width, height);
  
  levelBar();
  waveform();
  frequency();
  
  //Ring functions
  if (sec > 22.5) {
    beats();
  }
  
  for (int i = 0; i < rings.length; i++) {
    rings[i].grow();
    rings[i].display();
  }
  
  if (sec < creditDuration || sec > endCreditStart - 255/FR) {
    if (sec < endCreditStart && sec > creditDuration) {
      opacity += 60/FR;
    }
    titleDisplay();
  }
  
  videoExport.saveFrame();
  if (sec > meta.length()/1000 + 2.0) {
    videoExport.endMovie();
    exit();
  }
}
