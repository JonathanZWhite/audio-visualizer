public class ControlPanel {
  ControlP5 cp5;
  Visualizer visualizer;
  
  int windowHeight;
  int windowWidth;
  int controlPanelWidth;
  int controlPanelPosX;
  int elementsPosX;
  
  color sliderColor = color(35,35,35);
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
    
    // Sliders: reference denoted by spaces to hide label and show value
    cp5.addSlider("")
      .setColorForeground(highlight)
      .setColorActive(highlight)
      .setColorBackground(sliderColor)
      .setPosition(controlPanelPosX + 30, 160)
      .setRange(0, 1)
      .setWidth(controlPanelWidth - 60) // 2x margin
      .setValue(0.40); // Default
  }

  public void draw() {
    
    // Background
    fill(49, 49, 49);
    rect(controlPanelPosX, 0, controlPanelWidth, windowHeight);
    
    // Text (margin: 60, 30)
    
    // Title
    textAlign(CENTER);
    textSize(24);
    fill(255, 255, 255);
    
    text("Config Panel", controlPanelPosX + (controlPanelWidth/2), 60);
    
    // Subhead 
    textAlign(LEFT);
    textSize(16);
    fill(206, 206, 206);
    
    text("Amplitude Magnifier", elementsPosX, 120); 
    textSize(12);
    text("Change the amplitude of the particles", elementsPosX, 140);
   
  }
 
  public void mouseClick() {
    float amplitudeMagnitude = cp5.get(Slider.class, "").getValue();
    visualizer.update(amplitudeMagnitude);
  }
}
