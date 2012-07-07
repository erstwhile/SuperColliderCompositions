{
  Server.default = Server.internal;
  ~t = TempoClock(9);
  //set up our automaton
  ~o = ~otomata.copy();
  //height, width, osc port, midi port
  ~o.create(8,8,8080,0,~automaton);
  ~o.arduinome.clear; // clear lights
  //set a default callback function to trigger synths for new automata 
  ~o.synthFunc = ~synthFunc3;  
  Routine {|inval|	
    inf.do({|i|
      ~o.tick(); // advance automatons 1 position
      1.wait;
    })
  }
}
