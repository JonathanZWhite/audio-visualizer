public class ControlPanel {
  ControlP5 cp5;
  Visualizer visualizer;
  
  int windowHeight;
  int windowWidth;
  int controlPanelWidth;
  int controlPanelPosX;
  int elementsPosX;
  
  color dimColor = color(35,35,35);
  color highlight = color(0,151,244);
  
  float[] userInput = new float[3];

  public ControlPanel(Visualizer visualizer, int windowHeight, int windowWidth, int controlPanelWidth, ControlP5 cp5) { 
    this.visualizer = visualizer;
    this.cp5 = cp5;
    
    this.windowHeight = windowHeight;
    this.windowWidth = windowWidth;
    this.controlPanelWidth = controlPanelWidth;

    controlPanelPosX = this.windowWidth - this.controlPanelWidth;
    elementsPosX = controlPanelPosX + 30;
    
    /* Sliders: reference denoted by spaces to hide label and show value */
    
    cp5.setControlFont(createFont("Arial", 10));
    
    // AmplitudeMagnitude
    cp5.addSlider("") 
      .setColorForeground(highlight)
      .setColorActive(highlight)
      .setColorBackground(dimColor)
      .setHeight(10)
      .setPosition(controlPanelPosX + 30, 160)
      .setRange(0, 1)
      .setWidth(controlPanelWidth - 60) // 2x margin
      .setValue(0.40); // Default
      
    // FrequencyMagnitude
    cp5.addSlider(" ") 
      .setColorActive(highlight)
      .setColorForeground(highlight)
      .setColorBackground(dimColor)
      .setHeight(10)
      .setPosition(controlPanelPosX + 30, 255)
      .setRange(0, 1)
      .setWidth(controlPanelWidth - 60) // 2x margin
      .setValue(0.50); // Default
     
    // Visualization
    RadioButton radioButton = cp5.addRadioButton("radioButton");
    radioButton
        .setColorBackground(dimColor)
        .setPosition(elementsPosX, 350)
        .setColorForeground(#2B2B2B)
        .setColorActive(highlight)
        .setSize(25, 25)
        .setItemsPerRow(1)
        .setSpacingRow(10)
        .setLabelPadding(20, 20)
        .addItem("Reverb", 0)
        .addItem("Pulse", 1)
        .addItem("Sunrise", 2);
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
   
  }
 
  public void mouseClick() {
    float amplitudeMagnitude = cp5.get(Slider.class, "").getValue();
    float frequencyMagnitude = cp5.get(Slider.class, " ").getValue();
    float visualizationIndex = cp5.get(RadioButton.class, "radioButton").getValue();
    visualizer.update(amplitudeMagnitude, frequencyMagnitude, visualizationIndex);
    
    System.out.println(visualizationIndex);
  }
}
