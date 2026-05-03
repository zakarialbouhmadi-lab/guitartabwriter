interface ClickListener {
  void onButtonClick(Button b);
}

class Button {
  float x, y, w, h;
  String label;
  boolean isHovered = false, isEnabled = true;
  ClickListener listener;

  Button(float x, float y, float w, float h, String label) {
    this.x = x; this.y = y; this.w = w; this.h = h; this.label = label;
  }

  void setListener(ClickListener l) {
    this.listener = l;
  }

  void update() {
    isHovered = mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h;
  }

  void draw() {
    stroke(0);
    if (isEnabled) {
      fill(isHovered ? C_BTN_HOVER : C_BTN_BASE);
    } else {
      fill(C_BTN_DISABLED);
    }
    
    rect(x, y, w, h, 5); 

    fill(C_BTN_TEXT);
    textAlign(CENTER, CENTER);
    textSize(14);
    text(label, x + w/2, y + h/2);
  }

  boolean checkClick() {
    if (isEnabled && isHovered && listener != null) {
      listener.onButtonClick(this);
      return true;
    }
    return false;
  }
}

class ToggleSwitch extends Button {
  boolean isActive = false;

  ToggleSwitch(float x, float y, float w, float h, String label) {
    super(x, y, w, h, label);
  }

  @Override
  void draw() {
    // 1. Draw the Track (The "Pill")
    noStroke();
    if (isActive) {
      fill(isHovered ? C_BTN_ACTIVE_HOVER:C_BTN_ACTIVE);
    } else {
      fill(isHovered ? C_BTN_HOVER:C_BTN_BASE);
    }
    
    // Draw the track on the left side of the bounding box
    rect(x, y, w, h, h); 

    // 2. Draw the Knob (The Circle)
    // Horizontal position transitions between left and right side of the track
    float knobOffset = isActive ? (w - h/2) : (h/2);
    float knobX = x + knobOffset;
    float knobY = y + h/2;
    float knobSize = h * 0.6;

    fill(255);
    if (isHovered && isEnabled) stroke(0, 50); // Slight highlight on hover
    else noStroke();
    
    circle(knobX, knobY, knobSize);

    // 3. Draw the Label (The Text)
    // Position the text to the right of the switch track
    fill(C_BTN_TEXT);
    textAlign(CENTER, CENTER);
    textSize(14);
    
    // Add a small 10px padding between the switch and the text
    text(label, x + w/2, y + h/2);
   
  }

  @Override
  boolean checkClick() {
    if (isEnabled && isHovered) {
      isActive = !isActive; 
      if (listener != null) listener.onButtonClick(this);
      return true;
    }
    return false;
  }
}
