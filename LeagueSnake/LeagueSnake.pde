//*
// ***** SEGMENT CLASS *****
// This class will be used to represent each part of the moving snake.
//*

class Segment {

//Add x and y member variables. They will hold the corner location of each segment of the snake.

  private int x;
  private int y;

// Add a constructor with parameters to initialize each variable.

  Segment(int x, int y) {
    this.x = x;
    this.y = y;
  }
}


//*
// ***** GAME VARIABLES *****
// All the game variables that will be shared by the game methods are here
//*

Segment head;
int foodX;
int foodY;

int direction = UP;
int eaten = 0;

ArrayList<Segment> tail = new ArrayList<Segment>();

//*
// ***** SETUP METHODS *****
// These methods are called at the start of the game.
//*

void setup() {
  size(500, 500);
  head = new Segment(0, 0);
  frameRate(20);
  dropFood();
  
}

void dropFood() {
  //Set the food in a new random location
   foodX = ((int)random(50)*10);
   foodY = ((int)random(50)*10);
}



//*
// ***** DRAW METHODS *****
// These methods are used to draw the snake and its food 
//*

void draw() {
  background(0);
  drawFood();
  move();
  drawSnake();
  eat();
}

void drawFood() {
  //Draw the food
  fill(#FF6464);
  rect(foodX, foodY, 10, 10);
}

void drawSnake() {
  //Draw the head of the snake followed by its tail
  fill(#64FF64);
  rect(head.x, head.y, 10, 10);
  manageTail();
}


//*
// ***** TAIL MANAGEMENT METHODS *****
// These methods make sure the tail is the correct length.
//*

void drawTail() {
  //Draw each segment of the tail 
  for (Segment block : tail) {
    fill(#64ff64);
    rect(block.x, block.y, 10, 10);
  }
  tail.add(new Segment(head.x, head.y));
  tail.remove(0);
}

void manageTail() {
  //After drawing the tail, add a new segment at the "start" of the tail and remove the one at the "end" 
  //This produces the illusion of the snake tail moving.
  checkTailCollision();
  drawTail();
}

void checkTailCollision() {
  //If the snake crosses its own tail, shrink the tail back to one segment
  for (Segment block : tail) {
    if (head.x == block.x && head.y == block.y) {
      eaten = 1;
      tail = new ArrayList<Segment>();
      tail.add(new Segment(head.x, head.y));
    }
  }
}



//*
// ***** CONTROL METHODS *****
// These methods are used to change what is happening to the snake
//*

void keyPressed() {
  //Set the direction of the snake according to the arrow keys pressed
  if (keyCode == UP && direction != DOWN) {
    direction = UP;
  } else if (keyCode == DOWN && direction != UP) {
    direction = DOWN;
  } else if (keyCode == LEFT && direction != RIGHT) {
    direction = LEFT;
  } else if (keyCode == RIGHT && direction != LEFT) {
    direction = RIGHT;
  }
}

void move() {
  //Change the location of the Snake head based on the direction it is moving.
  switch(direction) {
  case UP:
    head.y -= 10;
    break;
  case DOWN:
    head.y += 10;
    break;
  case LEFT:
    head.x -= 10;
    break;
  case RIGHT:
    head.x += 10; 
    break;
  }
  checkBoundaries();
}

void checkBoundaries() {
  //If the snake leaves the frame, make it reappear on the other side
  if (head.x < 0) {
    head.x += 500;
  } else if (head.x > 490) {
    head.x -= 500;
  } else if (head.y < 0) {
    head.y += 500;
  } else if (head.y > 490) {
    head.y -= 500;
  }
}



void eat() {
  //When the snake eats the food, its tail should grow and more food appear
  if (head.x == foodX && head.y == foodY) {
    eaten += 1;
    dropFood();
    for (int i = 0; i < 100; i ++ ) {
      tail.add(new Segment(head.x, head.y));
    }
  }
}
