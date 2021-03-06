class System
{

  ArrayList<Organism> orgs;
  ArrayList<Ripple> rips;
  Vec2D avg; // average position of everyone.
  Vec2D offset;
  float radius;
  float turbulence;

  System(int pop, int _radius, float _turbulence)
  {
    // Initialize variables
    turbulence = _turbulence;
    radius = _radius;
    avg = new Vec2D();
    offset = new Vec2D(1./3, 2./3);
    orgs = new ArrayList();
    rips = new ArrayList();
    // Populate the system
    for (int i = 0; i < pop; i++)
    {
      Vec2D temp = new Vec2D(random(-width/2, width/2), random(-height/2, height/2));
      orgs.add(new Organism(temp, colors[(int)random(0, colors.length)], .65, 0.1, 1.5, 5, 0.5));
    }
  }

  void run()
  {
    avg.clear();
    for (Organism o : orgs)
    {
      avg.addSelf(o.loc);
    }
    avg.scaleSelf(1./orgs.size());

    for (Ripple r : rips)
    {
      r.render();
    }
    if (rips.size()>0)
    {
      rips.remove(0); // remove the first Ripple, these things are momentary.
    }

    for (int i = orgs.size()-1; i>=0; i--)
    {
      Organism o = orgs.get(i);
      o.run(orgs);
    }

    offset.addSelf(turbulence / radius, turbulence / radius);
  }

  Organism randomOrg()
  {
    return orgs.get((int)random(orgs.size()));
  }
}

