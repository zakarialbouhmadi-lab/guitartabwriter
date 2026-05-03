Neck neck;
Tablature tab;
ArrayList<Button> uiElements = new ArrayList<Button>();

Button buttonClear, buttonAdd, buttonUpdate;
ToggleSwitch toggleSelectMultiple;

void setup() {
  size(1200,800,P2D);
  windowResizable(true);
  initializeUI();
}

void initializeUI() {
  float marginX = width * 0.05;
  float marginY = height * 0.04;
  float mainWidth = width * 0.75;
  float sidebarX = width * 0.88;
  float btnW = width * 0.1;
  float btnH = height * 0.05;
  float spacing = height * 0.08; 

  neck = new Neck(marginX, marginY, mainWidth, height * 0.45);
  tab = new Tablature(marginX, height * 0.52, mainWidth, height * 0.43);
  
  // --- Initialize Sidebar Buttons ---
  float group1Y = height * 0.05;
  toggleSelectMultiple = new ToggleSwitch(sidebarX, group1Y, btnW, btnH, "CHORDS");
  buttonAdd   = new Button(sidebarX, group1Y + spacing, btnW, btnH, "ADD");
  buttonUpdate = new Button(sidebarX, group1Y + spacing * 2, btnW, btnH, "UPDATE");
  buttonClear = new Button(sidebarX, group1Y + spacing * 3, btnW, btnH, "CLEAR");
  buttonAdd.isEnabled = false;
  buttonClear.isEnabled = false;
  buttonUpdate.isEnabled = false;
  
  
  float group2Y = height * 0.65;
  Button buttonRemove = new Button(sidebarX, group2Y, btnW, btnH, "REMOVE");
  Button buttonSpace  = new Button(sidebarX, group2Y + spacing, btnW, btnH, "SPACE");

  float navY = height * 0.9;
  Button buttonLeft  = new Button(sidebarX - btnW/4 - 5, navY, btnW/2, btnH, "<");
  Button buttonRight = new Button(sidebarX + btnW/4 + 5, navY, btnW/2, btnH, ">");

  // Add all to list for easy rendering
  uiElements.add(toggleSelectMultiple);
  uiElements.add(buttonAdd);
  uiElements.add(buttonClear);
  uiElements.add(buttonRemove);
  uiElements.add(buttonSpace);
  uiElements.add(buttonLeft);
  uiElements.add(buttonRight);
  uiElements.add(buttonUpdate);
  // --- Assign Listeners ---
  toggleSelectMultiple.setListener(new ClickListener() {
    void onButtonClick(Button b) {
      boolean active = ((ToggleSwitch)b).isActive;
      neck.changeSelectionMode(active);
      buttonClear.isEnabled = active;
      buttonAdd.isEnabled = active;
      buttonUpdate.isEnabled = active;
      if(active)
        neck.selectedChord=new Chord(tab.getHighlightedChord());
    }
  });
  
  buttonRemove.setListener(new ClickListener() { void onButtonClick(Button b) { tab.remove(); if(!tab.chords.isEmpty()) neck.selectedChord=new Chord(tab.getHighlightedChord());} });
  buttonRight.setListener(new ClickListener() { void onButtonClick(Button b) { if(tab.selectRight())         neck.selectedChord=new Chord(tab.getHighlightedChord());} });
  buttonLeft.setListener(new ClickListener() { void onButtonClick(Button b) { if(tab.selectLeft())         neck.selectedChord=new Chord(tab.getHighlightedChord());} });
  buttonClear.setListener(new ClickListener() { void onButtonClick(Button b) { neck.selectedChord = new Chord(); } });
  buttonAdd.setListener(new ClickListener() { void onButtonClick(Button b) { tab.add(neck.selectedChord.chord); } });
  buttonSpace.setListener(new ClickListener() { void onButtonClick(Button b) { tab.addSpace(); neck.selectedChord=new Chord(tab.getHighlightedChord()); } });
   buttonUpdate.setListener(new ClickListener() { 
     void onButtonClick(Button b) {
       tab.updateSelected(neck.selectedChord.chord); //<>//
     }     
    });
     
}

void draw() {
  background(C_BG);
  
  neck.update();
  neck.draw();
  tab.draw();
  
  for (Button b : uiElements) {
    b.update();
    b.draw();
  }
}

void mouseClicked() {
  if (neck.isHovered()) {
     neck.onClick();
     if (!neck.selectMultiple) {
       tab.add(neck.selectedChord.chord);
     }
  }
  
  for (Button b : uiElements) {
    if (b.checkClick()) break; // Prevent clicking multiple overlapping elements
  }
}
