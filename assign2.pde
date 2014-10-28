// global variables
float frogX, frogY, frogW, frogH, frogInitX, frogInitY;
float leftCar1X, leftCar1Y, leftCar1W, leftCar1H;//car1
float leftCar2X, leftCar2Y, leftCar2W, leftCar2H;//car2
float rightCar1X, rightCar1Y, rightCar1W, rightCar1H;//car3
float rightCar2X, rightCar2Y, rightCar2W, rightCar2H;//car4
float pondY;

int currentTime = 0;

float speed;

int life;

final int GAME_START = 1;
final int GAME_WIN = 2;
final int GAME_LOSE = 3;
final int GAME_RUN = 4;
final int FROG_DIE = 5;
int gameState;

// Sprites
PImage imgFrog, imgDeadFrog;
PImage imgLeftCar1, imgLeftCar2;
PImage imgRightCar1, imgRightCar2;
PImage imgWinFrog, imgLoseFrog;

void setup() {
  size(640, 480);
  textFont(createFont("font/Square_One.ttf", 20));
  // initial state
  gameState = GAME_START;

  speed = 5;

  // the Y position of Pond
  pondY = 32;

  // initial position of frog
  frogInitX = 304;
  frogInitY = 448;

  frogW = 32;
  frogH = 32;

  leftCar1W=leftCar2W=rightCar1W=rightCar2W = 32;//all cars' width 
  leftCar1H=leftCar2H=rightCar1H=rightCar2H = 32;//all cars' height
  leftCar1X = leftCar2X = 0; //position X of leftCar1,2
  rightCar1X = rightCar2X =640-rightCar1H;//position X of rightCar1,2

  leftCar1Y = 128;//position Y of leftCar1
  rightCar1Y =192;//position Y of rightCar1
  leftCar2Y  =256;//position Y of leftCar2
  rightCar2Y =320;//position Y of rightCar2

  // prepare the images
  imgFrog = loadImage("data/frog.png");
  imgDeadFrog = loadImage("data/deadFrog.png");
  imgLeftCar1 = loadImage("data/LCar1.png");//img of car1
  imgLeftCar2 = loadImage("data/LCar2.png");//img of car2
  imgRightCar1 = loadImage("data/RCar1.png");//img of car3
  imgRightCar2 = loadImage("data/RCar2.png");//img of car4
  imgWinFrog = loadImage("data/win.png");
  imgLoseFrog = loadImage("data/lose.png");
}

void draw() {
  switch (gameState) {
  case GAME_START:
    background(10, 110, 16);
    text("Press Enter", width/3, height/2);    
    break;
  case FROG_DIE:
    if (millis()-currentTime >= 1000) {
      frogX=frogInitX;
      frogY=frogInitY;
      gameState = GAME_RUN;
    }
  case GAME_RUN:
    background(10, 110, 16);

    // draw Pond
    fill(4, 13, 78);
    rect(0, 32, 640, 32);

    // show frog live
    for (int i=0; i<life; i++) {
      image(imgFrog, 64+i*48, 32);
    }

    // draw frog
    image(imgFrog, frogX, frogY);

    // -------------------------------
    // Modify the following code
    // to meet the requirement
    // -------------------------------

    //car1 move
    leftCar1X += speed;
    if (leftCar1X > width) {
      leftCar1X = 0;
    }
    image(imgLeftCar1, leftCar1X, leftCar1Y);

    //car2 move
    image(imgLeftCar2, leftCar2X, leftCar2Y);
    leftCar2X += speed+2;
    if (leftCar2X > width) {
      leftCar2X = 0;
    }
    //car3 move
    image(imgRightCar1, rightCar1X, rightCar1Y);
    rightCar1X -= speed+1;
    if (rightCar1X < 0) {
      rightCar1X = width;
    }
    //car4 move
    image(imgRightCar2, rightCar2X, rightCar2Y);
    rightCar2X -= speed+5;
    if (rightCar2X < 0) {
      rightCar2X = width;
    }
    float frogCX = frogX+frogW/2;
    float frogCY = frogY+frogH/2;
    // car1 hitTest
    if (rightCar1Y-16<frogY &&  frogY<rightCar1Y+32 && rightCar1X+32>frogX && frogX>rightCar1X-32) {
      currentTime = millis();
      image(imgDeadFrog, frogX, frogY);
      life--;
      println(life);
      gameState = FROG_DIE;
    }    
    // car2 hitTest
    if (rightCar2Y-16<frogY &&  frogY<rightCar2Y+32 && rightCar2X+32>frogX && frogX>rightCar2X-32) {
      currentTime = millis();
      image(imgDeadFrog, frogX, frogY);
      life--;
      gameState = FROG_DIE;
    }   
    // car3 hitTest
    if (leftCar2Y-16<frogY &&  frogY<leftCar2Y+32 && leftCar2X+32>frogX && frogX>leftCar2X-32) {
      currentTime = millis();
      image(imgDeadFrog, frogX, frogY);
      life--;
      gameState = FROG_DIE;
    }  
    // car4 hitTest
    if (leftCar1Y-16<frogY &&  frogY<leftCar1Y+32 && leftCar1X+32>frogX && frogX>leftCar1X-32) {
      currentTime = millis();
      image(imgDeadFrog, frogX, frogY);
      life--;
      println(life);
      gameState = FROG_DIE;
    }

    //FROG PASS RIVER
    if (frogY <= pondY+32) {
      gameState = GAME_WIN;
    }
    //FROG DIE
    if (life==0) {
      gameState = GAME_LOSE;
    }

    break;
  case GAME_WIN:
    background(0);
    image(imgWinFrog, 207, 164);
    fill(255);
    text("You Win !!", 240, height/4);
    break;
  case GAME_LOSE:
    background(0);
    image(imgLoseFrog, 189, 160);
    fill(255);
    text("You Lose", 240, height/4); 
    break;
  }
}
void keyPressed() {
  if (key == CODED /*still needs something*/) {
    switch (keyCode) {
    case UP:
      frogY -=15;
      break;
    case DOWN:
      frogY +=15;
      break;
    case LEFT:
      frogX -=15;
      break;
    case RIGHT:
      frogX +=15;
      println(frogX);
      break;
    }
  }

  if (key==ENTER) {
    gameState = GAME_RUN;
    life=3;
    frogX = frogInitX;
    frogY = frogInitY;
  }
}
