import L3D.*;

L3D cube;
PVector voxel=new PVector(3,3,3);  //this is the voxel that we'll blink

void setup()
{
  size(displayWidth, displayHeight, P3D);
  cube=new L3D(this);
  cube.enableDrawing();  //draw the virtual cube
  cube.enableMulticastStreaming();  //stream the data over UDP to any L3D cubes that are listening on the local network
  cube.enablePoseCube();
}

void draw()
{
  background(0);
  cube.background(0);
  if ((frameCount%20)>10)    //turn the LED on for ten frames, then off for ten frames
    cube.setVoxel(voxel, color(255, 0, 0));
}

