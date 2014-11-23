import peasy.*;
import L3D.*;

PeasyCam cam;

L3D cube;
PVector pos;
float inc, radius;
void setup()
{  
  size(displayWidth, displayHeight, P3D);
  cube=new L3D(this);
  cube.enableDrawing();
  cam = new PeasyCam(this, 500);
  cam.setMinimumDistance(100);
  cam.setMaximumDistance(5000);
  randomizePosition();
}

void draw()
{
  background(0);
  rotateX((float) Math.PI);
  translate(-cube.side * cube.scale / 2, -cube.side * cube.scale / 2, -cube.side * cube.scale / 2);
  cube.background(0);
  cube.sphere(pos, radius, color(0,0,255));
  radius+=inc;
  if(radius>cube.side/2)
    randomizePosition();
}

void randomizePosition()
{
  pos=new PVector(random(cube.side),random(cube.side),random(cube.side));
  inc=random(0.1);
  radius=0;
}

