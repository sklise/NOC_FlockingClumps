class Organism
{
  Vec3D loc;
  Vec3D vel;
  Vec3D acc;
  Vec3D[] tail;
  Vec3D loffset;
  color c;
  float alignment;
  float clumping;
  float separation;
  float speed;
  float force;
  int age;
  int count;
  int lonely = 100;
  int crowded = 1100;

  Organism(Vec3D _loc, color _c, float _alignment, float _clumping, float _separation, float _speed, float _force)
  {
    loc = _loc;
    vel = Vec3D.randomVector();
    tail = new Vec3D[6];
    acc = new Vec3D(0, 0, 0);
    c = _c;
    alignment = _alignment;
    clumping = _clumping;
    separation = _separation;
    speed = _speed;
    force = _force;
    loffset = Vec3D.randomVector();
    age = 0;
    for (int i = 0; i< tail.length; i++)
    {
      tail[i] = new Vec3D();
      tail[i].set(loc);
    }
    count = 0;
  }

  void applyAlignment(ArrayList<Organism> others)
  {
    Vec3D steer = new Vec3D();
    int count = 0;
    for (int i = others.size()-1; i>=0; i--)
    {
      Organism other = others.get(i);
      if (this != other)
      {
        if ( loc.distanceToSquared(other.loc) < system.radius )
        {
          steer.addSelf(other.vel);
          count++;
        }
      }
    }
    if (count > 0)
    {
      if ( count <= lonely || count >= crowded )
      {
        reset();
      }
      steer.scaleSelf(1.0/count);
    }
    if (steer.magSquared()>0)
    { 
      steer.normalizeTo(alignment);
      steer.subSelf(vel);
    }
    acc.addSelf(steer);
  }

  // Clumping and centering.
  void applyCohesion()
  {
    Vec3D cohesion = new Vec3D();
    cohesion.set(loc);
    cohesion.subSelf(system.avg);
    float distanceFromCenter = cohesion.magnitude();
    cohesion.normalize();
    cohesion.scaleSelf(-distanceFromCenter/ (system.radius*system.radius) );
    acc.addSelf(cohesion);
  }

  void movement(ArrayList others)
  {
    // Add a bit of randomness.
    Vec3D offset = new Vec3D(
    noise(loc.x/system.radius+system.offset.x+loffset.x*separation, loc.y/system.radius)-.5, 
    noise(loc.x/system.radius, loc.y/system.radius+system.offset.y+loffset.y*separation)-.5,
    noise(loc.x/system.radius, loc.y/system.radius, loc.z/system.radius+system.offset.y+loffset.y*separation)-.5);
    // Add the random movement
    acc.addSelf(offset.scaleSelf(separation));
    applyCohesion();
    applyAlignment(others);
  }

  void render()
  {
    // Set the stroke opacity to the age of the organism.
    stroke(c, age);
    strokeWeight(5);
    // Draw the current position
    point(loc.x, loc.y, loc.z);
    // Draw the tail
    for (int i = 0; i < tail.length; i++)
    {
      point(tail[i].x, tail[i].y, tail[i].z);
    }
  }


  void reset()
  {
    age = 0;
    loc.set(system.avg);
    loc.addSelf(Vec3D.randomVector().scaleSelf(random(height*2/3)));
    Vec3D temp = new Vec3D();
    temp.set(loc);
    system.rips.add(new Ripple(temp,c));
  }

  // run()
  // the only command necessary to move and draw an Organism.
  void run(ArrayList others)
  {
    acc.clear();
    movement(others);
    update();
    render();
  }

  void update()
  {
    // Get to the next position in the tail.
    if (count == tail.length-1) {
      count = 0;
    }
    else {
      count++;
    }
    tail[count].set(loc);
    // increase the age of the organism
    age = constrain(age+1, 20, 255);
    // Limit acceleration, add to velocity, add to location.
    acc.limit(force);
    vel.addSelf(acc);
    vel.limit(speed);
    loc.addSelf(vel);
  }
}

