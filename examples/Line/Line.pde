import peasy.*;
import L3D.*;
PeasyCam cam;

L3D cube;
float offset, radius=3.5, lineAngle;
PVector center;
void setup()
{  
  size(displayWidth, displayHeight, P3D);
  cube=new L3D(this);
  cube.enableDrawing();
  cam = new PeasyCam(this, 500);
  cam.setMinimumDistance(100);
  cam.setMaximumDistance(5000);
}

void draw()
{
  background(0);
  rotateX((float) Math.PI);
  translate(-cube.side * cube.scale / 2, -cube.side * cube.scale / 2, -cube.side * cube.scale / 2);
  cube.background(0);
  
  //for(float theta=0;theta<2*PI;theta+=2*PI/3)
  //  cube.line(new PVector(3.5+radius*cos(theta+offset), 0, 3.5+radius*sin(theta+offset)), new PVector(3.5+radius*cos(theta+PI+offset), cube.side-1, 3.5+radius*sin(theta+PI+offset)), cube.colorMap((theta+offset)%(2*PI), 0, 2*PI));
  for(float theta=0;theta<2*PI;theta+=PI/3)
    cube.line(new PVector(cube.center.x+radius*cos(theta+offset), 0, cube.center.z+radius*sin(theta+offset)), new PVector(cube.center.x+radius*cos(theta+offset+lineAngle), cube.side-1, cube.center.z+radius*sin(theta+offset+lineAngle)), cube.colorMap((theta+offset)%(2*PI), 0, 2*PI));
 // offset+=0.01;
  lineAngle+=.05;
}


