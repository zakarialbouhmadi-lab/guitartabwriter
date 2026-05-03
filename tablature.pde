class Tablature {  //<>//
  float x, y, w, h;
  int highlightedChord = -1;
  ArrayList<Chord> chords=new ArrayList<>();
  

  final int TEXT_SIZE = 16, STRINGS=6;
  final float CHAR_WIDTH = 20;
  final byte CHORD_LENGTH = 4;
  final String[] stringNames = {"e", "B", "G", "D", "A", "E"};

  Tablature(float x, float y, float w, float h) {
    this.x = x; this.y = y; this.w = w; this.h = h;
  }

  boolean selectRight() { 
    if (highlightedChord >= 0 && highlightedChord < chords.size()-1){
      highlightedChord++;
      return true;
    }
    return false;
  }
  
  boolean selectLeft() { 
    if (highlightedChord > 0){
      highlightedChord--;
      return true;
    } 
    return false;
  }

  void add(int[] chord) {
    chords.add(++highlightedChord, new Chord(chord));
  }
  
  void updateSelected(int[] chord){
    chords.add(highlightedChord, new Chord(chord));
    chords.remove(highlightedChord+1);
  }
  
  void addSpace() {
    chords.add(++highlightedChord, new Chord());
  }
  
  int[] getHighlightedChord(){ //<>//
     return chords.isEmpty() ? new Chord().chord :chords.get(highlightedChord).chord;
  }
  

  void remove() {
    if (chords.isEmpty()) 
      return;
    chords.remove(highlightedChord);
    if (highlightedChord > 0 || chords.isEmpty()) highlightedChord--;
    
    println(highlightedChord);
  }



  void draw() {
    noFill();
    stroke(0);
    strokeWeight(1);
    rect(x, y, w, h);
    
    textSize(TEXT_SIZE);
    textAlign(CENTER, TOP);
    float lineSpacing = h / STRINGS; 
    
    //draw prefix
    for (int i = 0; i < stringNames.length; i++) {
      float lineY = y + 15 + (i * lineSpacing);       
      fill(C_TEXT);
      text(stringNames[i]+"|-", x + (CHAR_WIDTH / 2), lineY);
    }
    
    for (int j = 0; j < chords.size(); j++) {
        String[]c=chords.get(j).toStringArray();
        float charX = x + ((j+1) * CHAR_WIDTH);

        for (int i=0;i<c.length;i++) {
            float lineY = y + 15 + (i * lineSpacing);
            // --- CHANGED: only text color highlight ---
            if (j == highlightedChord) fill(C_HIGHLIGHT);
            else fill(C_TEXT);
            
            text(c[i], charX + (CHAR_WIDTH / 2), lineY);
      }
    }
  }
}
