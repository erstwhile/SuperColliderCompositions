~synthFactory = {|name, func,pan =({[-1,1]}),l=(Server.internal)|  	SynthDef(name, {|gate =0, atk=18, rel=10,amp=1,bus=0|  	var out;  	out = SynthDef.wrap(func);  		Out.ar(bus,Mix.ar(Pan2.ar(out * amp,pan.value)) * EnvGen.ar(Env.asr(atk, 1, rel, 'linear'),gate, doneAction:2))  	}).send(l)  };


~synthFactoryPerc = {|name, func, pan =({[-1,1]}),l=(Server.internal)|  	SynthDef(name, {|gate =0, atk=18, rel=10,sus=1,amp=1,bus=0|  	var out;  	out = SynthDef.wrap(func);  		Out.ar(bus,Mix.ar(Pan2.ar(out * amp,pan.value)) * EnvGen.ar(Env.perc(atk, rel, 1, sus),gate, doneAction:2))  }).send(l)  }; 