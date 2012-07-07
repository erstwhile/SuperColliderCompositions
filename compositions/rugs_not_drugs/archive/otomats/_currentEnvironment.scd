Environment[ ('offset' -> 0), ('echoPhase' -> Synth.new), ('fx' -> Synth.new), ('init' -> {
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
}), ('y' -> 1001), 
  ('wah' -> Synth.new), ('allvals' -> 253454), ('mylib' -> SynthDescLib.new), ('g' -> Group.new), ('g1' -> Group.new), 
  ('removeOldest' -> {|n|n.do({~o.a.removeAt(~o.a.size-1);})}), ('fxPulse' -> Synth.new), ('z' -> 1002), ('restoreFull' -> {|f|
  var path = ~path ++f, keys,file;
  Object.readArchive(path++"/_currentEnvironment.scd");
}), ('refresh' -> {|f|
  ~archive.(f,~restore.(f));
}), 
  ('fx2' -> Synth.new), ('all' -> Synth.new), ('oe' -> {|i|[0,2,3,7,5,0].permute((~allvals/(2048)).floor.asInt).wrapAt((~allvals / 512));0}), ('echo' -> Synth.new), ('synthFunc' -> {|note, inval|
  var i;
   i=inval;
   note = ~scales.wrapAt(~so.(i)).wrapAt(note) * ~pitch;
  ~askAgain.(note, i);//refresh synthFunc for instance;
}), 
  ('synthFactoryPerc' -> {|name, func, pan =({[-1,1]}),l=(Server.internal)|  	SynthDef(name, {|gate =0, atk=18, rel=10,sus=1,amp=1,bus=0|  	var out;  	out = SynthDef.wrap(func);  		Out.ar(bus,Mix.ar(Pan2.ar(out * amp,pan.value)) * EnvGen.ar(Env.perc(atk, rel, 1, sus),gate, doneAction:2))  }).send(l)  }), ('scales' -> [ [ 1.3061224489796, 1.5, 1.7142857142857, 1.9591836734694, 2.0, 2.6122448979592, 3.0, 3.4285714285714 ], [ 1.5, 1.72265625, 1.96875, 2.25, 2.296875, 3.0, 3.4453125, 3.9375 ], [ 1.7142857142857, 1.96875, 2.25, 2.5714285714286, 2.625, 3.4285714285714, 3.9375, 4.5 ], [ 1.9591836734694, 2.25, 2.5714285714286, 2.9387755102041, 3.0, 3.9183673469388, 4.5, 5.1428571428571 ], [ 2.0, 2.296875, 2.625, 3.0, 3.0625, 4.0, 4.59375, 5.25 ], [ 2.6122448979592, 3.0, 3.4285714285714, 3.9183673469388, 4.0, 5.2244897959184, 6.0, 6.8571428571429 ], [ 3.0, 3.4453125, 3.9375, 4.5, 4.59375, 6.0, 6.890625, 7.875 ], [ 3.4285714285714, 3.9375, 4.5, 5.1428571428571, 5.25, 6.8571428571429, 7.875, 9 ] ]), ('playSine' -> {|note, i|
  var s  = Synth("oto-sine", nil,~g1);
  ~allvals = ~allvals + 1;
  h = [[1,[({|i|i.nthPrime}!16).permute(~o.a.collect({|i|i.xy.sum;}).sum+(~allvals/~o.a.size**2).asInt)[0..4]]].flat, [1,(~o.a.collect({|i|i.xy.sum})[0..4] * [1,1,1,1,1]).clip(1,32)].flat].wrapAt((~o.a.collect({|i|i.d.sum;}).sum/2));
  s.setn(\harm,h);
  ~wah.set(\rate,2/(~o.a.size**2).nextPowerOfTwo);
  s.set(\bus,6);
  s.setn(\phase,Array.fill(12, {|i|(1024+i)/1024 })); 
  s.set(\freq, note);
  s.set(\atk, 1/~o.a.collect({|i|i.xy.sum}).sum);
  s.set(\sus,-2-~o.a.collect({|i|i.d.sum}).sum.abs);
  s.set(\rel, 3/4* ~tempo);
  s.set(\gate,1); 
  s.set(\amp, (1/(~o.a.size.log2+2)));
}), ('path' -> "/Users/thomasgillis/dev/supercollider/sc/scd/compositions/rugs_not_drugs/archive/"), ('playPulse' -> {|note,inval|
  var p;
  p = Synth("oto-pulse",nil, ~g2);
  p.set(\amp,(1/(~o.a.size.log+3)));
  p.set(\atk, 1/~o.a.collect({|i|i.xy.sum}).sum.log);
  p.set(\freq,(note));
  p.set(\w, (1/((~o.a.collect({|i|i.xy.sum}).sum+10).log10)).clip(0,1));
  p.set(\gate,1);
  p.set(\bus,4);
  p.set(\rel,~o.a.collect({|i|i.xy.sum}).sum.log2 *~tempo*2);
  Routine {
    (~o.a.collect({|i|i.xy.sum}).sum.log2  *~tempo).wait;
    p.set(\gate,0);
  }.play;
}), 
  ('removeNewest' -> {|n|n.do({~o.a.pop;});}), ('g3' -> Group.new), ('echoPulse' -> Synth.new), ('t' -> TempoClock.new), ('so' -> {|i|(~o.a.collect({|i|i.xy.sum}).sum.log2) + (~allvals /(~o.a.size**3))}), 
  ('pitch' -> 132.0), ('om' -> {|i|[1,9/4,3/2].wrapAt(~o.a.collect({|i|i.d.sum}).sum);1}), ('archive' -> {|f,completeAction=({"done".postln;})|
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
  ~playPhase.(note,i);

  ((~allvals %(~o.a.size**2))==0).if({
    ~playPulse.(note,i);
  });
}), ('removeRecent' -> {|n|n.do({~o.a.pop;});}), ('playPhase' -> {|note,i|
  var p;
  p= Synth("oto-phase",nil, ~g3);
  p.set(\freq,note*(2**~o.a.collect({|i|i.d.sum;}).sum.clip(-4,6)));
  p.set(\amp,(3/(~o.a.size.log2+2)));
  p.set(\atk,0.01/(1+~o.a.collect({|i|i.xy.sum}).sum.log2));
  p.set(\rel, (1/~o.a.collect({|i|i.xy.sum}).sum.factors.size) * ~tempo );
  p.set(\w,(2**(~o.a.collect({|i|i.d.sum;}).sum.clip(-6,6)* (-1))));
  p.set(\b,2**(~o.a.collect({|i|i.d.sum;}).sum));
  p.set(\sus,-1 * ~o.a.size);

  p.set(\bus,2);
  p.set(\gate,1);
  p.set(\a,0.1/~o.a.collect({|i|i.xy.sum;}).sum.abs);
}), ('norm' -> Synth.new), ('synthFactory' -> {|name, func,pan =({[-1,1]}),l=(Server.internal)|  	SynthDef(name, {|gate =0, atk=18, rel=10,amp=1,bus=0|  	var out;  	out = SynthDef.wrap(func);  		Out.ar(bus,Mix.ar(Pan2.ar(out * amp,pan.value)) * EnvGen.ar(Env.asr(atk, 1, rel, 'linear'),gate, doneAction:2))  	}).send(l)  }), 
  ('run' -> {
  Server.default.freeAll;
  ~initRoutine.();
  ~clock.play(~r,0);
}), ('fxPhase' -> Synth.new), ('makeEffect' -> {| name, func, lags, numChannels = 2 |
	SynthDef(name, {| in_bus = 0, out_bus=0, gate = 1, wet = 1|
		var in, out, env, lfo;
		in = In.ar(in_bus, numChannels);
		env = Linen.kr(gate, 2, 1, 2, 2); // fade in the effect
		out = SynthDef.wrap(func, lags, [in, env]);
		XOut.ar(out_bus, wet * env, out);
	}, [0, 0, 0.1] ).send(Server.internal);
}), ('tempo' -> 0.5), ('pulser' -> {|note,inval|
  var p;
  p = Synth("oto-pulse");
  p.set(\amp,(0.6/(~o.a.size.log2+2)));
  p.set(\atk, 1/~o.a.collect({|i|i.xy.sum}).sum.log);
  p.set(\freq,(note));
  p.set(\w, (1/((~o.a.collect({|i|i.xy.sum}).sum+2).log2)).clip(0,1));
  p.set(\gate,1);
  p.set(\rel,~o.a.collect({|i|i.xy.sum}).sum.log2 *~tempo);
  Routine {
    (~o.a.collect({|i|i.xy.sum}).sum.log2).wait;
    p.set(\gate,0);
  }.play;
}), 
  ('o' -> Otomata.new) ]