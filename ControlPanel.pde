public class ControlPanel {
  int controlPanelWidth;

  public ControlPanel(int controlPanelWidth) {
    this.controlPanelWidth = controlPanelWidth;
  }

  public void draw() {
    fill(255, 2, 253);
    // (posX, posY, width, height)
    rect(width - 255, 0, 255, height);
  }

  public void mouseClicked() {

  }
}
