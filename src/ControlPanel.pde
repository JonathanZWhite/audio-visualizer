public class ControlPanel {
  ControlP5 cp5;
  Visualizer visualizer;

  int windowHeight;
  int windowWidth;
  int controlPanelWidth;
  int controlPanelPosX;
  int elementsPosX;
  int buttonWidth;

  color dimColor = color(35,35,35);
  color highlightColor = color(0,151,244);

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
      .setValue(0.40); // Default

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
      .setValue(0.50); // Default

    // Visualization
    RadioButton radioButton = cp5.addRadioButton("radioButton");
    radioButton
        .setColorBackground(dimColor)
        .setPosition(elementsPosX, 350)
        .setColorForeground(#2B2B2B)
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
    text("- Try whistling or clapping into your microphone", elementsPosX, 550);
    text("- Try playing some music", elementsPosX, 570);
    text("- Try adding your own input along with the music", elementsPosX, 590);
    text("- Create visualizations that remixes the music with", elementsPosX, 610);
    text("   your own input", elementsPosX, 625);

  }

  /* Updates values without needing refresh */
  public void mouseEvent() {
    float amplitudeMagnitude = cp5.get(Slider.class, "amplitude").getValue();
    float frequencyMagnitude = cp5.get(Slider.class, "frequency").getValue();
    float visualizationIndex = cp5.get(RadioButton.class, "radioButton").getValue();
    visualizer.update(amplitudeMagnitude, frequencyMagnitude, visualizationIndex);
  }
}