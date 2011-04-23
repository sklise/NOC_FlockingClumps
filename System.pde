class System
{
  
  ArrayList<Organism> orgs;
  Vec2D avg; // average position of everyone.
  int radius;
  
  System(int pop, int _radius)
  {
    radius = _radius;
    avg = new Vec2D();
    orgs = new ArrayList();
    for(int i = 0; i < pop; i++)
    {
      Vec2D temp = new Vec2D(random(-width/2,width/2),random(-height/2,height/2));
      orgs.add(new Organism(temp, color(#ff0000), 4, 0.003, 0.25, 20, 0.05,100));
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
    for(int i = orgs.size()-1; i>=0; i--)
    {
      Organism o = orgs.get(i);
      if(i < radius/100)
      {
        randomOrg().reset();
      }
      o.run(orgs);
    }
  }
  
  Organism randomOrg()
  {
    return orgs.get((int)random(orgs.size()));
  }
}
