/*
otomata algorithm by Batuhan Bozkurt
http://www.earslap.com/projectslab/otomata

this implementation based on code by Corey Kereliuk
http://www.music.mcgill.ca/~corey/?p=201

*/

//start with a utility funciton, and define some synthdefs 
//this is a utility function to build SynthDefs with a percussive envelope - synths will remove themselves automatically
~synthFactoryPerc = {|name, func, pan =({[-1,1]}),l=(Server.default)|    
  SynthDef(name, {|gate =0, atk=18, rel=10,sus=1,amp=1,bus=0|    
    var out;    
    out = SynthDef.wrap(func);      
    Out.ar(bus,Mix.ar(Pan2.ar(out * amp,pan.value)) * EnvGen.ar(Env.perc(atk, rel, 1, sus),gate, doneAction:2))  }).send(l) };


//square-wave like synth, made up of odd harmonics
~synthFactoryPerc.("oto-sine",{|freq=128,harm=#[1,3,5,7,9,11],phase=#[1,2,3,4,5,6,7,8,9,10,11,12], amp = 1, gate=0|
  var src, env, pitches,b=SinOsc;
  pitches = harm * freq *.x [1,1] * phase;
  src = b.ar(pitches,0,(amp * 1/((pitches/freq)+32)));
},{[-1,1]/(2..7)},Server.default);


//a saw wave with sweep lowpass filter
~synthFactoryPerc.("oto-saw",{|freq=128, amp = 1,d=4|
  RLPF.ar(Saw.ar(PinkNoise.ar([freq.sqrt/2,freq.sqrt/2],freq) ,amp/(freq+2).log2), freq * XLine.ar(d,2,1/freq.log2),0.5,1);
},{[-1,1]},Server.default);


//percussive sounds made via noisy phase modulation
~synthFactoryPerc.("oto-phase",{|freq=512,w=0.5,a=0.1,b=4|
  SinOsc.ar(freq*[1,1]*XLine.ar(b,1,a),SinOsc.ar(PinkNoise.ar(freq,1), 0, w*pi*XLine.ar(b,1,a)),16/((freq/freq.log2)+16));
},{[-1,1]},Server.default);

//define some callback functions for our automata
//these functions are called from within the context of the ~otomata proto, so they reference "instance" variables with ~

//note references to ~dSum, ~age, and ~xySum - these are values for the global state of the otomata, so sonic characteristics of each automaton will change and the # and configuation of running automata changes
/*each synthFunc uses its own musical scale, in just intonatioin, defined in Hz as a fundamental pitch * some set of ratios.
Equal-temperament scales could be played using an array of integers and midicps: 
var freq = [0,2,4,5,7,9,11,12].wrapAt(note).midicps
*/
/*
why do all of these functions return the unchanged value of "note"? So that you can use the function composition operator <> to chain multiple synthFunc's together if you want more than one event to happen per automaton. (if you do f1<>f2 then a single function is created in which f2 is evaluated and its return is passed to f1)
*/
~synthFunc1={|note=1|
  var s = Synth("oto-sine"), h=[1,3,5,7,9,11];  
  s.setn(\harm,h);
  s.setn(\phase,Array.fill(12, {|i|(1024+[i,0].wrapAt(i))/1024 })); 
  s.set(\freq, 96 * [1/2,3/4,2,9/4,5/2,3,27/8,15/4].permute(~age).wrapAt(note));
  s.set(\atk, 0.01);
  s.set(\rel,1);
  s.set(\gate,1);
  s.set(\amp,1/(~a.size+2).log2);
  note;
};

~synthFunc2 ={|note=1|
  //a different take on the oto-sine instrument.  this adds more high prime-number partials to the mix
  var s = Synth("oto-sine"), h=[1,3,11,17,29,47], p = 96, octave=1;   octave = 2**((~dSum.()/2).ceil.abs%6);
  s.setn(\harm,h);
  s.setn(\phase,Array.fill(12, {|i|(4096+[i,0].wrapAt(i))/4096 }).permute(~age)); 
  //note use of .permute here - every 256 ticks of the otomata routine, the ordering of the pitches along the edges changes
  s.set(\freq, p * octave * [5/8,15/16,1,9/8,5/4,45/32,3/2,5/3].permute((~age/256).ceil.asInt).wrapAt(note));
  s.set(\atk, 1/~xySum.()**2);
  s.set(\rel,~xySum.log10);
  s.set(\sus,-1 * ~dSum.().abs);
  s.set(\gate,1);
  s.set(\amp,1/(~a.size+2).log2);
  note;
};

~synthFunc3 ={|note=1|
  var s = Synth("oto-saw"), p = 192 * 5/6, octave=1;   
  s.set(\freq, p * octave * [3/5,8/9,1,9/8,6/5,4/3,3/2,8/5].wrapAt(note));
  s.set(\atk, 1/~xySum.()**2);
  s.set(\rel,(1/(~xySum+10).log10)+0.25);
  s.set(\sus,-1 * ~dSum.().abs);
  s.set(\d,(2*~dSum.().abs)+1);
  s.set(\gate,1);
  s.set(\amp,2/(~a.size+2).log2);
  note;
};

~synthFunc4 = {|note=1|
    var s=Synth("oto-phase"),p=192,octave=1, freq;
    freq = p * octave * [5/8,15/16,1,9/8,5/4,45/32,3/2,5/3].wrapAt(note);
    s.set(\freq,freq * (2**~dSum.().clip(-4,4)));
    s.set(\amp,(1.5/(~a.size+2).log2));
    s.set(\atk,0.01/(1+~xySum.().log2));
    s.set(\rel, (1/~xySum.().factors.size));
    s.set(\w,(2**(~dSum.().clip(-6,6)* (-1))));
    s.set(\b,2**(~dSum.()));
    s.set(\sus,-1 * ~a.size);
    s.set(\gate,1);
    s.set(\a,0.1/~xySum.().abs);
    note;
  };



(
~init = {
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
);

(
//a routine to cycle through different instrument voices running at the same time on different automatas
~seq = Routine {
  "Swap in Instrument 1: computer beeps".postln;
  ~o.a.collect({|e,i|
    e.synthFunc = ~synthFunc1;
    64.wait;
  });
  
  "Instrument 2: bells".postln;
  ~o.a.collect({|e,i|
    e.synthFunc = ~synthFunc2;
    64.wait;
  });
  
  "Instrument 3: sawtooth synth".postln;
  ~o.a.collect({|e,i|
    e.synthFunc = ~synthFunc3;
    64.wait;
  });
  
  "Instrument 4: percussive noises".postln;
  ~o.a.collect({|e,i|
    e.synthFunc = ~synthFunc4;
    64.wait;
  });

  128.wait;
  "Assign each instrument to 3 automata".postln;
  //note use of <> operator to combine functions
  ~o.a.at(0).synthFunc = ~synthFunc4<>~synthFunc1;
  ~o.a.at(2).synthFunc = ~synthFunc4<>~synthFunc2;
  ~o.a.at(4).synthFunc = ~synthFunc4;
  ~o.a.at(6).synthFunc = ~synthFunc1;
  ~o.a.at(8).synthFunc = ~synthFunc1;
  ~o.a.at(10).synthFunc = ~synthFunc1<>~synthFunc4;
  ~o.a.at(1).synthFunc = ~synthFunc2;
  ~o.a.at(3).synthFunc = ~synthFunc2;
  ~o.a.at(5).synthFunc = ~synthFunc2<>~synthFunc3;
  ~o.a.at(7).synthFunc = ~synthFunc3;
  ~o.a.at(9).synthFunc = ~synthFunc3;
  ~o.a.at(11).synthFunc = ~synthFunc3;
  256.wait;
  //gradually remove automata,leave the last 2
  "begin fading out".postln;
  (~o.n-2).do({
    ~o.removeOldest(1);
    64.wait;
  });
  "last 2 remain".postln;
  128.wait;
};
);
//finally, down here, we start things off
//~init returns the routine ~r, and also initializes otomata ~o and tempoclock ~t;
~r= ~init.();
//switch on some automata to start
~starting = [(0..7)+++[7],[[4,5],[3,5]],[[4,0],[3,0]]].flatten;
~starting.do({|i| ~o.add(i)});
//refreshCallback will switch out the synthFunc for all running automata with whatever ~o.synthFunc is
//in this case, we'll have each automaton start off playing a combined sawtooth + percussive instrument.
~o.synthFunc = ~synthFunc3<>~synthFunc4;
~o.synthFunc = {|x|~dSum.postcs;currentEnvironment.parent.dump};
~o.refreshCallback;
~o.a[0].synthFunc(4);
//start the sequencer
~r.play(~t);
//the instrument-switching sequence
~seq.play(~t);

//stop the sequence and clear the board
~r.stop;
~o.arduinome.clear;

//todo - save snapshot to file
~o.add([3,3])

Environment.push(topEnvironment)
Environment.pop
