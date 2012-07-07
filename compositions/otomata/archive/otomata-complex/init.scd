{|env|
  Server.default = Server.internal;
  ~t = TempoClock(9);
  //set up our automaton
  ~o = ~otomata.copy();
  ~o.create(7,7,8080,0);
	~o.clear; // clear lights
  ~o.synthFunc = {|i|(i**2).postln};  

  Routine {|inval|	
    inf.do({|i|
    		~o.tick(); // advance automatons 1 position
        1.wait;
    })
  }
}
