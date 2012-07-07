Environment[ ('offset' -> 0), ('setup' -> nil), ('echoPhase' -> Synth.new), ('ard' -> Arduinome.new), ('fx' -> Synth.new), 
  ('init' -> {|env|
  Server.default = Server.internal;
  ~t = TempoClock(9);
  // set up routine
  ~o = ~otomata.copy();
  ~o.create();
	~o.synthFunc = ~synthFunc;
	~o.clear; // clear lights
  Routine {|inval|	
    //set up our automaton
    inf.do({|i|
    	  ~o.synthFunc = ~e.synthFunc;  
    		~o.tick(); // advance automatons 1 position
        1.wait;
    })
  }
}), ('y' -> 1001), ('wah' -> Synth.new), ('allvals' -> 353762), ('mylib' -> SynthDescLib.new), 
  ('g' -> Group.new), ('g1' -> Group.new), ('e' -> Proto(Environment[ ('offset' -> 0), ('echoPhase' -> Synth.new), ('g3' -> Group.new), ('wah' -> Synth.new), ('allvals' -> 0), 
  ('echoPulse' -> Synth.new), ('g1' -> Group.new), ('pitch' -> 132.0), ('g2' -> Group.new), ('all' -> Synth.new), 
  ('wah2' -> Synth.new), ('echo' -> Synth.new), ('scales' -> [ [ 1, 1.5, 2.25, 3.375, 5.0625, 7.59375, 5.3333333333333, 2 ], [ 0.5, 0.75, 2, 2.25, 2.5, 3, 3.375, 3.75 ], [ 1, 1.5, 2, 2.25, 2.5, 2.6666666666667, 3, 3.375 ], [ 1, 1.5, 2, 2.5, 3, 3.75, 4.5, 5 ] ]), ('tempo' -> 0.5) ])), ('removeOldest' -> nil), ('fxPulse' -> Synth.new), 
  ('z' -> 1002), ('restoreFull' -> nil), ('refresh' -> {|f|
  ~archive.(f,~restore.(f));
}), ('fx2' -> Synth.new), ('all' -> Synth.new), 
  ('wah2' -> Synth.new), ('oe' -> nil), ('echo' -> Synth.new), ('synthFunc' -> {|note, inval|
  var i;
   i=inval;
   
   ~scales = [1,9/8,8/7,4/3,3/2,7/4,2,9/4] *.t [2,7/4,9/4,18/7];
   ~scales[0].wrapAt(note).postln;
   //note = ~scales[0].wrapAt(note) * ~pitch;
  //~askAgain.(note, i);//refresh synthFunc for instance;
}), ('synthFactoryPerc' -> {|name, func, pan =({[-1,1]}),l=(Server.internal)|  	SynthDef(name, {|gate =0, atk=18, rel=10,sus=1,amp=1,bus=0|  	var out;  	out = SynthDef.wrap(func);  		Out.ar(bus,Mix.ar(Pan2.ar(out * amp,pan.value)) * EnvGen.ar(Env.perc(atk, rel, 1, sus),gate, doneAction:2))  }).send(l)  }), 
  ('scales' -> [ [ 2, 1.75, 2.25, 2.5714285714286 ], [ 2.25, 1.96875, 2.53125, 2.8928571428571 ], [ 2.2857142857143, 2.0, 2.5714285714286, 2.9387755102041 ], [ 2.6666666666667, 2.3333333333333, 3.0, 3.4285714285714 ], [ 3.0, 2.625, 3.375, 3.8571428571429 ], [ 3.5, 3.0625, 3.9375, 4.5 ], [ 4, 3.5, 4.5, 5.1428571428571 ], [ 4.5, 3.9375, 5.0625, 5.7857142857143 ] ]), ('playSine' -> {|note, i|
  [1,3/2].collect({|f,j|
    var s  = Synth("oto-sine", nil,~g1);
    ~allvals = ~allvals + 1;
    h = [1,(0..20).nthPrime.permute((i+(2**j)).asInt)[0..4]].flat;
    h = [1,3,5,7,9,11].flat;

    s.setn(\harm,h);
    ~wah.set(\rate,9/4);
    ~wah.set(\ffreq,128 * (2**~o.a.collect({|i|i.d.sum;}).sum.abs.clip(0,8)));

//    ~echo.set(\length,~o.a.collect({|i|i.d.sum;}).sum.abs/15);
    s.set(\bus,6);
    s.setn(\phase,Array.fill(12, {|i|(1024+[i,0].wrapAt(i))/1024 })); 
    s.set(\freq, note);
    s.set(\atk, 1/~o.a.collect({|i|i.xy.sum}).sum);
    s.set(\sus,-2-~o.a.collect({|i|i.d.sum}).sum.abs);
    s.set(\rel, 3/4* ~tempo);
    s.set(\gate,1); 
    s.set(\amp, (1/(~o.a.size.log2+2)));
  });
}), ('path' -> "/Users/thomasgillis/dev/supercollider/sc/scd/compositions/otomata/archive/"), ('playPulse' -> {|note,inval|
  var p;
  p = Synth("oto-pulse",nil, ~g2);
  p.set(\amp,(1/(~o.a.size.log+3)));
  p.set(\atk, note.log2/~o.a.collect({|i|i.xy.sum}).sum.log);
  p.set(\freq,(note) * (2**~o.a.collect({|i|i.d.sum;}).sum.clip(-2,2)));
  p.set(\w, (1/((~o.a.collect({|i|i.xy.sum}).sum+10).log10)).clip(0,1));
  p.set(\a,1.25/12);
  p.set(\gate,1);
  p.set(\bus,4);
  p.set(\rel,~o.a.collect({|i|i.xy.sum}).sum.log2 *~tempo*2);
  Routine {
    (~o.a.collect({|i|i.xy.sum}).sum.log2  *~tempo*2 ).wait;
    p.set(\gate,0);
  }.play;
}), ('removeNewest' -> {|n|n.do({~o.a.pop;});}), 
  ('g3' -> Group.new), ('echoPulse' -> Synth.new), ('playBass' -> {|note,i|
  var p;
  p= Synth("oto-bass",nil, ~g3);
  p.set(\freq,note*(2**~o.a.collect({|i|i.d.sum;}).sum.clip(-4,4)));
  ~echoPhase.set(\length,1/(note*(2**~o.a.collect({|i|i.d.sum;}).sum.clip(-2,4))));
  ~echoPulse.set(\length,~o.a.collect({|i|i.d.sum;}).sum.abs/36);
  p.set(\amp,(3/(~o.a.size.log2+2)));
  p.set(\atk,0.01/(1+~o.a.collect({|i|i.xy.sum}).sum.log2));
  p.set(\rel, (4/~o.a.collect({|i|i.xy.sum}).sum.log2) * ~tempo );
  p.set(\w,(2**(~o.a.collect({|i|i.d.sum;}).sum.clip(-6,6)* (-1))));
  p.set(\b,2**(~o.a.collect({|i|i.d.sum;}).sum));
  p.set(\k,[4.5,9].wrapAt(~o.a.collect({|i|i.xy.sum}).sum.factors.size));
//  ~wah2.set(\rate,[4.5,9].wrapAt(~o.a.collect({|i|i.xy.sum}).sum.factors.size)/2.5);
  p.set(\sus,(-1) * (~o.a.collect({|i|i.d.sum;}).sum.abs));
  p.set(\bus,2);
  p.set(\gate,1);
  p.set(\a,0.1/~o.a.collect({|i|i.xy.sum;}).sum.abs);
}), ('t' -> TempoClock.new), ('so' -> {|i|(~o.a.collect({|i|i.xy.sum}).sum*0) + (~allvals /(~o.a.size**3))}), 
  ('pitch' -> 132.0), ('om' -> nil), ('archive' -> {|f,completeAction=({"done".postln;})|
var path,a;
path = ~path++f.asString;
//create the temp dir
Routine {
Pipe.new("mkdir "++path,"w");
0.1.wait;

Pipe.new("chmod -R 777 "++path,"w");
0.1.wait;

a=File(path++"/_keys.scd","w");
a.write(currentEnvironment.keys.asCompileString.asString);
a.close;
0.1.wait;
{a=File(path++"/_currentEnvironment.scd","w");
a.write(currentEnvironment.asCompileString.asString);
a.close;}.defer;
0.1.wait;

currentEnvironment.keys.do({|x|
  (currentEnvironment.at(x).isFunction).if({
    currentEnvironment.at(x).writeArchive(path++"/"++x.asString++".scd");
    0.1.wait;
  })
});
completeAction.();
}.play;
}), ('g2' -> Group.new), ('restore' -> {|f|
  var path = ~path ++f, keys,file;
  keys = Object.readArchive(path++"/_keys.scd");
  keys.postln;
  keys.asArray.do({|key|
    file = path++"/"++key++".scd";
    (File.exists(file)).if({currentEnvironment.put(key.asSymbol,Object.readArchive(file));
    });
  })
}), 
  ('askAgain' -> {|note, i|
  //real synth Func goes here
  ~playSine.(note,i);
//  ~playPhase.(note,i);
  ~playBass.(note,i);
  ((~allvals %(~o.a.size**2))==0).if({
    //~playPulse.(note,i);

  });
}), ('removeRecent' -> nil), ('r' -> Routine({|inval|	
    //set up our automaton
    inf.do({|i|
    	  ~o.synthFunc = ~synthFunc;  
    		~o.tick(); // advance automatons 1 position
        1.wait;
    })
  })), ('playPhase' -> {|note,i|
  var p;
  p= Synth("oto-phase",nil, ~g3);
  p.set(\freq,note*(2**~o.a.collect({|i|i.d.sum;}).sum.clip(-4,4)));
  p.set(\amp,(3/(~o.a.size.log2+2)));
  p.set(\atk,0.01/(1+~o.a.collect({|i|i.xy.sum}).sum.log2));
  p.set(\rel, (1/~o.a.collect({|i|i.xy.sum}).sum.factors.size) * ~tempo );
  p.set(\w,(2**(~o.a.collect({|i|i.d.sum;}).sum.clip(-6,6)* (-1))));
  p.set(\b,2**(~o.a.collect({|i|i.d.sum;}).sum));
  p.set(\sus,-1 * ~o.a.size);

  p.set(\bus,2);
  p.set(\gate,1);
  p.set(\a,0.1/~o.a.collect({|i|i.xy.sum;}).sum.abs);
}), ('otomata' -> Proto(Environment[ ('age' -> 0), ('synthname' -> "oto-sine"), ('height' -> 8), ('n' -> 0), ('gridsize' -> 64), 
  ('width' -> 8) ])), 
  ('norm' -> Synth.new), ('synthFactory' -> {|name, func,pan =({[-1,1]}),l=(Server.internal)|  	SynthDef(name, {|gate =0, atk=18, rel=10,amp=1,bus=0|  	var out;  	out = SynthDef.wrap(func);  		Out.ar(bus,Mix.ar(Pan2.ar(out * amp,pan.value)) * EnvGen.ar(Env.asr(atk, 1, rel, 'linear'),gate, doneAction:2))  	}).send(l)  }), ('run' -> {
  Server.default.freeAll;
  ~initRoutine.();
  ~clock.play(~r,0);
}), ('fxPhase' -> Synth.new), ('makeEffect' -> nil), 
  ('defineSynths' -> {
  ~synthFactoryPerc.("oto-sine",{|freq=128,harm=#[1,3,5,7,9,11],phase=#[1,2,3,4,5,6,7,8,9,10,11,12], amp = 1, gate=0|
    var src, env, pitches,b=SinOsc;
    pitches = harm * freq * [1,1] * phase;
    src = b.ar(pitches,0,(amp * 1/((pitches/freq)+32)));
  },{[-1,1]/(2..7)},Server.internal);

  ~synthFactory.("oto-pulse",{|freq=512,w=0.5,a=0.1|
    Pulse.ar(SinOsc.kr(a,0,[w,0],1) *.x  SinOsc.kr(1/a,0,[0,w],1) *.x freq *.x [1,81/80] ,w*XLine.ar(1/128,1,1/a),192/(freq+256))},[-1,1],Server.internal);



  ~synthFactoryPerc.("oto-bass",{|freq=512,w=0.5,a=0.1,b=1,k=1|
    var src;
    freq = freq /[8,2,2,8];
     src = SinOsc.ar(WhiteNoise.ar(2**(freq/128).floor,freq),Pulse.ar(freq, 1/2   * XLine.kr(0,1,1/k).cos * SinOsc.kr(k,0,1,1),freq),(SinOsc.ar(k,0,2,2)**3)/(freq+64));
    src;
    },[-1,1],Server.internal);

  ~synthFactoryPerc.("oto-phase",{|freq=512,w=0.5,a=0.1,b=4|
    SinOsc.ar(freq*[1,1]*XLine.ar(b,1,a),SinOsc.ar(freq, 0, w*pi*XLine.ar(b,1,a)),4/(freq.log2+4));
  },{[-1,1]},Server.internal);



  // now make a wah
  ~makeEffect.value(\wah, {|in, env, rate = 1, ffreq = 1200, depth = 0.8, rq = 0.1|
  	// in and env come from the wrapper. The rest are controls
   	var lfo;
  	lfo =SinOsc.kr(rate, 0, ffreq*depth,ffreq);
  	RLPF.ar(in, lfo, rq, 10) * 0.15; },
  	[0.1, 0.1, 0.1, 0.1],  // lags for rate ffreq, depth and rq
  	2);

  ~makeEffect.value(\echo, {|in, env, maxlength=1, length=0.125, decay=3|
  	AllpassC.ar(in,maxlength,length,decay);
  },
  	[0.1],  
  2);

  SynthDef("all", {|in_bus=2,master=1|
  	var in = In.ar(in_bus, 16);
  	Out.ar(0, Mix.ar(Pan2.ar(in,[-1,1])*master));
  }).send(Server.internal);

  
}), ('tempo' -> 0.5), ('pulser' -> nil), ('o' -> Proto(Environment[ ('a' -> List[ Automaton.new, Automaton.new, Automaton.new ]), ('oscport' -> 8080), ('age' -> 157), ('synthname' -> "oto-sine"), ('height' -> 8), 
  ('n' -> 3), ('gridsize' -> 64), ('coltab' -> [ List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[ 2 ], List[  ], List[ 0 ], List[  ], List[  ], List[  ], List[  ], List[  ], List[  ], List[ 1 ], List[  ], List[  ], List[  ] ]), ('synthFunc' -> {|note, inval|
  var i;
   i=inval;
   
   ~scales = [1,9/8,8/7,4/3,3/2,7/4,2,9/4] *.t [2,7/4,9/4,18/7];
   ~scales[0].wrapAt(note).postln;
   //note = ~scales[0].wrapAt(note) * ~pitch;
  //~askAgain.(note, i);//refresh synthFunc for instance;
}), ('scales' -> [ [ 2, 1.75, 2.25, 2.5714285714286 ], [ 2.25, 1.96875, 2.53125, 2.8928571428571 ], [ 2.2857142857143, 2.0, 2.5714285714286, 2.9387755102041 ], [ 2.6666666666667, 2.3333333333333, 3.0, 3.4285714285714 ], [ 3.0, 2.625, 3.375, 3.8571428571429 ], [ 3.5, 3.0625, 3.9375, 4.5 ], [ 4, 3.5, 4.5, 5.1428571428571 ], [ 4.5, 3.9375, 5.0625, 5.7857142857143 ] ]), 
  ('width' -> 8), ('osc' -> OSCresponder.new), ('prefix' -> "oto"), ('arduinome' -> Arduinome.new), ('midiport' -> 0) ])) ]