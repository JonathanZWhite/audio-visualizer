import controlP5.*;

public class ControlPanel {
  int windowHeight;
  int windowWidth;
  int controlPanelWidth;
  int controlPanelPosX;

  public ControlPanel(int windowHeight, int windowWidth, int controlPanelWidth) {
    this.windowHeight = windowHeight;
    this.windowWidth = windowWidth;
    this.controlPanelWidth = controlPanelWidth;
    
    controlPanelPosX = this.windowWidth - this.controlPanelWidth;  
  }

  public void draw() {
    int subheadPosX = controlPanelPosX + 30;
    
    // Background
    fill(49, 49, 49);
    rect(controlPanelPosX, 0, controlPanelWidth, windowHeight);
    
    // Text (margin: 60, 30)
    
    // Title
    textAlign(CENTER);
    textSize(24);
    fill(255, 255, 255);
    
    text("Config Panel", controlPanelPosX + (controlPanelWidth/2), 60);
    
    // Subhead 1
    textAlign(LEFT);
    textSize(16);
    System.out.println(controlPanelPosX);
    fill(206, 206, 206);
    text("Amplitude Magnifier", subheadPosX, 120); 
    // Caption 1
    textSize(12);
    text("Change the amplitude of the particles", subheadPosX, 140);
  }

  public void mouseClicked() {

  }
}
