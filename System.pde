class System
{
  
  ArrayList<Organism> orgs;
  Vec2D avg; // average position of everyone.
  Vec2D offset;
  float radius;
  float turbulence;
  
  System(int pop, int _radius, float _turbulence)
  {
    turbulence = _turbulence;
    radius = _radius;
    avg = new Vec2D();
    offset = new Vec2D(1./3, 2./3);
    orgs = new ArrayList();
    for(int i = 0; i < pop; i++)
    {
      Vec2D temp = new Vec2D(random(-width/2,width/2),random(-height/2,height/2));
      orgs.add(new Organism(temp, colors[(int)random(0,colors.length)], 1.3, 0.05, .95, 24, 0.05));
    }
  }
  
  void run()
  {
    avg.clear();
    for(Organism o : orgs)
    {
      avg.addSelf(o.loc);
    }
    avg.scaleSelf(1./orgs.size());
    
    println("average"+avg.x+", "+avg.y+" OFFSET "+offset.x+", "+offset.y);
    for(int i = orgs.size()-1; i>=0; i--)
    {
      Organism o = orgs.get(i);
      if( i < radius/100 )
      {
        //randomOrg().reset();
      }
      o.run(orgs);
    }
    
    offset.addSelf(turbulence / radius, turbulence / radius);
  }
  
  Organism randomOrg()
  {
    return orgs.get((int)random(orgs.size()));
  }
}
