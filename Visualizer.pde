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

  int visualizationIndex = 0; // Default
  int windowHeight;
  int windowWidth;
  int visualizerWidth;

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
    smooth();

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
    float adjustedAmplitudeMagnitude = amplitudeMagnitude * 5000; // Max 5000
    float adjustedFrequencyMagnitude = frequencyMagnitude * 100; // Max 50
    
    // Visualization
    for (int i = 0; i < 3; i++) {
      fill(random(0, 255), random(0, 255), random(0, 255));

      float amplitude = (input.mix.get(1) * adjustedAmplitudeMagnitude);
      float frequency = (fft.getBand(1) * adjustedFrequencyMagnitude);

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
    
    float adjustedAmplitudeMagnitude = amplitudeMagnitude * 400; // Max 400
    float adjustedFrequencyMagnitude = frequencyMagnitude * 200; // Max 200
     
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
    
    float adjustedAmplitudeMagnitude = amplitudeMagnitude * 4000; // Max 4000
    float adjustedFrequencyMagnitude = frequencyMagnitude * 200; // Max 200
    
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

  /**
   * Mouse input
   */
  public void mouseClick() {
    // TODO - check within();
    // TODO - set default values for each new selection
    //    background(random(0, 255), random(0, 255), random(0, 255));
  }

  public void update(float amplitudeMagnitude, float frequencyMagnitude, float visualizationIndex) {
    this.amplitudeMagnitude = amplitudeMagnitude; 
    this.frequencyMagnitude = frequencyMagnitude;
    this.visualizationIndex = (int) visualizationIndex;
  }
}

