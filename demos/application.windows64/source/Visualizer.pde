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
  int time;
  int wait = 100;

  float[] angle;
  float[] y, x;

  int color1 = 0;
  int color2 = 255;
  int color3 = 255;

  public Visualizer(int windowHeight, int windowWidth, int visualizerWidth) {
    this.windowHeight = windowHeight;
    this.windowWidth = windowWidth;
    this.visualizerWidth = visualizerWidth;

    minim = new Minim(this);

    input = minim.getLineIn(Minim.STEREO, 512);
    fft = new FFT(input.bufferSize(), input.sampleRate());
    time = millis(); // Current time
  }

  /**
   * Visualization
   */
  public void draw() {
    fft.forward(input.mix);
    noStroke();

    switch(visualizationIndex) {
      case 0:
        fill(0, 0, 0);
        reverb();
        break;
      case 1:
     fill(0, 0, 0);
        pulse();
        break;
      case 2:
        sunrise();
        break;
      case 3:
      fill(0, 0, 0);
        radial();
        break;
      default:
        reverb();
    }
  }

  private void pulse() {
    // Config background
    fill(0, 0, 0, 10);
    rect(0, 0, visualizerWidth, height);

    // Declarations & Instantiations
    adjustedAmplitudeMagnitude = amplitudeMagnitude * 10000; // Max 10000
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

    // Declarations & Instantiations
    int margin = 80;
    int startingDivisor = 5;

    adjustedAmplitudeMagnitude = amplitudeMagnitude * 800; // Max 800
    adjustedFrequencyMagnitude = frequencyMagnitude * 800; // Max 800

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

    // Declarations & Instantiations
    int barCount = 100;
    int margin = 20;

    adjustedAmplitudeMagnitude = amplitudeMagnitude * 4000; // Max 4000
    adjustedFrequencyMagnitude = frequencyMagnitude * 200; // Max 200

    // Visualization
    for (int i = 0; i < 100; i++) {
      // x, y, width, height
      fill(255, 127.5 + i, 255 - (2.5 * i), random(150, 200));
      int test = (int) (fft.getBand(i) * 100);
      rect(margin * i, 0, 10, abs(input.mix.get(i) * adjustedAmplitudeMagnitude));
    }
  }

  private void radial() {
    fill(0, 0, 0, 10); // 5?
    rect(0, 0, visualizerWidth, height);

    // Declarations & Instantiations
    float circleCount = 80;
    float centerPosX = visualizerWidth/2;
    float centerPosY = height/2;

    float diameter =  visualizerWidth * .04;
    float radius  = diameter/2;
    float circ =  PI * diameter;
    float smallDiameter = (circ / circleCount);

    float angle, x, y;

    adjustedAmplitudeMagnitude = amplitudeMagnitude * 1000; // Max 5000
    adjustedFrequencyMagnitude = frequencyMagnitude * 25; // Max 50
    amplitude = (input.mix.get(1) * adjustedAmplitudeMagnitude);
    frequency = (fft.getBand(1) * adjustedFrequencyMagnitude);

    fill(color1, color2, color3);

    // Fill Change Over Time
    if(millis() - time >= wait) {
      color1 += 10;
      color2 -= 5;

      // Resets
      if(color1 >= 255) { color1 = 0; }
      if(color2 <= 0) { color2 = 255; }
      if(color3 <= 0) { color3 = 255; }

      time = millis(); // Updates time
    }

    // Visualization
    for(int i = 1; i <= circleCount; ++i) {
      angle = i * TWO_PI / circleCount;
      x = centerPosX + cos(angle) * radius * amplitude;
      y = centerPosY + sin(angle) * radius * amplitude;

      ellipse(x, y, smallDiameter * frequency, smallDiameter * frequency);
    }
  }

  public void update(float amplitudeMagnitude, float frequencyMagnitude, float visualizationIndex) {
    this.amplitudeMagnitude = amplitudeMagnitude;
    this.frequencyMagnitude = frequencyMagnitude;
    this.visualizationIndex = (int) visualizationIndex;
  }
}

