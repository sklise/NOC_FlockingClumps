import toxi.processing.*;
import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.math.*;
import processing.opengl.*;
import peasy.*;

PeasyCam cam;
color[] colors;
System system;
ToxiclibsSupport gfx;
Vec2D cameraCenter;
void setup()
{
  size(1280, 720, P3D);
  smooth();
  background(0);
  cam = new PeasyCam(this,1600);
  gfx=new ToxiclibsSupport(this);
  
  colors = new color[4];
  colors[0] = color(39,233,29);
  colors[1] = color(29,233,216);
  colors[2] = color(255,255,255);
  colors[3] = color(231,233,29);
  
  system = new System(500, 50);
  cameraCenter = new Vec2D();
}

void draw()
{
  
  cameraCenter.scaleSelf(1 -.1);
  cameraCenter.addSelf(system.avg.scale(.1));
  translate(-cameraCenter.x, -cameraCenter.y);
  background(0);
  system.run();
  println(frameRate);
}

