float mouthAngle = 45; // Initial angle of Pac-Man's mouth
int animationDuration = 800; // Duration of animation in milliseconds
int startTime; // Variable to store the start time of the animation

int score = 0;
int vulnerabilityTimeCounter = 0;
int currentSecondVulnerability= 0;


int pacmanX=400;
int pacmanY=100;
int pacmanWidth=40;
int pacmanHeight=40;
int pacmanSpeed=3;
boolean faceRight = true;


float enemyX=350;
int enemyY=100;
int enemySize=40;
float enemySpeed=2.5;
boolean isEnemyVulnerable = false;


int fruitTimeCounter = 0;
int fruitCurrentSecond = 0;

int fruitX=50;
int fruitY = 100;
int fruitSize=30;
boolean fruitEaten =false;



int resetTimeCounter = 0;
int resetCurrentSecond = 0;
boolean palletsReset = false;

int pellet1X = 450;
int pellet1Y = 100;
boolean pellet1Eaten = false;

int pellet2X = 500;
int pellet2Y = 100;
boolean pellet2Eaten = false;

int pellet3X = 550;
int pellet3Y = 100;
boolean pellet3Eaten = false;

int pellet4X = 600;
int pellet4Y = 100;
boolean pellet4Eaten = false;

int pellet5X = 650;
int pellet5Y = 100;
boolean pellet5Eaten = false;

int pellet6X = 700;
int pellet6Y = 100;
boolean pellet6Eaten = false;

int pellet7X = 750;
int pellet7Y = 100;
boolean pellet7Eaten = false;


int pellet8X = 100;
int pellet8Y = 100;
boolean pellet8Eaten = false;

int pellet9X = 150;
int pellet9Y = 100;
boolean pellet9Eaten = false;

int pellet10X = 200;
int pellet10Y = 100;
boolean pellet10Eaten = false;

int pellet11X = 250;
int pellet11Y = 100;
boolean pellet11Eaten = false;

int pellet12X = 300;
int pellet12Y = 100;
boolean pellet12Eaten = false;





void setup() {
  size(800, 200); 
  startTime = millis();
}

void draw() {
  background(0); 
  drawTrack();
  drawPacman();
  if(isEnemyVulnerable){
    vulnerabilityChecker();
  }
  drawEnemy();
  drawPellets();
  if(palletsReset){
    resetPalletChceker();
  }
  drawFruit();
  if(fruitEaten){
    resetFruit();
  }
  palletsCollisionDetection();
  if(!fruitEaten){
    fruitCollisionDetection();
  }
  
 collisionDetection();
 displayScore();
}

void drawTrack(){
  stroke(0, 0, 255); 
  strokeWeight(10);  
  line(0, 50, width, 50); 
  line(0, 140, width, 140); 

  noStroke(); 
}

void drawPacman() {
  if(faceRight){
    mouthDirectionRight();
  }else{
    mouthDirectionLeft();
  }
  
  mouthAnimation();
  movement();
}

void drawEnemy(){
  if(isEnemyVulnerable){
    fill(255, 165, 0);
  }else{
    fill(255, 0, 0);
  }
  ellipse(enemyX, enemyY, enemySize, enemySize); // Draw the enemy as a red circle
  bouncingMovement();
}


void mouthAnimation(){
  // Update mouth angle based on elapsed time
  int elapsedTime = millis() - startTime;
  int value=elapsedTime % animationDuration;
  
  mouthAngle = map(value, 0, animationDuration, 45, 0);
}


void mouthDirectionRight(){
  fill(255, 255, 0); // Set fill color to yellow
  arc(pacmanX, pacmanY, pacmanWidth, pacmanHeight, radians(mouthAngle), radians(360 - mouthAngle), PIE); // Draw Pac-Man body

  fill(255); // Set fill color to white
  ellipse(pacmanX-10, pacmanY-10, 10, 10); // Draw Pac-Man eye
  
}

void mouthDirectionLeft(){
  fill(255, 255, 0); 
  arc(pacmanX, pacmanY, pacmanWidth, pacmanHeight, radians(180+mouthAngle), radians(540-mouthAngle), PIE); 
  fill(255); 
  ellipse(pacmanX-3, pacmanY-16, 10, 10); // Draw Pac-Man eye
}


void movement(){
  int radius= pacmanWidth / 2;
  if(faceRight){
  pacmanX += pacmanSpeed ;
  if ((pacmanX  - radius)>width){
    pacmanX = - radius;
   
 }
 }else{
   pacmanX -= pacmanSpeed;
   if((pacmanX+radius)<0){
     pacmanX=width+radius;
   }
 }

}

void bouncingMovement(){
  int radius = enemySize/2;
  enemyX = enemyX + enemySpeed;
  if((enemyX + radius)>width){
    enemySpeed=-abs(enemySpeed);
  }
  else if((enemyX - radius)<0){
    enemySpeed = abs(enemySpeed);
  }
}

void drawFruit(){
  if(!fruitEaten){
    fill(255, 192, 203); // Red color for the apple
    ellipse(fruitX, fruitY, fruitSize, fruitSize); // Draw the apple body

    stroke(139, 69, 19); // Brown color for the stem
    strokeWeight(5); // Thicker line for the stem
    line(fruitX, fruitY - fruitSize / 2, fruitX, fruitY - fruitSize / 2 - 10);
    
    fill(34, 139, 34); // Green color for the leaf
    noStroke(); // Disable stroke for the leaf
    ellipse(fruitX + 10, fruitY - fruitSize / 2 - 10, 20, 10); // Draw the leaf
  }
   
}

void resetPalletChceker(){
  if(resetCurrentSecond != second()){
    resetTimeCounter += 1;
    resetCurrentSecond = second();
    if(resetTimeCounter !=0 && resetTimeCounter % 5 == 0){
        palletsReset = false;
        resetTimeCounter = 0;
        resetCurrentSecond = 0;
        resetAllPallets();
    }
  }
  
}

void drawPellets() {
  fill(255); // Set fill color to white
  if (!pellet1Eaten) {
    ellipse(pellet1X, pellet1Y, 10, 10); // Draw pellet 1
  }
  if (!pellet2Eaten) {
    ellipse(pellet2X, pellet2Y, 10, 10); // Draw pellet 2
  }
  if (!pellet3Eaten) {
    ellipse(pellet3X, pellet3Y, 10, 10); // Draw pellet 3
  }
   if (!pellet4Eaten) {
    ellipse(pellet4X, pellet4Y, 10, 10); // Draw pellet 1
  }
  if (!pellet5Eaten) {
    ellipse(pellet5X, pellet5Y, 10, 10); // Draw pellet 2
  }
  if (!pellet6Eaten) {
    ellipse(pellet6X, pellet6Y, 10, 10); // Draw pellet 3
  }
   if (!pellet7Eaten) {
    ellipse(pellet7X, pellet7Y, 10, 10); // Draw pellet 3
  }
     if (!pellet8Eaten) {
    ellipse(pellet8X, pellet8Y, 10, 10); // Draw pellet 3
  }
     if (!pellet9Eaten) {
    ellipse(pellet9X, pellet9Y, 10, 10); // Draw pellet 3
  }
     if (!pellet10Eaten) {
    ellipse(pellet10X, pellet10Y, 10, 10); // Draw pellet 3
  }
     if (!pellet11Eaten) {
    ellipse(pellet11X, pellet11Y, 10, 10); // Draw pellet 3
  }
   if (!pellet12Eaten) {
    ellipse(pellet12X, pellet12Y, 10, 10); // Draw pellet 3
  }
}

void collisionDetection(){
  float distance = dist(pacmanX, pacmanY, enemyX, enemyY);
  
  if (distance < (pacmanWidth / 2 + enemySize / 2)) {
    exit(); 
  }
}

void vulnerabilityChecker(){
  if(currentSecondVulnerability != second()){
    vulnerabilityTimeCounter += 1;
    currentSecondVulnerability = second();
    if(vulnerabilityTimeCounter !=0 && vulnerabilityTimeCounter % 3 == 0){
        isEnemyVulnerable = false;
        vulnerabilityTimeCounter = 0;
        currentSecondVulnerability = 0;
    }
  }
}



void displayScore() {
  fill(0,255,0); 
  textSize(20); 
  text("Score: " + score, 10, 30); 
  
  if(isEnemyVulnerable){
     text("Enemy is vulnerable", 300, 30); 
  }
  
  if(score != 0 && score % 120 == 0){
    palletsReset = true;
  }
}

void resetAllPallets(){
  pellet1Eaten = false;
  pellet2Eaten = false;
  pellet3Eaten = false;
  pellet4Eaten = false;
  pellet5Eaten = false;
  pellet6Eaten = false;
  pellet7Eaten = false;
  pellet8Eaten = false;
  pellet9Eaten = false;
  pellet10Eaten = false;
  pellet11Eaten = false;
  pellet12Eaten = false;
}

void resetFruit(){
  if(fruitCurrentSecond != second()){
    fruitTimeCounter += 1;
    fruitCurrentSecond = second();
    if(fruitTimeCounter !=0 && fruitTimeCounter % 10 == 0){
        fruitEaten = false;
        fruitTimeCounter = 0;
        fruitCurrentSecond = 0;
    }
  }
}

void palletsCollisionDetection(){
  if (!pellet1Eaten) {
    float distance = dist(pacmanX, pacmanY, pellet1X, pellet1Y);
    if (distance < (pacmanWidth / 2 + 5)) { 
      pellet1Eaten = true; 
      score+=10; 
    }
  }
  if (!pellet2Eaten) {
    float distance = dist(pacmanX, pacmanY, pellet2X, pellet2Y);
    if (distance < (pacmanWidth / 2 + 5)) { 
      pellet2Eaten = true; 
      score+=10;     
    }
  }
  if (!pellet3Eaten) {
    float distance = dist(pacmanX, pacmanY, pellet3X, pellet3Y);
    if (distance < (pacmanWidth / 2 + 5)) { 
      pellet3Eaten = true; 
      score+=10;  
    }
  }
  if (!pellet4Eaten) {
    float distance = dist(pacmanX, pacmanY, pellet4X, pellet4Y);
    if (distance < (pacmanWidth / 2 + 5)) { 
      pellet4Eaten = true; 
      score+=10;  
    }
  }
  if (!pellet5Eaten) {
    float distance = dist(pacmanX, pacmanY, pellet5X, pellet5Y);
    if (distance < (pacmanWidth / 2 + 5)) { 
      pellet5Eaten = true; 
      score+=10;  
    }
  }
    if (!pellet6Eaten) {
    float distance = dist(pacmanX, pacmanY, pellet6X, pellet6Y);
    if (distance < (pacmanWidth / 2 + 5)) { 
      pellet6Eaten = true; 
      score+=10;  
    }
  }
    if (!pellet7Eaten) {
    float distance = dist(pacmanX, pacmanY, pellet7X, pellet7Y);
    if (distance < (pacmanWidth / 2 + 5)) { 
      pellet7Eaten = true; 
      score+=10;  
    }
  }
  
    if (!pellet8Eaten) {
    float distance = dist(pacmanX, pacmanY, pellet8X, pellet8Y);
    if (distance < (pacmanWidth / 2 + 5)) { 
      pellet8Eaten = true; 
      score+=10;  
    }
  }
    if (!pellet9Eaten) {
    float distance = dist(pacmanX, pacmanY, pellet9X, pellet9Y);
    if (distance < (pacmanWidth / 2 + 5)) { 
      pellet9Eaten = true; 
      score+=10;  
    }
  }
    if (!pellet10Eaten) {
    float distance = dist(pacmanX, pacmanY, pellet10X, pellet10Y);
    if (distance < (pacmanWidth / 2 + 5)) { 
      pellet10Eaten = true; 
      score+=10;  
    }
  }
    if (!pellet11Eaten) {
    float distance = dist(pacmanX, pacmanY, pellet11X, pellet11Y);
    if (distance < (pacmanWidth / 2 + 5)) { 
      pellet11Eaten = true; 
      score+=10;  
    }
  }  if (!pellet12Eaten) {
    float distance = dist(pacmanX, pacmanY, pellet12X, pellet12Y);
    if (distance < (pacmanWidth / 2 + 5)) { 
      pellet12Eaten = true; 
      score+=10;  
     
    }
  }
}

void fruitCollisionDetection(){
  float distance = dist(pacmanX, pacmanY, fruitX, fruitY);
    if (distance < (pacmanWidth / 2 + fruitSize/2)) { 
      fruitEaten = true; 
      currentSecondVulnerability= second();
      isEnemyVulnerable = true;
       
    }
}

void keyPressed(){
  if(key == ' '){
    faceRight =! faceRight;  
  }
}
