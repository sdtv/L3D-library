import L3D.*;

L3D cube;
float offset=0;
float fade=0.8;
float m=0;
float minc=1;
void setup()
{
  size(displayWidth, displayHeight, P3D);
  cube=new L3D(this);
  cube.enableDrawing();  //draw the virtual cube
  cube.enableMulticastStreaming();  //stream the data over UDP to any L3D cubes that are listening on the local network
  }

void draw()
{
  background(0);
  cube.background(0);
  
  //uncomment a graph type to see it
  sinusoid();
  //sombrero();
  //spikySharp();
  //intersectingCrosses();
  //torus();
 // teardrop();
  //ripple();

  offset+=0.1;
  translate(width/2, height/2);  //move to the cube.center of the display
  rotateX(PI/8);  //rotate to a nice angle for vieweing the cube
  rotateY(-PI/8);
}

void sinusoid()
{
  float xScale=0.5;
  float zScale=0.3;
  for (float x=0; x<cube.side; x++)
    for (float z=0; z<cube.side; z++)
    {
      float y=map(sin(xScale*x+offset)*cos(zScale*z+offset), -1, 1, 0, cube.side);
      PVector point=new PVector(x, y, z);
      cube.setVoxel(point, cube.colorMap(y, 0, cube.side));
    }
}

//a sombrero function.  Tall hat with a wavy brim
void sombrero()
{
  for (float x=0; x<cube.side; x++)
    for (float z=0; z<cube.side; z++)
    {
      float rho=pow(x-(cube.side/2), 2)+pow(z-(cube.side/2), 2);
      float y=2*cube.side*sin(2*sqrt(rho)+offset)/rho;
      PVector point=new PVector(x, y, z);
      cube.setVoxel(point, cube.colorMap(y, 0, cube.side));
    }
}

//lots of spikes
void spikySharp()
{
float xScale=0.5;
float zScale=0.5;
  for (float x=0; x<cube.side; x++)
    for (float z=0; z<cube.side; z++)
    {
      float y=1/(sin(zScale*abs(x)+x*xScale+offset)-cos(zScale*abs(z)+z*zScale+offset));
      PVector point=new PVector(x, y, z);
      cube.setVoxel(point, cube.colorMap(y, 0, cube.side));
    }
}

void intersectingCrosses()
{
  for (float x=0; x<cube.side; x++)
    for (float z=0; z<cube.side; z++)
    {
      float y=map(0.75/exp(pow(((x-cube.center.x)*2*pow(sin(offset),2)),2)*pow(((z-cube.center.z)*2*pow(sin(offset),2)),2)),0,1,0,cube.side);
      PVector point=new PVector(x, y, z);
      cube.setVoxel(point, cube.colorMap(y, 0, cube.side));
    }
}

void torus()
{
  for (float x=0; x<cube.side; x++)
    for (float z=0; z<cube.side; z++)
    {
      float y=pow(0.4,2)-(0.6-pow(pow(pow((pow((x-cube.center.x),2)+pow((z-cube.center.z),2)),0.5),2),0.5));
      PVector point=new PVector(x, y, z);
      cube.setVoxel(point, cube.colorMap(y, 0, cube.side));
    }
}

void ripple()
{
  for (float x=0; x<cube.side; x++)
    for (float z=0; z<cube.side; z++)
    {
      float y=sin(10*(pow((x-cube.center.x),2)+pow((z-cube.center.z),2))+offset);
      PVector point=new PVector(x, y, z);
      cube.setVoxel(point, cube.colorMap(y, 0, cube.side));
    }
}

//parametric path follows the outline of a teardrop
void teardrop()
{
  float x=cube.center.x+cube.center.x*cos(offset);
   float z=cube.center.z+cube.center.z*sin(offset)*pow(sin(pow(offset,2)),m);
 if(offset>2*PI)
 {
   offset=0;
   m+=minc;
   if((m==0)||(m==7))
     minc*=-1;
 }
 PVector position=new PVector(x,0,z);
 mixVoxel(position,cube.colorMap(m,0,7));
}

void fade()
{
  for (int x=0; x<cube.side; x++)
    for (int y=0; y<cube.side; y++)
      for (int z=0; z<cube.side; z++)
      {
        PVector point=new PVector(x, y, z);
        color currentColor=cube.getVoxel(point);
        color fadedColor=color(red(currentColor)*fade, green(currentColor)*fade, blue(currentColor)*fade);
        cube.setVoxel(point, fadedColor);
      }
}


void mixVoxel(PVector currentPoint, color col)
{
  color currentCol=cube.getVoxel(currentPoint);
  color newCol=color(red(currentCol)+red(col), green(currentCol)+green(col), blue(currentCol)+blue(col));
  cube.setVoxel(currentPoint, newCol);
}

