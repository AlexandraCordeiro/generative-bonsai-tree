int windowWidth = 1000;
int windowHeight = 800;
float w = windowWidth * 0.8;
float h = windowHeight * 0.1;



void settings() {
  size(windowWidth, windowHeight);
}

void setup() {
  
  // center canvas
  push();
  translate(windowWidth*0.5, windowHeight*0.9);
  drawBase();
  drawPot();
  drawTrunk();
  pop();
  save("bonsai.jpg");
  
}

/*void draw() {}*/

// Bonsai

void drawBase() {
  // base
  noStroke();
  int offset = 7;
  int r = 7;
  
  for (float x = -w*0.5; x < w*0.5; x+=offset) {
    float y;
    fill(#561C24, random(150, 255));
    //top
    y = -h*0.5;
    circle(x, y + r*0.5, r);
    //bottom
    y = h*0.5;
    circle(x, y, r);
    
    //sides
    if (x == -w*0.5 || x + offset >= w*0.5) {
      for (float i = -h*0.5 + r ; i < h*0.5; i+=offset) {
        circle(x, i, r);
      }
      
    }
  }
  
  // base 2
  float w2 = w / 8;
  float h2 = h / 6;
  
  for (float x = -w*0.5; x < w*0.5; x+=offset) {
    float y =  h*0.5 + h2;
    fill(#561C24, random(150, 255));
    //left
    if (x < (-w*0.5 +  w2)) {
      circle(x, y, r);
      circle(x, y + r, r);
      circle(x, y + r*2, r);
    }
    //right
    if (x > (w*0.5 -  w2)) {
      circle(x, y, r);
      circle(x, y + r, r);
      circle(x, y + r*2, r);
    }
    
  }
 
}

void drawPot() {
  float aux = w / 6;
  float a = w*0.5 - aux;
  int offset = 7;
  
  // y = x - a
  // y = x + a
  
  for (float x = -w*0.5; x < w*0.5; x += offset) {
    float y;
    float r = 7;
    
    noStroke();
    fill(1, 1, 1, random(150, 255));
    
    //bottom
    if (x > -a && x < a) circle(x, h*0.5 - h, r);
    //top
    circle(x, -h*0.5 - h, r);
    circle(x, -h*0.5 - h + r, r);
    //sides
    y = (x + a) - h*0.5;
    if ( (x < - a && y > -h*0.5 - h)) {
      circle(x, y , r);
    }
    
    y = -(x - a) - h*0.5;
    if ((x > a && y > -h*0.5 - h)) {
      circle(x, y , r);
    }
  }
}

void leaf(float x, float y, int maxLen) {
  int n = int(random(0, maxLen));
  for (int i = 0; i < n; i++) {
    float r = random(10, 30);
    fill(#294B29, random(50, 100));
    // down
    circle(x, y + r, r);
    // up
    circle(x, y - r, r);
    y += r;
  }
}

void newBranch(float xi, float yi, int direction, int depth) {

  int n = 1;
  int i;
  float branchDirection = random(-1,1);
  float branchInclination = random(10, 30);
  float branchLength = random(50, 150);
  float newY = branchDirection * branchInclination * sqrt(n) + yi;
  int offset = 12;
  float maxHeight = -h*7;
  
  if (depth <= 0 || yi < maxHeight || xi + branchLength > w*0.7 || xi - branchLength < - w*0.7) {
    return;
  }
  
  for (i = int(xi); i < int(xi)+branchLength; i+=offset) {
    newY = branchDirection * branchInclination * sqrt(n) + yi;
    fill(#561C24, random(150, 200));
    circle(direction*i, newY, random(5, 15)); 
    leaf(direction * i, newY, 2);
    n++;
  }
  newBranch(i, newY, direction, depth-1);
}


void drawBranch(float xi, float yi, int direction, int depth) {
  
  int n = 1;
  int i;
  float branchDirection = random(-1,1);
  float branchInclination = random(10, 30);
  float branchLength = random(50, 150);
  int offset = 12;
  float maxHeight = -h*7;
  float newY = branchDirection * branchInclination * sqrt(n) + yi;
  
  if (depth <= 0 || yi < maxHeight || xi + branchLength > w*0.7 || xi - branchLength < - w*0.7) {
    return;
  }
  

  for (i = int(xi); i < int(xi)+branchLength; i+=offset) {
    newY = branchDirection * branchInclination * sqrt(n) + yi;
    fill(#561C24, random(150, 200));
    circle(direction*i, newY, random(5, 15));
    leaf(direction * i, newY, 3);
    if (i%5==0) {
      newBranch(i, newY, direction, 2);
      println(direction, "addLeaf");
    }    
    n++;
    
  }

  drawBranch(i, newY, direction, depth -1);
}


void drawTrunk() {
  
  float aux = w / 4;
  int a = int(w*0.5 - aux);
  int offset = 10;
  float maxY = -1.7*a;
  
  float leftX = -1;
  float rightX = -1;
  
  // left side of the trunk
  for (int x = -a; x < 0; x+=offset) {
    float y = -0.008*pow(x+a, 2) - h*1.5;
    if (y > maxY && y < -1.5*h) {
      noStroke();
      fill(#561C24, random(150, 200));
      circle(x, y, random(5, 15));
    }
    
  }
  
  
  // right side of the trunk
  for (int y = int(maxY); y < 0; y+=offset) {
    float x = 0.008*pow(y+a*0.9, 2);
    
    if (y - h > maxY && y - h < -1.5*h && x < a) {
      noStroke();
      fill(#561C24, random(150, 200));
      circle(x, y - h, random(5, 15));
      if (rightX == -1) rightX = x;
      
    }
  }
  
  drawBranch(leftX, maxY, -1, 100);
  drawBranch(rightX, maxY, 1, 100);
  
}