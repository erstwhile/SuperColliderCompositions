{
  Server.default = Server.internal;
  
  // set up routine
  r = Routine { arg inval;	

  	// automaton sound

  	o = Otomata.new(\automaton);
  	o.synthFunc = ~synthFunc;

  	~o =o;

  	o.clear; // clear lights


  	loop {
  	  o.synthFunc = ~synthFunc;  
  		o.tick; // advance automatons 1 position
  		1.0.yield;		
  	}
  }.play(~t);
}
