import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import controlP5.*; 
import ddf.minim.*; 
import ddf.minim.analysis.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class sketch_140920g extends PApplet {




Visualizer visualizer;
ControlPanel controlPanel;
ControlP5 cp5;

int controlPanelWidth;
int windowHeight;
int windowWidth;
int visualizerWidth;

boolean go = true;

public void setup() {
  cp5 = new ControlP5(this);
  
  System.out.println("Reset!");
  
  windowHeight = displayHeight;
  windowWidth = displayWidth;
  controlPanelWidth = displayWidth / 4;
  visualizerWidth = (displayWidth - controlPanelWidth);
  
  size(displayWidth, displayHeight);
  

  visualizer = new Visualizer(windowHeight, windowWidth, visualizerWidth);
  controlPanel = new ControlPanel(visualizer, windowHeight, windowWidth, controlPanelWidth, cp5);
  
  // Listens for ControlP5 events
  cp5.addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      // event.getAction() == 1 for click
      if(event.getController().name() == "pause" && event.getAction() == 1) {
        go = !go;
        cp5.controller("pause").setCaptionLabel(go ? "Pause" : "Unpause");
        System.out.println(go);
      } else if (event.getController().name() == "reset" && event.getAction() == 1) {
        cp5.controller("amplitude").setValue(0.40f);
        cp5.controller("frequency").setValue(0.50f);
      }
    }
  });
}

/**
 * Visualization
 */
public void draw() {
  if(go) {
    visualizer.draw();
    controlPanel.draw();
  } else {
 
  }

}

/**
 * Mouse input
 */
public void mouseReleased() {

  controlPanel.mouseEvent();
}

// TODO: Pause button();
// TODO: Reset with setup();

/**
 * Stops program flow
 */
public void stop() {
  super.stop();
}
public class ControlPanel {
  ControlP5 cp5;
  Visualizer visualizer;
  
  int windowHeight;
  int windowWidth;
  int controlPanelWidth;
  int controlPanelPosX;
  int elementsPosX;
  int buttonWidth;
  
  int dimColor = color(35,35,35);
  int highlightColor = color(0,151,244);

  public ControlPanel(Visualizer visualizer, int windowHeight, int windowWidth, int controlPanelWidth, ControlP5 cp5) { 
    this.visualizer = visualizer;
    this.cp5 = cp5;
    
    this.windowHeight = windowHeight;
    this.windowWidth = windowWidth;
    this.controlPanelWidth = controlPanelWidth;

    controlPanelPosX = this.windowWidth - this.controlPanelWidth;
    elementsPosX = controlPanelPosX + 30;
    buttonWidth = (controlPanelWidth - 75) / 2; // Half of element width - margin(15)
    
    /* Sliders: reference denoted by spaces to hide label and show value */
    
    cp5.setControlFont(createFont("Arial", 10));
    
    // AmplitudeMagnitude
    cp5.addSlider("amplitude")
    .setLabel("")
      .setColorForeground(highlightColor)
      .setColorActive(highlightColor)
      .setColorBackground(dimColor)
      .setHeight(10)
      .setPosition(controlPanelPosX + 30, 160)
      .setRange(0, 1)
      .setWidth(controlPanelWidth - 60) // 2x margin
      .setValue(0.40f); // Default
      
    // FrequencyMagnitude
    cp5.addSlider("frequency") 
      .setLabel("")
      .setColorActive(highlightColor)
      .setColorForeground(highlightColor)
      .setColorBackground(dimColor)
      .setHeight(10)
      .setPosition(controlPanelPosX + 30, 255)
      .setRange(0, 1)
      .setWidth(controlPanelWidth - 60) // 2x margin
      .setValue(0.50f); // Default
     
    // Visualization
    RadioButton radioButton = cp5.addRadioButton("radioButton");
    radioButton
        .setColorBackground(dimColor)
        .setPosition(elementsPosX, 350)
        .setColorForeground(0xff2B2B2B)
        .setColorActive(highlightColor)
        .setSize(25, 25)
        .setItemsPerRow(1)
        .setSpacingRow(10)
        .setLabelPadding(20, 20)
        .addItem("Reverb", 0)
        .addItem("Pulse", 1)
        .addItem("Sunrise", 2)
        .addItem("Radial", 3)
        .activate(0);
    
    // Buttons
    Button pause = cp5.addButton("pause");
    pause
      .activateBy(ControlP5.RELEASE)
      .setLabel("Pause")
      .setColorActive(highlightColor)
      .setColorBackground(highlightColor)
      .setColorForeground(highlightColor)
      .setPosition(elementsPosX, windowHeight - 130) // 60(margin) - 40(height)
      .setSize(buttonWidth, 40)
      .setValue(128);
    Button reset = cp5.addButton("reset"); 
    reset
      .activateBy(ControlP5.RELEASE)
      .setLabel("Reset")
      .setColorActive(highlightColor)
      .setColorBackground(highlightColor)
      .setColorForeground(highlightColor)
      .setPosition(elementsPosX + buttonWidth + 15, windowHeight - 130) // 60(margin) - 40(height)
      .setSize(buttonWidth, 40)
      .setValue(128);
      
    // Button style
    Label pauseLabel = pause.captionLabel();
    pauseLabel.align(CENTER, CENTER);
    
    Label resetLabel = reset.captionLabel();
    resetLabel.align(CENTER, CENTER);
  }
  
  
  public void draw() {
    
    // Background
    fill(49, 49, 49);
    rect(controlPanelPosX, 0, controlPanelWidth, windowHeight);
    
    /* Text (margin: 60, 30) */
    
    // Title
    textAlign(CENTER);
    textSize(24);
    fill(255, 255, 255);
    
    text("Config Panel", controlPanelPosX + (controlPanelWidth/2), 60);
    
    // Subhead 
    textAlign(LEFT);
    fill(206, 206, 206);
    
    textSize(16);
    text("Amplitude Magnifier", elementsPosX, 120); 
    textSize(12);
    text("Magnify the amplitude of the audio", elementsPosX, 140);
    
    textSize(16);
    text("Frequency Magnifier", elementsPosX, 215); 
    textSize(12);
    text("Magnify the frequency of the audio", elementsPosX, 235);
    
    textSize(16);
    text("Visualization Selector", elementsPosX, 310); 
    textSize(12);
    text("Visualize music", elementsPosX, 330);
    
    textSize(16);
    text("Instructions", elementsPosX, 530); 
    textSize(12);
    text("Try whistling, clapping, or playing some music!", elementsPosX, 550);
   
  }

  /* Updates values without needing refresh */
  public void mouseEvent() {
    float amplitudeMagnitude = cp5.get(Slider.class, "amplitude").getValue();
    float frequencyMagnitude = cp5.get(Slider.class, "frequency").getValue();
    float visualizationIndex = cp5.get(RadioButton.class, "radioButton").getValue();
    visualizer.update(amplitudeMagnitude, frequencyMagnitude, visualizationIndex);
  }
}
// Minim library


// Sound frequency


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

  float amplitudeMagnitude = 0.4f; // Default 
  float frequencyMagnitude = 0.5f; // Default
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
      fill(255, 127.5f + i, 255 - (2.5f * i), random(150, 200));
      int test = (int) (fft.getBand(i) * 100);
      rect(margin * i, 0, 10, abs(input.mix.get(i) * adjustedAmplitudeMagnitude));
      // TODO if above index, set to new color
    }
  }
  
  private void radial() {
    fill(0, 0, 0, 10); // 5?
    rect(0, 0, visualizerWidth, height);

    // Declarations & Instantiations    
    float circleCount = 80;
    float centerPosX = visualizerWidth/2;
    float centerPosY = height/2;
    
    float diameter =  visualizerWidth * .04f;       
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

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--stop-color=#cccccc", "sketch_140920g" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
