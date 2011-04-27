class Ripple
{
  // A Ripple is left behind every time an Organism resets.

  Vec2D loc, acc, vel;
  color c;
  int age;

  Ripple(Vec2D _loc, color _c)
  {
    loc = _loc;
    vel = new Vec2D();
    acc = new Vec2D();
    c = _c;
    age = 0;
  }

  void render()
  {
    if(age <= 20)
    {
    Vec2D offset = new Vec2D(
    noise(loc.x/system.radius+system.offset.x, loc.y/system.radius)-.5, 
    noise(loc.x/system.radius, loc.y/system.radius+system.offset.y)-.5);
    
    acc.addSelf(offset.scaleSelf(.001));
    vel.addSelf(acc);
    loc.addSelf(vel);
    stroke(c,70);
    strokeWeight(1);
    noFill();
    ellipse(loc.x, loc.y, age, age);
    }
    age++;
  }
}

