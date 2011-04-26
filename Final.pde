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
Vec2D cameraCenter; // keep the main amount of organisms in view

void setup()
{
  size(1280, 720, OPENGL);
  smooth();
  background(0);
  cam = new PeasyCam(this,700);
  cameraCenter = new Vec2D();
  gfx=new ToxiclibsSupport(this);
  
  // The colors for the organisms.
  colors = new color[6];
  colors[0] = color(39,233,29);
  colors[1] = color(100,022,173);
  colors[2] = color(255,255,255);
  colors[3] = color(231,233,29);
  colors[4] = color(254,74,11);
  colors[5] = color(133,5,145);
  
  // Initialize the system
  system = new System(1200, 50, 1.6);
}

void draw()
{
  cameraCenter.scaleSelf(1 -.1); // damping
  cameraCenter.addSelf(system.avg.scale(.1)); // adjust camera position to the average location of organisms
  translate(-cameraCenter.x, -cameraCenter.y);
  
  background(0);
  system.run();
  println(frameRate);
}

