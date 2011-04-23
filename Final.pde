import toxi.processing.*;
import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.math.*;
import processing.opengl.*;

System system;
ToxiclibsSupport gfx;

void setup()
{
  size(1280, 720);
  smooth();
  gfx=new ToxiclibsSupport(this);
  system = new System(1000,200);
  background(0);
}

void draw()
{
  pushMatrix();
  translate(width/2,height/2);
  background(0);
  system.run();
  popMatrix();
}

