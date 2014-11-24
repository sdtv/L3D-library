import peasy.*;
import L3D.*;
PeasyCam cam;

L3D cube;
float radius=3.5, lineAngle;
PVector center;

void setup()
{
  size(displayWidth, displayHeight, P3D);
  cube=new L3D(this);
  cube.enableDrawing();  //draw the virrtual cube
  cube.enableMulticastStreaming();  //stream the data over UDP to any L3D cubes that are listening on the local network
}

void draw()
{
  background(0);
  cube.background(0);

  for (float theta=0; theta<2*PI; theta+=PI/3)
  {
    PVector start=new PVector(cube.center.x+radius*cos(theta), 0, cube.center.z+radius*sin(theta));
    PVector end=new PVector(cube.center.x+radius*cos(theta+lineAngle), cube.side-1, cube.center.z+radius*sin(theta+lineAngle));
    color col=cube.colorMap(theta%(2*PI), 0, 2*PI);
    cube.line(start, end, col);
  }
  lineAngle+=.05;

  //the cube library draws the cube at the end of the draw() function.  
  //PoseCube() translates and rotates the graphics context to the right angle to display the cube.
  //The displayed cube will be centered about the graphics context's (0,0,0) point
  poseCube();
}

void poseCube()
{
  translate(width/2, height/2);  //move to the center of the display
  rotateX(PI/8);  //notate to a nice angle for vieweing the cube
  rotateY(-PI/8);
}

