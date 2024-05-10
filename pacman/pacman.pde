float mouthAngle = 45; // Initial angle of Pac-Man's mouth
int animationDuration = 800; // Duration of animation in milliseconds
int startTime; // Variable to store the start time of the animation

void setup() {
  size(400, 400); // Set the size of the canvas to 400x400 pixels
  startTime = millis(); // Record the start time of the animation
}

void draw() {
  background(0); // Set background color to black
  drawPacman();
}

void drawPacman() {
  fill(255, 255, 0); // Set fill color to yellow
  arc(200, 200, 100, 100, radians(mouthAngle), radians(360 - mouthAngle), PIE); // Draw Pac-Man body

  fill(255); // Set fill color to white
  ellipse(190, 190, 10, 10); // Draw Pac-Man eye

  // Update mouth angle based on elapsed time
  int elapsedTime = millis() - startTime;
  int value=elapsedTime % animationDuration;
  
    println("elapsed time == "+elapsedTime);
    println("value is == "+value);
  mouthAngle = map(value, 0, animationDuration, 45, 0);
}
