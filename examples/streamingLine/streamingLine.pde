import peasy.*;
import L3D.*;
PeasyCam cam;

L3D cube;
float offset, radius=4;
String accessToken="XXXXXXXXXXXXX";   //your spark access token
String coreName="XXXXXXXX";   //the name of your spark core
void setup()
{  
  size(displayWidth, displayHeight, P3D);

  /*
  //for direct streaming to a specific core
  //your target cube must be running the Listener firmware
  cube=new L3D(this, accessToken);
  cube.streamToCore(coreName);
  */
  
  //for multicast streaming on a network
  //your target cube must be running the Listener firmware
  cube=new L3D(this);
  cube.enableMulticastStreaming();
  
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
  for(float theta=0;theta<2*PI;theta+=2*PI/3)
    cube.line(new PVector(3.5+radius*cos(theta+offset), 0, 3.5+radius*sin(theta+offset)), new PVector(3.5+radius*cos(theta+PI+offset), cube.side-1, 3.5+radius*sin(theta+PI+offset)), cube.colorMap((theta+offset)%(2*PI), 0, 2*PI));
  offset+=0.1;
}


