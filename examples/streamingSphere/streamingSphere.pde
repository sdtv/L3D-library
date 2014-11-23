import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

import L3D.*;
PeasyCam cam;

L3D cube;
PVector pos;
float inc, radius;
String accessToken="XXXXXXXXXXX";  //set this to your spark access token
String coreName="XXXXXXXXXX";  //change this name to your core's name

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
  if(radius>cube.side)
    randomizePosition();
}

void randomizePosition()
{
  pos=new PVector(random(cube.side),random(cube.side),random(cube.side));
  inc=0.05+random(0.05);
  radius=0;
}

