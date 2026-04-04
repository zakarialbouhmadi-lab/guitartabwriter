class Tablature {
  ArrayList<int[]> list;
  float x, y, w, h;
  int maxDisplayNotes = 20, selectedFret=0;
  String[] stringNames = {"e", "B", "G", "D", "A", "E"};
  
  // Cache the strings so we don't recreate them 60 times a second
  String[] displayLines; 
  
  color textColor = color(50), selectedColor=color(220, 20,20);
  int textSize = 14;
  float charWidth = 10; // Fixed width for every single character/dash

  Tablature(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.list = new ArrayList<int[]>();
    this.displayLines = new String[6];
    buildStrings(); // Build the initial empty lines
  }
  
  void selectRight(){
    if(selectedFret<list.size()){
      selectedFret++;
      buildStrings();
    }
  }
  
  void selectLeft(){
    if(selectedFret>1){
      selectedFret--;
      buildStrings();
    }
      
  }

  void add(int fret, int string) {
    list.add(new int[]{fret, string}); //<>// //<>//
    buildStrings(); // ONLY rebuild strings when a note is added!
    selectedFret=list.size();
  }
  
  void remove(){
    if(list.isEmpty() || selectedFret<1)
      return;
    
    list.remove(--selectedFret);
    buildStrings(); // ONLY rebuild strings when a note is added!
  }

  // Parses the ArrayList and builds the 6 strings of text
  void buildStrings() {
    int startIdx = Math.max(0, list.size() - maxDisplayNotes);
    
    // Build the initial prefixes
    for (int i = 0; i < 6; i++) {
      displayLines[i] = " " + stringNames[i] + "|-";
    }

    // Build the text strings with the 3-character "cell" rule
    for (int i = startIdx; i < list.size(); i++) {
      int[] note = list.get(i);
      int fret = note[0];
      int stringIdx = note[1];

      for (int s = 0; s < 6; s++) {
        if (s == stringIdx) {
          if (fret >= 10) {
            displayLines[s] += fret + "-"; 
          } else {
            displayLines[s] += fret + "--"; 
          }
        } else {
          displayLines[s] += "---"; 
        }
      }
    }
  }

  void draw() {
    println(selectedFret);
    // Draw background frame
    noFill();
    stroke(0);
    strokeWeight(1);
    rect(x, y, w, h);
    textSize(textSize);
    textAlign(CENTER, TOP); // Center each character on its coordinate

    float lineSpacing = h / 6;
    
    // Draw Character by Character from our cached strings
    for (int i = 0; i < 6; i++) {
      String line = displayLines[i];
      float lineY = y + 15 + (i * lineSpacing);
      
      for (int j = 0; j < line.length(); j++) {
        char c = line.charAt(j);
        
        // Calculate the exact X position for this character
        float charX = x + (j * charWidth); 
        //set text color
        fill(selectedFret*3>=j-3 && selectedFret*3<j? selectedColor:textColor);        
        // Only draw if it fits inside the bounding box
        if (charX < x + w) {
          text(c, charX, lineY);
        }
      }
    }
  }
}
