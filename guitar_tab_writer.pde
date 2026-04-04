Neck neck;
Tablature tab;
Button buttonRemove, buttonRight, buttonLeft, buttonSpace, buttonClear, buttonAdd;
ToggleButton toggleSelectMultiple;

void setup() {
  size(900, 700, P2D);
  // Initialize the neck and tablature UI areas
  neck = new Neck(50, 30, 700, 300);
  tab = new Tablature(50, 370, 700, 300);
  buttonRemove = new Button(800, 500, width/10, height/15, "REMOVE");
  buttonRight = new Button(830, 600, width/20, height/15, "->");
  buttonLeft = new Button(770, 600, width/20, height/15, "<-");

  toggleSelectMultiple = new ToggleButton(800, 200, width/10, height/15, "CHORDS");
  addListeners();
}

void draw() {
  background(170);
  neck.update();
  neck.draw();
  tab.draw();
  updateAllButtons();
  drawAllButtons();
 
}

void mouseClicked() {
  if (neck.intersectsWithCursor() && neck.selectedFret != -1 && neck.selectedString != -1) {
    tab.add(neck.selectedFret, neck.selectedString);
  }
   checkButtonsClicked();
}


void updateAllButtons(){
   buttonRemove.update();
  buttonLeft.update();
  buttonRight.update();
  toggleSelectMultiple.update();
}

void drawAllButtons(){
  buttonRemove.draw();
  buttonLeft.draw();
  buttonRight.draw();
  toggleSelectMultiple.draw();
}

void checkButtonsClicked(){
  toggleSelectMultiple.checkClick();
   buttonRemove.checkClick();  
   buttonRight.checkClick();
   buttonLeft.checkClick();
}

void addListeners(){
  buttonRemove.setListener(new ClickListener(){
       void onButtonClick(Button b){
         tab.remove();
       }
  });
  buttonRight.setListener(new ClickListener(){
       void onButtonClick(Button b){
         tab.selectRight();
       }
  });
   buttonLeft.setListener(new ClickListener(){
       void onButtonClick(Button b){
         tab.selectLeft();
       }
  });

}
