float mouthAngle = 45; // Initial angle of Pac-Man's mouth
int animationDuration = 800; // Duration of animation in milliseconds
int startTime; // Variable to store the start time of the animation

int timeCounter = 0;
int currentSecond= 0;

int pacmanX=600;
int pacmanY=200;
int pacmanWidth=100;
int pacmanHeight=100;
int pacmanSpeed=3;
boolean faceRight = true;


int enemyX=200;
int enemyY=200;
int enemySize=100;
int enemySpeed=2;
boolean isEnemyVulnerable = false;


void setup() {
  size(1000, 1000); // Set the size of the canvas to 400x400 pixels
  startTime = millis(); // Record the start time of the animation
}

void draw() {
  background(0); // Set background color to black
  drawPacman();
  
  if(isEnemyVulnerable){
    vulnerabilityChecker();
  }
  drawEnemy();
 
  //collisionDetection();
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
    fill(255,255,255);
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
  fill(255, 255, 0); // Set fill color to yellow
  //arc(pacmanX, pacmanY, pacmanWidth, pacmanHeight, radians(180), radians(400), PIE); // Draw Pac-Man body
  arc(pacmanX, pacmanY, pacmanWidth, pacmanHeight, radians(180+mouthAngle), radians(540-mouthAngle), PIE); // Draw Pac-Man body

   

  fill(255); // Set fill color to white
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

void collisionDetection(){
  // Calculate the distance between Pac-Man and the enemy
  float distance = dist(pacmanX, pacmanY, enemyX, enemyY);
  
  // If the distance is less than the sum of their radii, it means they are colliding
  if (distance < (pacmanWidth / 2 + enemySize / 2)) {
    // Close the window when collision occurs
    exit();
    
  }
}


void vulnerabilityChecker(){
  if(currentSecond != second()){
    timeCounter += 1;
    currentSecond = second();
    println("time counter update == "+timeCounter);
    if(timeCounter !=0 && timeCounter % 3 == 0){
        isEnemyVulnerable = false;
        timeCounter = 0;
        currentSecond = 0;
    }
  }
}

void keyPressed(){
  if(key == ' '){
    faceRight =! faceRight;
    
    //for testing purpose only
    //currentSecond = second();
    //isEnemyVulnerable = true;
    
  }
}
