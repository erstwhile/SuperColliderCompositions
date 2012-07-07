~initRoutine ={
  z = Server.default;

  ~clock = TempoClock.new(1/2,0,0,16384);
  ~clock.tempo_(2);
  ~tempo = 5/8;
  z.freeAll;
  ~i = 0;


  ~r = Routine {
  4.do({|n|  
    var a;
    a = (2**(n +12)).asInt;
    ~i =a;
    (2**13).asInt.do({|x|
        var i=~i;
        ~play.value(a+i.asInt,x.asInt);
        ~i = ~incrementFunc.value(i.asInt,a,n);
        {~iX.string = x;}.defer;
      });
    });
  240.wait;
  z.freeAll;
  };
  OSCresponderNode.removeAddr(nil);
  ~n = OSCresponderNode(nil,"/n_end",{|time,responder,msg|~running.removeAt(msg[1]);}).add;
  //set up a responder node when new code is pushed
  ~mm = Proto({~isRunning = false});

  ~running = Dictionary.new;
  ~unique = {|a|var t = Array.fill(a.size);
  a.collect({|i,j|(t.includes(i)).if({t.put(j,nil)}, {t.put(j,a[j])})}).reject({|i|i==nil});
  t.reject({|i|i==nil});
  };
};


z.scope;
