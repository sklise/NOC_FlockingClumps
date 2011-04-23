class Organism
{
  Vec2D loc;
  Vec2D vel;
  Vec2D acc;
  color c;
  float alignment;
  float clumping;
  float separation;
  float speed;
  float force;
  float vision;
  int age;
  
  Organism(Vec2D _loc, color _c, float _alignment, float _clumping, float _separation, float _speed, float _force, float _vision)
  {
    loc = _loc;
    vel = Vec2D.randomVector();
    acc = new Vec2D(0,0);
    c = _c;
    alignment = _alignment;
    clumping = _clumping;
    separation = _separation;
    speed = _speed;
    force = _force;
    vision = _vision;
    age = 0;
  }
  
  void applyAlignment(ArrayList<Organism> others)
  {
    Vec2D steer = new Vec2D();
    int count = 0;
    for(int i = others.size()-1; i>=0; i--)
    {
      Organism other = others.get(i);
      if(this != other)
      {
        if(loc.distanceToSquared(other.loc) < vision)
        {
          steer.addSelf(other.vel);
          count++;
        }
      }
    }
    if(count > 0)
    {
      steer.scaleSelf(1.0/count);
    }
    if(steer.magSquared()>0)
    { 
      steer.normalizeTo(alignment);
      steer.subSelf(vel);
    }
    acc.addSelf(steer);
  }
  
  void applyCohesion()
  {
    // Clumping and centering.
    Vec2D cohesion = new Vec2D();
    cohesion.set(loc);
    cohesion.subSelf(system.avg);
    float distanceFromCenter = cohesion.magnitude();
    cohesion.normalize();
    cohesion.scaleSelf(-clumping*distanceFromCenter);
    acc.addSelf(cohesion);
  }
  
  void movement(ArrayList others)
  {
    // Add a bit of randomness.
    Vec2D offset = new Vec2D(random(-1,1),random(-1,1));
    acc.addSelf(offset.scaleSelf(separation));
    applyCohesion();
    applyAlignment(others);
  }
  
  void render()
  {
    stroke(255,age);
    strokeWeight(2);
    point(loc.x,loc.y);
  }
  
  void reset()
  {
    age = 0;
    loc = Vec2D.randomVector();
    loc.scaleSelf(random(system.radius));
  }
  
  void run(ArrayList others)
  {
    acc.clear();
    movement(others);
    update();
    render();
  }
  
  void update()
  {
    age = constrain(age+1,30,255);
    acc.limit(force);
    vel.addSelf(acc);
    loc.addSelf(vel);
    vel.scale(speed);
  }
}
