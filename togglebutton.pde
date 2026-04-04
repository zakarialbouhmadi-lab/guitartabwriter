// ToggleButton extends Button to reuse coordinates and drawing logic
class ToggleButton extends Button {
  boolean active = false;
  color activeColor = color(20, 220, 20); // Highlight color when 'on'

  ToggleButton(float x, float y, float w, float h, String label) {
    super(x, y, w, h, label);
  }

  @Override
  void draw() {
    update();
    stroke(0);
    // If active, use activeColor; if just hovering, use hoverColor; else base
    if (active) fill(activeColor);
    else fill(isHovered ? hoverColor : baseColor);
    
    rect(x, y, w, h, 5);

    fill(textColor);
    textAlign(CENTER, CENTER);
    text(label, x + w/2, y + h/2);
  }

  @Override
  boolean checkClick() {
    if (isHovered) {
      active = !active; // Flip state
      if (listener != null) listener.onButtonClick(this);
      return true;
    }
    return false;
  }
}
