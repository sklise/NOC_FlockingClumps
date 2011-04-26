class System
{

  ArrayList<Organism> orgs;
  Vec2D avg; // average position of everyone.
  Vec2D offset;
  float radius;
  float turbulence;

  // Bin-Lattice
  int resolution = 30;
  int cols;
  int rows;
  ArrayList<Organism>[][] grid;

  System(int pop, int _radius, float _turbulence)
  {
    // Initialize variables
    turbulence = _turbulence;
    radius = _radius;
    avg = new Vec2D();
    offset = new Vec2D(1./3, 2./3);
    orgs = new ArrayList();
    
    // Get the Bin-Lattice Ready
    cols = width/resolution;
    rows = height/resolution;
    grid = new ArrayList[cols][rows];
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        grid[i][j] = new ArrayList<Organism>();
      }
    }
    
    // Populate the system
    for (int i = 0; i < pop; i++)
    {
      Vec2D temp = new Vec2D(random(-width/2, width/2), random(-height/2, height/2));
      orgs.add(new Organism(temp, colors[(int)random(0, colors.length)], 1.75, 0.2, .55, 24, 0.05));
    }
  }

  void run()
  {
    avg.clear();
    for (Organism o : orgs)
    {
      avg.addSelf(o.loc);
      int x = int(o.loc.x)/resolution;
      int y = int(o.loc.y)/resolution;
      for(int n = -1; n<=1; n++)
      {
        for(int m = -1; m<=1; m++)
        {
          if(x+n >= 0 && x+n < cols && y+m >= 0 && y+m< rows)
          {
            grid[x+n][y+m].add(o);
          }
        }
      }
    }
    
    avg.scaleSelf(1./orgs.size());
    
    for(int i=0; i < cols; i++){
      for(int j=0; j<rows; j++){
        ArrayList<Organism> temp = grid[i][j];
        if(temp.size() >200)
        {
          for(Organism o : temp)
          {
            o.reset();
          }
        }
      }
    }
    
    for (int i = orgs.size()-1; i>=0; i--)
    {
      Organism o = orgs.get(i);
      if ( i < radius/100 )
      {
        randomOrg().reset();
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

