class Button {
  float x, y, w, h;
  String label;
  boolean isHovered = false, isEnabled=true;
  ClickListener listener;

  // --- Theme Attributes ---
  color baseColor    = color(220,20, 20);
  color hoverColor   = color(170,10,10);
  color textColor    = color(255);
  color disabledColor= color(125);
  int textSize       = 14;

  Button(float x, float y, float w, float h, String label) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
  }

  void setListener(ClickListener l) {
    this.listener = l;
  }

  void update() {
    isHovered = mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h;
  }

  void draw() {
    update();
    stroke(0);
    if(isEnabled)
      fill(isHovered ? hoverColor : baseColor);
    else
      fill(disabledColor); 
    rect(x, y, w, h, 5); // 5px rounded corners

    fill(textColor);
    textAlign(CENTER, CENTER);
    textSize(textSize);
    text(label, x + w/2, y + h/2);
  }

  boolean checkClick() {
    if (isHovered && listener != null) {
      listener.onButtonClick(this);
      return true;
    }
    return false;
  }
}
