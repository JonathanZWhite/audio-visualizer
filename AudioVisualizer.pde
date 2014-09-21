Visualizer visualizer;
ControlPanel controlPanel;

int controlPanelWidth;
int windowHeight;
int windowWidth;
int visualizerWidth;

void setup() {
  windowHeight = displayHeight;
  windowWidth = displayWidth;
  controlPanelWidth = displayWidth / 4;
  visualizerWidth = (displayWidth - controlPanelWidth);

  System.out.println(visualizerWidth);

  size(displayWidth, displayHeight);

  controlPanel = new ControlPanel(windowHeight, windowWidth, controlPanelWidth);
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
  visualizer.mouseClicked();
}

/**
 * Stops program flow
 */
void stop() {
  super.stop();
}
