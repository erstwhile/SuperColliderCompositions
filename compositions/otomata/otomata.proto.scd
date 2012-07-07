~otomata = Proto({
  ~n =0;
  ~a;
  ~coltab;
  ~width; ~height; ~gridsize;
  ~prefix; ~oscport; ~midiport;
  ~osc; ~midi;
  ~arduinome;
  ~synthname = "oto-sine";
  ~width = 8; ~height = 8; ~gridsize = 64;
  //leave synthFunc as a placeholder variable - it's a callback function, not a method
  ~synthFunc=true;
  //# of ticks this Otomata has been alive
  ~age=0;

  ~create = {|width=8, height=8, oscport=8080, midiport=0|
    ~width = width;
    ~height = height;
    ~gridsize = width*height;
    ~oscport = oscport;
    ~midiport = midiport;
    ~a = List.new;      
    ~coltab = Array.newClear(~gridsize);
    // set up osc
    ~prefix = "oto";
    ~arduinome = Arduinome.new(~prefix, ~oscport);
    // register osc responder for button presses
    ~osc = OSCresponder( nil, ~prefix++"/press",
      inEnvir {|time, responder, message, address|
        var freq, midinote, cmd, row, col, onoff;
        cmd = message.at(0);
        row = message.at(1);
        col = message.at(2);
        onoff = message.at(3);
        (onoff==1).if({~add.([row,col],~arduinome);}, {});
    }).add;
    // setup midi output
    //~midi = MIDIOut(~midiport);    
  };
  
  //if the global synthFunc has changed, reload it for existing automata
  ~refreshCallback = {
    ~a.do({|a|a.synthFunc = ~synthFunc });
  };
  //deactivates the most recently x number of automata
  ~removeNewest = {|x|
    x.do({(~a.size>1).if({~a.pop;})});
    ~n = ~a.size;
  }; 


  //deactivates the oldest x number of automata 
  ~removeOldest = {|x|
    x.do({(~a.size > 1).if({~a.removeAt(~a.size-1);})});
    ~n = ~a.size;
  };

  ~removeNth ={|x|
    (~a.size > 1).if ({~a.removeAt(x)});
    ~n = ~a.size;
  };
  
  //some functions about the global state of the Otomata
  //dSum is the sum of all direction (d) values of each automaton
  ~dSum = {
    ~a.collect({|i|i.d.sum}).sum;
  };
  
  //xySum is the sum of all xy coordinates of each automaton
  ~xySum = {
    ~a.collect({|i|i.xy.sum}).sum;
  };
  
  ~xSum = {
    ~a.collect({|i|i.xy[0]}).sum;
  };

  ~ySum = {
    ~a.collect({|i|i.xy[1]}).sum;
  };

  ~add = { |xy|
    ~a.add( Automaton.new(xy, ~arduinome,~synthname,~synthFunc) );
    ~n = ~a.size;
  };
  
  ~tick = {
    ~gridsize.do{|i| ~coltab[i]=List.new; }; // clear collision table
    ~arduinome.clear;
    ~a.do{|el, elnum| 
        var i;
        i = el.tick; // tick each automaton  
        ~coltab[i].add(elnum); // add automaton number to collision table
      };
      
    // check collision table
    ~gridsize.do {|i|
      (~coltab[i].size > 1).if({
          ~coltab[i].do({|elnum| ~a[elnum].collision; });
        },{});
      };
    ~age = ~age+1;
  }
});
