//otomata algorithm by Batuhan Bozkurt
//http://www.earslap.com/projectslab/otomata

//this implementation based on code by Corey Kereliuk
//http://www.music.mcgill.ca/~corey/?p=201

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
  ~aut;//the automaton
  //# of ticks this Otomata has been alive
  ~age=0;
  //run the "create" function to initialize a new ~otomata
  ~create = {|width=8, height=8, oscport=8080, midiport=0, aut|
    ~width = width;
    ~height = height;
    ~gridsize = width*height;
    ~oscport = oscport;
    ~midiport = midiport;
    ~a = List.new;      
    ~aut = aut;
    ~coltab = Array.newClear(~gridsize);
    // set up osc
    ~prefix = "oto";
    ~arduinome = Arduinome.new(~prefix, ~oscport);
    // register osc responder for button presses
    //note inEnvir below
    //OSCresponder normally operates at the top-level environment.  inEnvir is necessary to get it to recognize the "local" context of an instance of ~otomata
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

  //deactivates the most recently-created x number of automata
  ~removeNewest = {|x|
    x.do({(~a.size>1).if({~a.pop;})});
    ~n = ~a.size;
  }; 


  //deactivates the oldest x number of automata 
  ~removeOldest = {|x|
    x.do({(~a.size > 1).if({~a.removeAt(~a.size-1);})});
    ~n = ~a.size;
  };
  //removes automata at list position x
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

  //add a new automata.  dynamcially update the value of n
  ~add = { |xy|
    var aut= ~aut.copy;
    aut.create(xy, ~arduinome, ~width, ~height, ~synthFunc);
    ~a.add(aut);

    ~n = ~a.size;
  };
  
  //advance all automata 1 step
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
    //~age is the #of ticks that the whole system has been running
    ~age = ~age+1;
  }
},parentKeys:#[dSum,xySum,xSum,ySum,a,n]);
