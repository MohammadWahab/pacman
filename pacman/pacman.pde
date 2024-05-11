float mouthAngle = 45; // Initial angle of Pac-Man's mouth
int animationDuration = 800; // Duration of animation in milliseconds
int startTime; // Variable to store the start time of the animation


int pacmanX=200;
int pacmanY=200;
int pacmanWidth=100;
int pacmanHeight=100;
int pacmanSpeed=3;


boolean faceRight = true;

void setup() {
  size(1000, 1000); // Set the size of the canvas to 400x400 pixels
  startTime = millis(); // Record the start time of the animation
}

void draw() {
  background(0); // Set background color to black
  drawPacman();
}

void drawPacman() {
  if(faceRight){
    mouthDirectionRight();
  }else{
    mouthDirectionLeft();
  }
  
  mouthAnimation();
  //movement();
  

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
 
  pacmanX += pacmanSpeed ;
  int radius= pacmanWidth / 2;
  
 if ((pacmanX  - radius)>width){
    pacmanX = - radius;
   
 }

}

void keyPressed(){
  if(key == ' '){
    faceRight =! faceRight;
  }
}
