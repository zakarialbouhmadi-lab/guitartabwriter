class Neck {
  // --- Positional Attributes ---
  float w, h, x, y;
  float df, ds; // Pre-calculated distances
  int totalFrets = 12, selectedFret = -1, selectedString = -1;
  boolean selectMultiple = false;
  String[] stringNames = {"e", "B", "G", "D", "A", "E"};

  // --- Color Palette Attributes ---
  color boardColor      = color(120, 75, 35);  
  color nutColor        = color(80, 50, 20);   
  color fretWireColor   = color(180);          
  color stringColor     = color(#FCE387);          
  color highlightColor  = color(220, 20, 20);  
  color textColor       = color(50);           
  color inlayColor      = color(200, 200, 200, 180); 
  color cursorColor     = color(220, 20, 20, 125);   

  Neck(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
    // Pre-calculate spacing to save CPU in draw loop
    this.df = w / (totalFrets + 1);  
    this.ds = h / 6;                 
  }
  
  void selectMultiple(boolean b){
    this.selectMultiple = b;
  }

  void draw() {
    // 1. Draw Fret Numbers (on top)
    textAlign(CENTER, BOTTOM);
    for (int i = 0; i <= totalFrets; i++) {
      applyTextStyle(selectedFret == i);
      text(i, x + (i * df) + (df / 2), y - 5);
    }

    // 2. Draw Neck Board
    for (int i = 0; i <= totalFrets; i++) {
      fill(i == 0 ? nutColor : boardColor);
      noStroke();
      rect(x + (i * df), y, df, h);
    }

    // 3. Draw Fret Dots (Inlays)
    fill(inlayColor);
    for (int i = 1; i <= totalFrets; i++) {
      float centerX = x + (i * df) + (df / 2);
      float centerY = y + (h / 2);
      if (i == 5 || i == 7 || i == 9) {
        ellipse(centerX, centerY, 15, 15);
      } else if (i == 12) {
        ellipse(centerX, centerY - (h / 6), 15, 15);
        ellipse(centerX, centerY + (h / 6), 15, 15);
      }
    }

    // 4. Draw Fret Wires
    stroke(fretWireColor);
    strokeWeight(2);
    for (int i = 0; i <= totalFrets; i++) {
      float fx = x + (i * df);
      line(fx, y, fx, y + h);
    }

    // 5. Draw Strings & Labels
    textAlign(RIGHT, CENTER);
    for (int i = 0; i < 6; i++) {
      float sy = y + (ds / 2) + (i * ds);
      
      // Label
      applyTextStyle(selectedString == i);
      text(stringNames[i], x - 10, sy);
      
      // String logic
      if (selectedString == i) {
        stroke(highlightColor);
        strokeWeight(1 + (i * 0.7));
      } else {
        stroke(stringColor);
        strokeWeight(1 + (i * 0.5));
      }
      line(x, sy, x + w, sy);
    }
    
    // 6. Draw Cursor
    if (selectedFret >= 0 && selectedString >= 0) {
      noStroke();
      fill(cursorColor);
      ellipse(mouseX, mouseY, 20, 20);
    }
  }

  void applyTextStyle(boolean isHighlighted) {
    if (isHighlighted) {
      fill(highlightColor);
      textSize(18);
    } else {
      fill(textColor);
      textSize(14);
    }
  }
  
  boolean intersectsWithCursor() {
     return mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h;
  }

  void update() {
    if (intersectsWithCursor()) {
      selectedString = floor((mouseY - y) / ds);
      selectedFret = floor((mouseX - x) / df);
      return;
    }
    selectedString = -1;
    selectedFret = -1;
  }
}
