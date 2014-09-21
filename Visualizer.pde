// Minim library
import ddf.minim.*;

// Sound frequency
import ddf.minim.analysis.*;

/**
 * Class Visualizer
 *
 * Creates particle system sensitive to the
 * amplitude and frequency of the input
 */
public class Visualizer {
  Minim minim;
  AudioInput input;
  FFT fft;

  float amplitudeMagnitude = 0.4; // Default 
  float frequencyMagnitude = 0.5; // Default
  float adjustedAmplitudeMagnitude;
  float adjustedFrequencyMagnitude;
  float amplitude;
  float frequency;
  
  int visualizationIndex = 0; // Default
  int windowHeight;
  int windowWidth;
  int visualizerWidth;

  float[] angle;
  float[] y, x;

  public Visualizer(int windowHeight, int windowWidth, int visualizerWidth) {
    this.windowHeight = windowHeight;
    this.windowWidth = windowWidth;
    this.visualizerWidth = visualizerWidth;

    minim = new Minim(this);

    input = minim.getLineIn(Minim.STEREO, 512);
    fft = new FFT(input.bufferSize(), input.sampleRate());
  }

  /**
   * Visualization
   */
  public void draw() {
    fft.forward(input.mix);
    noStroke();

//    radial();

    switch(visualizationIndex) {
      case 0: 
        reverb();
        break;
      case 1: 
        pulse();
        break;
      case 2:
        sunrise();
        break;
      default:
        reverb();
    }
  }

  private void pulse() {
    // Config background
    fill(0, 0, 0, 10);
    rect(0, 0, visualizerWidth, height);
    
    // Declarations
    adjustedAmplitudeMagnitude = amplitudeMagnitude * 5000; // Max 5000
    adjustedFrequencyMagnitude = frequencyMagnitude * 100; // Max 50
    
    // Visualization
    for (int i = 0; i < 3; i++) {
      fill(random(0, 255), random(0, 255), random(0, 255));

      amplitude = (input.mix.get(1) * adjustedAmplitudeMagnitude);
      frequency = (fft.getBand(1) * adjustedFrequencyMagnitude);

      ellipse(random(i, width), (height / 2) - amplitude, frequency, frequency);
    }
  }
  
  private void reverb() {
    // Configurations
    fill(0, 0, 0, 10);
    rect(0, 0, visualizerWidth, height);
     
    // Declarations
    int margin = 80;
    int startingDivisor = 5;
    
    adjustedAmplitudeMagnitude = amplitudeMagnitude * 800; // Max 400
    adjustedFrequencyMagnitude = frequencyMagnitude * 400; // Max 400
     
    // Visualization
    for(int i = 0; i < fft.specSize(); i++){
      fill(random(0, 255), random(0, 255), random(0, 255));
      ellipse(margin * i, height - fft.getBand(i) * adjustedFrequencyMagnitude - height/startingDivisor, 
        input.left.get(i) * adjustedAmplitudeMagnitude, input.right.get(i) * adjustedAmplitudeMagnitude);
    }
  }
  
  private void sunrise() {
    // Configurations
    frameRate(50);
    fill(0, 0, 0);
    rect(0, 0, visualizerWidth, height);

    // Declarations
    int barCount = 100;
    int margin = 20;
    
    adjustedAmplitudeMagnitude = amplitudeMagnitude * 4000; // Max 4000
    adjustedFrequencyMagnitude = frequencyMagnitude * 200; // Max 200
    
    // Visualization
    for (int i = 0; i < 100; i++) {
      // x, y, width, height
      fill(255, 127.5 + i, 255 - (2.5 * i), random(150, 200));
      int test = (int) (fft.getBand(i) * 100);
      System.out.println((int) (fft.getBand(i) * 100));
      rect(margin * i, 0, 10, abs(input.mix.get(i) * adjustedAmplitudeMagnitude));
      // TODO code cleanup
      // TODO if above index, set to new color
    }
  }
  
  private void radial() {
    background(0);
    frameRate(50);

    // Declarations
    adjustedAmplitudeMagnitude = amplitudeMagnitude * 1000; // Max 5000
    adjustedFrequencyMagnitude = frequencyMagnitude * 25; // Max 50
    amplitude = (input.mix.get(1) * adjustedAmplitudeMagnitude);
    frequency = (fft.getBand(1) * adjustedFrequencyMagnitude);
    
    float circleCount = 80;
    
    float centerPosX = visualizerWidth/2;
    float centerPosY = height/2;
      
    float diameter =  visualizerWidth * .04;       // large circle's diameter
    float radius  = diameter/2;                    // large circle's radius
    float circ =  PI * diameter;                   // large circumference
    float smallDiameter = (circ / circleCount);    // small circle's diameter
    
    for(int i = 1; i <= circleCount; ++i) {
      float angle = i * TWO_PI / circleCount;
      float x = centerPosX + cos(angle) * radius * amplitude;
      float y = centerPosY + sin(angle) * radius * amplitude;
      
      fill(random(50, 100), random(200, 250), random(200, 250));
      
      if(frameCount % 20 == 0) {
        System.out.println("Changed");
        fill(random((i * 3.1) - 2, i * 3.1), random((i * 2.1) - 2, i * 3.0), random((i * 2) - 2, i * 1.2));
      }
      
      // TODO, change the color scheme over time
      
      ellipse(x, y, smallDiameter * frequency, smallDiameter * frequency);
    }
    
    // TODO, add rotation?
  }
  

  /**
   * Mouse input
   */
  public void mouseClick() {
    // TODO - check within();
    // TODO - Fill depends on color?
    // TODO - set default values for each new selection
    // TODO - chan
    //    background(random(0, 255), random(0, 255), random(0, 255));
  }

  public void update(float amplitudeMagnitude, float frequencyMagnitude, float visualizationIndex) {
    this.amplitudeMagnitude = amplitudeMagnitude; 
    this.frequencyMagnitude = frequencyMagnitude;
    this.visualizationIndex = (int) visualizationIndex;
  }
}

