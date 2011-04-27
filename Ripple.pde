class Ripple
{
  // A Ripple is left behind every time an Organism resets.

  Vec3D loc, acc, vel;
  color c;
  int age;

  Ripple(Vec3D _loc, color _c)
  {
    loc = _loc;
    vel = new Vec3D();
    acc = new Vec3D();
    c = _c;
    age = 0;
  }

  void render()
  {
    if(age <= 20)
    {
    Vec3D offset = new Vec3D(
    noise(loc.x/system.radius+system.offset.x, loc.y/system.radius)-.5, 
    noise(loc.x/system.radius, loc.y/system.radius+system.offset.y)-.5,
    noise(loc.x/system.radius, loc.y/system.radius+system.offset.y)-.5);
    
    acc.addSelf(offset.scaleSelf(.001));
    vel.addSelf(acc);
    loc.addSelf(vel);
    stroke(c);
    strokeWeight(1);
    noFill();
    pushMatrix();
    translate(0,0,loc.z);
    ellipse(loc.x, loc.y, age, age);
    popMatrix();
    }
    age++;
  }
}

