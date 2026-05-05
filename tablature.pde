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

  void add(int[] chord, boolean palmMute) {
    Chord c = new Chord(chord);
    c.palmMute = palmMute;
    chords.add(++highlightedChord, c);
  }
  
  void updateSelected(int[] chord){
    chords.add(highlightedChord, new Chord(chord));
    chords.remove(highlightedChord+1);
  }
  
  void addSpace() {
    chords.add(++highlightedChord, new Chord());
  }
  
  Chord getHighlightedChord(){ //<>//
     return chords.isEmpty() ? new Chord() : new Chord(chords.get(highlightedChord));
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
    float lineSpacing = h / (STRINGS+1); 
    fill(C_TEXT);
    
    //draw prefix
    for (int i = 1; i <= stringNames.length; i++) {    
      float lineY = y  + (i * lineSpacing);       
      text(stringNames[i-1]+"|-", x + (CHAR_WIDTH / 2), lineY);
    }
    
    // draw chords
    
    for (int j = 0; j < chords.size(); j++) {
        if (j == highlightedChord) fill(C_HIGHLIGHT); else fill(C_TEXT);
        String[]c=chords.get(j).toStringArray();
        float charX = x + ((j+1) * CHAR_WIDTH);
         //draw palm mute           
        if(chords.get(j).palmMute) 
          text("X", charX + (CHAR_WIDTH / 2), y);
        for (int i=1;i<=c.length;i++) {
            float lineY = y + (i * lineSpacing);            
            text(c[i-1], charX + (CHAR_WIDTH / 2), lineY);
      }
    }
  }
}
