public class ControlPanel {
  ControlP5 cp5;
  int windowHeight;
  int windowWidth;
  int controlPanelWidth;
  int controlPanelPosX;
  
  color inputColor = color(35,35,35);
  
  float amplitudeMagnifier;

  public ControlPanel(int windowHeight, int windowWidth, int controlPanelWidth, ControlP5 cp5) { 
    this.cp5 = cp5;
    this.windowHeight = windowHeight;
    this.windowWidth = windowWidth;
    this.controlPanelWidth = controlPanelWidth;

    int inputPosX = this.windowWidth - 70; // Margin 30 + 40 (width)
    controlPanelPosX = this.windowWidth - this.controlPanelWidth;
    
    // Text field
    cp5.addTextfield("")
      .setPosition(inputPosX, 103)
      .setFont(createFont("arial", 16))
      .setSize(40, 40)
      .setFocus(true)
      .setColor(color(255, 255, 255))
      .setColorBackground(inputColor)
      .setText("0.4")
      .setAutoClear(false);
  }

  public void draw() {
    int textPosX = controlPanelPosX + 30;
    
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
    
    text("Amplitude Magnifier", textPosX, 120); 
    textSize(12);
    text("Change the amplitude of the particles", textPosX, 140);
   
  }
 
  public void mouseClick() {
    // TODO: Create submit button
    amplitudeMagnifier = Float.parseFloat(cp5.get(Textfield.class, "").getText());
  }
}
