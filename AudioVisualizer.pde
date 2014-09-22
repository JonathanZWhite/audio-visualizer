import controlP5.*;

Visualizer visualizer;
ControlPanel controlPanel;
ControlP5 cp5;

int controlPanelWidth;
int windowHeight;
int windowWidth;
int visualizerWidth;

boolean go = true;

void setup() {
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
      } else if (event.getController().name() == "reset" && event.getAction() == 1) {
        setup();
      }
    }
  });
}

/**
 * Visualization
 */
void draw() {
  if(go) {
    visualizer.draw();
    controlPanel.draw();
  } else {
    println("Program paused!");
  }

}

/**
 * Mouse input
 */
void mouseReleased() {

  controlPanel.mouseEvent();
}

// TODO: Pause button();
// TODO: Reset with setup();

/**
 * Stops program flow
 */
void stop() {
  super.stop();
}
