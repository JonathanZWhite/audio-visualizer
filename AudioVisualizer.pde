import controlP5.*;

Visualizer visualizer;
ControlPanel controlPanel;
ControlP5 cp5;

int controlPanelWidth;
int windowHeight;
int windowWidth;
int visualizerWidth;

void setup() {
  cp5 = new ControlP5(this);
  
  windowHeight = displayHeight;
  windowWidth = displayWidth;
  controlPanelWidth = displayWidth / 4;
  visualizerWidth = (displayWidth - controlPanelWidth);
  
  size(displayWidth, displayHeight);


  controlPanel = new ControlPanel(windowHeight, windowWidth, controlPanelWidth, cp5);
  visualizer = new Visualizer(windowHeight, windowWidth, visualizerWidth);
}

/**
 * Visualization
 */
void draw() {
  visualizer.draw();
  controlPanel.draw();
}

/**
 * Mouse input
 */
void mousePressed() {
  visualizer.mouseClick();
  controlPanel.mouseClick();
}

/**
 * Stops program flow
 */
void stop() {
  super.stop();
}
