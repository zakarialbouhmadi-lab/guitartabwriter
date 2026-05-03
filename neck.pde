class Neck {
  float w, h, x, y;
  float df, ds; 
  int totalFrets = 24, hoveredFret = -1, hoveredString = -1;
  boolean selectMultiple = false;
  Chord selectedChord;
  PGraphics pg;

  Neck(float x, float y, float w, float h) {
    this.x = x; this.y = y; this.w = w; this.h = h;
    this.df = w / (totalFrets + 1);  
    this.ds = h / 6;
    this.selectedChord = new Chord();
    
    pg = createGraphics((int)w + 100, (int)h + 50);
    renderStatic();
  }

  void renderStatic() {
    pg.beginDraw();
    pg.clear();
    
    float offX = 50;
    float offY = 20;

    pg.textAlign(CENTER, BOTTOM);
    pg.textSize(14);
    pg.fill(C_TEXT);
    for (int i = 0; i <= totalFrets; i++) {
      pg.text(i, offX + (i * df) + (df / 2), offY - 5);
    }

    for (int i = 0; i <= totalFrets; i++) {
      pg.fill(i == 0 ? C_NUT : C_BOARD);
      pg.noStroke();
      pg.rect(offX + (i * df), offY, df, h);
    }

    pg.fill(C_INLAY);
    for (int i = 1; i <= totalFrets; i++) {
      float centerX = offX + (i * df) + (df / 2);
      float centerY = offY + (h / 2);
      if (i == 3 || i == 5 || i == 7 || i == 9 || i == 15 || i == 17 || i == 19) {
        pg.ellipse(centerX, centerY, 15, 15);
      } else if (i == 12 || i == 24) {
        pg.ellipse(centerX, centerY - (h / 6), 15, 15);
        pg.ellipse(centerX, centerY + (h / 6), 15, 15);
      }
    }

    pg.stroke(C_FRET_WIRE);
    pg.strokeWeight(2);
    for (int i = 0; i <= totalFrets; i++) {
      float fx = offX + (i * df);
      pg.line(fx, offY, fx, offY + h);
    }

    pg.textAlign(RIGHT, CENTER);
    for (int i = 0; i < 6; i++) {
      float sy = offY + (ds / 2) + (i * ds);
      pg.fill(C_TEXT);
      pg.text(TUNING[i], offX - 10, sy);
      pg.stroke(C_STRING);
      pg.strokeWeight(1 + (i * 0.5));
      pg.line(offX, sy, offX + w, sy);
    }
    
    pg.endDraw();
  }

  void draw() {
    image(pg, x - 50, y - 20);
    
    if (selectMultiple) {
      fill(C_HIGHLIGHT);
      noStroke();
      for (int i = 0; i < selectedChord.chord.length; i++) {
        int fret = selectedChord.chord[i];
        if (fret != -1) { 
           float fx = x + (fret * df) + (df / 2);
           float fy = y + (i * ds) + (ds / 2);
           ellipse(fx, fy, 25, 25);
        }
      }
    }
    
    if (hoveredFret >= 0 && hoveredString >= 0) {
      noStroke();
      fill(C_CURSOR);
      float snapX = x + (hoveredFret * df) + (df / 2);
      float snapY = y + (hoveredString * ds) + (ds / 2);
      ellipse(snapX, snapY, 30, 30);
    }
  }

  void update() {
    if (isHovered()) {
      hoveredString = floor((mouseY - y) / ds);
      hoveredFret = floor((mouseX - x) / df);
    } else {
      hoveredString = -1;
      hoveredFret = -1;
    }
  }
  
  void changeSelectionMode(boolean selectMultiple) {
      this.selectMultiple = selectMultiple;
      if (selectMultiple) this.selectedChord = new Chord();
  }

  boolean isHovered() {
    return mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h;
  }
  
  void onClick() {
    if (!selectMultiple)
      selectedChord = new Chord();

    
    if (selectedChord.chord[hoveredString] == hoveredFret)
        selectedChord.chord[hoveredString] = -1;
    else { 
      selectedChord.chord[hoveredString] = hoveredFret;
    }
  }
}
