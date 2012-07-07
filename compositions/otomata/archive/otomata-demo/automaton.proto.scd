//add pattern matching to an automaton's stream
~automaton = ~otomata.clone({
  ~xy; // 2-d list indicating (x,y) grid position
  ~d=[0,1]; // 2-d list indicating direction of movement
  ~hit=false;
  ~note=0;
  ~on=false;
  //synthFunc is set when the Automaton is created (a callback function is passed from ~otomata). these can also be changed dynamically per automaton
  ~synthFunc = false;
  //how many ticks this Automaton has been running for
  ~age = 0;
  ~numCollisions=0;
  ~numHits=0;
  ~arduinome;
  ~patternBuffer=[];
  ~width=8; ~height=8; ~gridsize=64;
  
  
  ~create = {|xy, arduinome, width, height, synthFunc|
    ~width = width;
    ~height = height;
    ~gridsize = width * height;
    ~xy = xy;
    //~d should be settable
    // check boundary conditions
    // (in case point was initialized on a boundary)
    if (((~d[0]==1) && (~xy[0]==(~height -1))) ||
      ((~d[0]==(-1)) && (~xy[0]==0)) ||
      ((~d[1]==1) && (~xy[1]==(~width-1))) ||
           ((~d[1]==(-1)) && (~xy[1]==0)), 
           {~d = ~d*(-1);},{});
    ~arduinome = arduinome;
    ~arduinome.ledonoff(~xy,1); // turn on led

  };
  
  // do every clock cycle
  ~tick = {
    ~age = ~age+1;
    //arduinome.ledonoff(xy[0], xy[1], 0); // turn off led              
    ~xy = ~xy + ~d; // increment grid position
    ~arduinome.ledonoff(~xy,1); // turn on led
             
    // check boundary conditions
    ~hit = false;
    if ( ((~d[0]==1) && (~xy[0]==(~height-1))), {~hit=true; ~note=~xy[1];}, {} );
    if (  ((~d[0]==(-1)) && (~xy[0]==0)), {~hit=true; ~note=~xy[1];}, {} );
    if (  ((~d[1]==1) && (~xy[1]==(~width-1))), {~hit=true; ~note=~xy[0];}, {} );
    if ( ((~d[1]==(-1)) && (~xy[1]==0)), {~hit=true; ~note=~xy[0];}, {} );
                          
    (~hit==true).if ({
        ~numHits = ~numHits+1;
        ~d = ~d*(-1); // change direction
        // midi on
        //midi.noteOn(0, scale.wrapAt(note) + offset, 100);
        ~on = true;
        ~synthFunc.(~note);
      },   
      { 
        // midi off
        (~on==true).if({
        //  midi.noteOff(0, scale.wrapAt(note) + offset, 0);
          ~on = false;
          //"note off".postln;
        },{});
      });
    (~xy[1]*~height + ~xy[0]) // return grid position
  };
  
  ~collision = {    
    var tmp;
    ~numCollisions = ~numCollisions+1;
    tmp = ~d[0];
    ~d[0] = ~d[1];
    ~d[1] = tmp;    
    // check boundary conditions
    // (in case collision occured on a boundary)
    (
      ((~d[0]==1).and(~xy[0]==(~height-1))).or
      ((~d[0]==(-1)).and(~xy[0]==0)).or
      ((~d[1]==1).and(~xy[1]==(~width-1))).or
      ((~d[1]==(-1)).and(~xy[1]==0))).if 
           ({~d = ~d*(-1);},{});
           
    // error checking
    if ( ((~d[0]!=0) && (~d[1]!=0)), {"off the charts!".postln;}, {} );
  };
});
