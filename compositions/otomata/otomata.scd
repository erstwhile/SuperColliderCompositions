~synthFactoryPerc.("oto-sine",{|freq=128,harm=#[1,3,5,7,9,11],phase=#[1,2,3,4,5,6,7,8,9,10,11,12], amp = 1, gate=0|
  var src, env, pitches;
  pitches = harm * freq * [1,1] * phase;
  src = FSinOsc.ar(pitches,0,(amp * 1/(pitches/freq)));
  src = RLPF.ar(src, pitches * XLine.ar(1/16,1,pitches.log2/freq),0.3,1/4);  
},{[-1,1]/(2..7)},Server.internal);

~synthFactory.("oto-pulse",{|freq=512,w=0.5,a=0.1|
  Pulse.ar(SinOsc.kr(a,0,[w,0],1) *.x  SinOsc.kr(1/a,0,[0,w],1) *.x freq *.x [1,81/80] ,w*XLine.ar(1/128,1,1/a),192/(freq+256))},[-1,1],Server.internal);



~synthFactoryPerc.("oto-bass",{|freq=512,w=0.5,a=0.1,b=1,k=1|
  var src;
  freq = freq /[8,2,2,8];
   src = SinOsc.ar(WhiteNoise.ar(2**(freq/32).floor,freq),Pulse.ar(freq, 1/2   * XLine.kr(0,1,freq).tanh * SinOsc.kr(12/1.25,0,1,1),freq),1/2*(SinOsc.ar(k,0,2,2)**3)/(freq+64));
  src;
  },[-1,1],Server.internal);

~synthFactoryPerc.("oto-phase",{|freq=512,w=0.5,a=0.1,b=4|
  SinOsc.ar(PinkNoise.ar(freq.sqrt,freq)*[1,1]*XLine.ar(b,1,a),SinOsc.ar(PinkNoise.ar(freq,freq), 0, w*pi*XLine.ar(b,1,a)),4/(freq.log2+4));
},{[-1,1]},Server.internal);


~makeEffect = {| name, func, lags, numChannels = 2 |
	SynthDef(name, {| in_bus = 0, out_bus=0, gate = 1, wet = 1|
		var in, out, env, lfo;
		in = In.ar(in_bus, numChannels);
		env = Linen.kr(gate, 2, 1, 2, 2); // fade in the effect
		out = SynthDef.wrap(func, lags, [in, env]);
		XOut.ar(out_bus, wet * env, out);
	}, [0, 0, 0.1] ).send(Server.internal);
};

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

s.freeAll;
~g1 = Group.new(s);
~g2 = Group.new(s);
~g3 = Group.new(s);

~echoPulse = Synth( "echo", nil,~g2, \addToTail );
~echoPhase = Synth( "echo", nil, ~g3, \addToTail );
~wah = Synth( "wah", nil, ~g1, \addToTail );
~wah2 = Synth( "wah", nil, ~g1, \addToTail );
~echo = Synth( "echo", nil, ~g1, \addToTail );
~all = Synth("all",nil, Server.internal, \addToTail);
~all.set(\in_bus,20);
~all.set(\master,1/16);
s.queryAllNodes;
~echoPhase.set(\length,(1/110) / (64/49));
~echoPhase.set(\decay,6);
~echoPhase.set(\in_bus,2);
~echoPhase.set(\out_bus,24);
~echoPhase.set(\wet,2);

~echoPulse.set(\length,10/18);
~echoPulse.set(\decay,6);
~echoPulse.set(\in_bus,2);
~echoPulse.set(\out_bus,22);
~echoPulse.set(\wet,1);

~wah.set(\rate,5/128);
~wah.set(\ffreq,400);
~wah.set(\depth,3/4);
~wah.set(\rq,0.2);
~wah.set(\in_bus,6);
~wah.set(\out_bus,6);
~wah.set(\wet,1);

~echo.set(\length,(5/12));
~echo.set(\decay,5);
~echo.set(\wet,1);
~echo.set(\in_bus,6);
~echo.set(\out_bus,20);

~wah2.set(\rate,9/2.5);
~wah2.set(\ffreq,880);
~wah2.set(\depth,7/8);
~wah2.set(\rq,0.3);
~wah2.set(\in_bus,2);
~wah2.set(\out_bus,26);
~wah2.set(\wet,1);


//equal temperament32, midicps
~scales = [[0,7,14,21,28,35,29,24],
          [ -12,-5,12,14,16,19,21,23],
          [ 0,7,12,14,16,17,19,21],
          [ 0,7,12,16,19,23,26,28],
          [ 4,11,12,14,16,18,19,21],
          [ 4,11,13,14,16,18,19,21],
          [ 4,11,13,14,16,18,20,21],
          [ 4,11,13,15,16,18,20,21]];

//just intonation, ratios
~scales = [[ 1/2,3/4,2,9/4,5/2,3,10/3,15/4],
           [ 1/2,3/4,2,9/4,21/8,3,27/8,7/2],
           [ 1/2,2/3,2,16/7,21/8,3,12/7,7/2]];

~scales = [[ 1/2,3/4,2,9/4,5/2,3,10/3,15/4].sort,
            [ 3/4,9/8,1,5/4,45/16,15/4,9/4,3].sort,
            [ 9/8,27/32,2,5/2,15/8,3,10/3,9/4].sort,
            [ 9/8,27/32,45/32,27/8,(15/4) *9/8,3,15/4,9/4].sort
            ];

~scales = [9/8,81/64,3/2,27/16,243/128,9/4,81/32,3] *.t [9/8,81/64,3/2,27/16,243/128,9/4,81/32,3];

~scales = [3/8,1/2,2/3,1,6/5,3/2,16/9,9/4] *.t [8/9,1,9/8,4/3]*2;


~scales = [8/7,21/16,3/2,12/7,7/4,16/7,21/8,3] *.t [8/7,21/16,3/2,12/7,7/4,16/7,21/8,3];
~scales = [1,9/8,8/7,4/3,3/2,7/4,2,9/4] *.t [2,7/4,9/4,18/7];


~offset = 0;
~pitch = 110 *6/5;

~tempo = 1;
~oe ={|i|[0,2,3,7,5,0].permute((~allvals/(2048)).floor.asInt).wrapAt((~allvals / 512));0};
~om ={|i|[1,9/4,3/2].wrapAt(~o.a.collect({|i|i.d.sum}).sum);1};
~so ={|i|(~o.a.collect({|i|i.xy.sum}).sum.log2) + (~allvals /(~o.a.size**3))};

~playSine = {|note, i|
  var s  = Synth("oto-sine", nil,~g1);
  ~allvals = ~allvals + 1;
  h = [[1,[({|i|i.nthPrime}!16).permute(~o.a.collect({|i|i.xy.sum;}).sum+(~allvals/~o.a.size**2).asInt)[0..4]]].flat, [1,(~o.a.collect({|i|i.xy.sum})[0..4] * [1,1,1,1,1]).clip(1,32)].flat].wrapAt((~o.a.collect({|i|i.d.sum;}).sum/2));
  s.setn(\harm,h);
  ~wah.set(\rate,5/(~o.a.size**2).nextPowerOfTwo);
  ~echo.set(\length,~o.a.collect({|i|i.d.sum;}).sum.abs/15);
  s.set(\bus,6);
  s.setn(\phase,Array.fill(12, {|i|(1024+i)/1024 })); 
  s.set(\freq, note);
  s.set(\atk, 1/~o.a.collect({|i|i.xy.sum}).sum);
  s.set(\sus,-2-~o.a.collect({|i|i.d.sum}).sum.abs);
  s.set(\rel, 3/4* ~tempo);
  s.set(\gate,1); 
  s.set(\amp, (1/(~o.a.size.log2+2)));
};

~playBass = {|note,i|
  var p;
  p= Synth("oto-bass",nil, ~g3);
  p.set(\freq,note*(2**~o.a.collect({|i|i.d.sum;}).sum.clip(-4,4)));
  ~echoPhase.set(\length,1/(note*(2**~o.a.collect({|i|i.d.sum;}).sum.clip(-2,4))));
  ~echoPulse.set(\length,~o.a.collect({|i|i.d.sum;}).sum.abs/15);
  p.set(\amp,(3/(~o.a.size.log2+2)));
  p.set(\atk,0.01/(1+~o.a.collect({|i|i.xy.sum}).sum.log2));
  p.set(\rel, (8/~o.a.collect({|i|i.xy.sum}).sum.log2) * ~tempo );
  p.set(\w,(2**(~o.a.collect({|i|i.d.sum;}).sum.clip(-6,6)* (-1))));
  p.set(\b,2**(~o.a.collect({|i|i.d.sum;}).sum));
  p.set(\k,[3,6].wrapAt(~o.a.collect({|i|i.xy.sum}).sum.factors.size)/1.25);
  ~wah2.set(\rate,[4.5,9].wrapAt(~o.a.collect({|i|i.xy.sum}).sum.factors.size)/2.5);
  p.set(\sus,(-1)  );
  p.set(\bus,2);
  p.set(\gate,1);
  p.set(\a,0.1/~o.a.collect({|i|i.xy.sum;}).sum.abs);
};


~playPulse = {|note,inval|
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
};

~playPhase = {|note,i|
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
};

~askAgain={|note, i|
  //real synth Func goes here
  ~playSine.(note,i);
  ~playPhase.(note,i);
  ~playBass.(note,i);
  ((~allvals %(~o.a.size**2))==0).if({
    //~playPulse.(note,i);

  });
};

~synthFunc = {|note, inval|
  var i;
   i=inval;
   note = ~scales.wrapAt(~so.(i)).wrapAt(note) * ~pitch;
  ~askAgain.(note, i);//refresh synthFunc for instance;
};
~tempo = 1/2;
~init.();
~init = {
  Server.default = Server.internal;
  ~t = TempoClock(9);
  
  // set up routine
  r = Routine { arg inval;	

  	// automaton sound
    ~o = ~otomata.clone();
    ~o.init();
  	//o = Otomata.new(\automaton);
  	o.synthFunc = ~synthFunc;

  	~o =o;

  	~o.clear; // clear lights


  	loop {
  	  o.synthFunc = ~synthFunc;  
  		o.tick; // advance automatons 1 position
  		1.0.yield;		
  	}
  }.play(~t);
};

~automaton = Proto({
  
});
~tempo =1/2;

~t.tempo_(1/32);
~allvals = 0;
~removeOldest.(2);
~removeNewest.(2);
~t.tempo_(9/1.25);


//2 middle * 8
//next 2 * 8
//2, 7, *8
//1, 8 *8
//when bar is at top, 4,5 again

//redo as proto
//save a grid using textArchive
  //same to restore a grid
  
//measure patterns in stream

//record actions
//load in sequence
//set grid direction on start
//2 middle * 8
//next 2 * 8
//2, 7, *8
//1, 8 *8
//when bar is at top, 4,5 again

//redo as proto
//save a grid using textArchive
  //same to restore a grid
  
//each cell w/ its own scale

//measure patterns in stream

//record actions
//load in sequence
//set grid direction on start
  4.do({~o.a.removeAt(~o.a.size-1);})

// check status
~o.n.postln; ~o.a.do{arg i; i.xy.postln;}
~o.n.postln; ~o.a.do{arg i; i.d.postln;}
~o.a.collect({|i|i.d.sum;}).sum