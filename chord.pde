class Chord {
  int[] chord = new int[]{-1,-1,-1,-1,-1,-1};
  boolean palmMute=false;
  
  Chord() {
    return;
  }
  
  Chord(Chord c){
   System.arraycopy(c.chord, 0,this.chord,0,  c.chord.length);
   this.palmMute=c.palmMute;
  }
  
  Chord(int[] chord) {
    for (int s = 0; s < 6; s++) {
        this.chord[s] = chord[s];
    }
  }
  
  Chord(int string, int pos) {
      chord[string] = pos;
  }
  
  String[] toStringArray() {      
    String[] c = new String[6];
    for (int s = 0; s < 6; s++) {
      if (chord[s] == -2) 
        c[s] = "x--";
      else if (chord[s] == -1) 
        c[s] = "---";
      else if (chord[s] >= 10) 
        c[s] = chord[s] + "-";
      else if (chord[s] >= 0) 
        c[s] = chord[s] + "--";     
    }
    return c;
  }
}
