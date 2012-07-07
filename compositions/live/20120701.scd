/* define and boot servers */
Server.internal.boot; Server.internal.makeWindow;
Server.local.boot; Server.local.makeWindow;
~x = Server.new("two",NetAddr("127.0.0.1", 9989));
~x.boot; ~x.makeWindow;
~xx = Server.new("three",NetAddr("127.0.0.1", 9988));
~xx.boot; ~xx.makeWindow;
~z = [Server.internal, Server.local,~x,~xx];

/* define synths and send to servers */
~z.collect({|z|
SynthDef("pulser",{|freq=100,m=#[1,1,1,1], atk=1,fatk=1, rel=1, sus=1, w=0.5,amp=0.005,pan =0,gate=0,sw=8,r=(0.5),out=0,mrate=1|
	Out.ar(out,Mix.ar(Pan2.ar(RLPF.ar(Pulse.ar( m * freq ,w
,0.5 * 5 * amp/(((freq)+256))),(LFPulse.ar(mrate,0,0.5,0,w)*freq*EnvGen.ar(Env.asr(fatk,sw, rel*2,'sine'),gate, doneAction:2)).clip(32,2**14),r,1),pan)) * EnvGen.ar(Env.asr(atk,1, rel,'sine'),gate, doneAction:0) );}).send(z);
});
~z.collect({|z|
SynthDef("sine-cluster",{|freq=100, atk=1, rel=1, sus=1, amp=0.005,pan =0,gate=0|
	Out.ar(0,Mix.ar(Pan2.ar(FSinOsc.ar(  [1,1] * freq,0,7 * amp/(((freq)+256))),pan)) * EnvGen.ar(Env.perc(atk,rel, 1,sus),gate, doneAction:2) );}).send(z);
});

/* Define functions for playing our synths */
~sineClusterplayer = {|f=64,scaleDegree=1,overtones=([1,3,7,13,16]),articulation=1,cycle=1,amp=1,step=1|
  //step thru a collection of overtones
	overtones.collect({|overtone,num|
    //play a tight cluster of 8 sines, slightly detuned from the overtone
		8.do({|clusterTone|
				var sn = Synth("sine-cluster",nil,~z.wrapAt(clusterTone+num)),freq,
				  accent=(((~scale.wrapAt(scaleDegree+cycle)%~scale.size)+1)/~scale.size);
				freq = f * scaleDegree * overtone;
        freq = freq * (freq > 128).if({~pitchTweak.(clusterTone,cycle,num)},{1});//just a little detune if we're not too deep in the bass
				sn.set(\freq,freq);
				sn.set(\atk,(1/64) + ((num*overtone)/64) );//higher overtones have longer attack
				sn.set(\amp,1.5 * amp);
				sn.set(\rel,(48 * ~t * ~tempo) / ~scale.size.clip(2,32).log2);
				sn.set(\sus,-1.125 * articulation * accent * (scaleDegree%overtone).clip(2,~scale.size).asInt.factors[0].log2);
				sn.set(\pan,([1,-1] /.x (2..6)).sort.wrapAt(clusterTone+step+num));
				sn.set(\gate,1);
		});
	});
};

~pulserPlayer = {|scale,m,x|
		var r = scale.wrapAt(x%m),fm = ~modulation.(scale,m,(x/~scale.size).asInt), 
		  p = Synth("pulser",nil,~z.wrapAt(x)), ws = ~scale.collect({|m|1 / (m+1).log2.ceil}),freq;
		freq = ~f * 3/2 * r*fm;
		p.set(\freq,freq / 2);
		p.set(\mrate,~f * 3);
		p.set(\w,(ws).permute(x.asInt).wrapAt(m+r));
		p.setn(\m,[1,1025/512,1024/1025,2]);
		p.set(\fatk,~scale.permute(x).wrapAt(x).log2.ceil/128);
		p.set(\atk,~scale.permute(x).wrapAt(x).log2.ceil/512);
		p.set(\r,(1/(~scale+1).log2).permute(x).wrapAt(m));
		p.set(\sw,m.nextPowerOfTwo);
		p.set(\pan,([-1,1] /.x (m..(m*2))).sort.wrapAt(x+r));
		p.set(\rel,2 * ~t * scale.wrapAt(m+r+x).clip(1/~t,64) * ~tempo);
		p.set(\gate,1);
		p.set(\amp,4);
		Routine {
			(~t*2).wait;
			p.set(\gate,0);	
		}.play;
	};

//tweak pitches by a tiny interval
~pitchTweak = {|clusterTone,xr,j|
  [(2046+(0..15).nthPrime.wrapAt(clusterTone*j)-j.nthPrime)/2048,(2046+(0..15).nextPrime.wrapAt(clusterTone*j))/2048].wrapAt(j+xr)
};

//unwrap our scale into a flat array of all factors, then modulate by several of those factors, then scale back to the octave
~modulation = {|scale,m,x|
	var out = 1;
	(scale.permute(x).wrapAt(x)).asInt.do({|i|
		out = out * scale.collect({|m|m.ceil.asInt.factors}).flat.reject(_ >m.ceil.asInt.factors.reverse[0]).permute(x).wrapAt(scale.wrapAt(i));
		out = 2*out / out.nextPowerOfTwo;
	});
	[out,out.nextPowerOfTwo/out].wrapAt(x/(3600));
};


//tweak timing or articulation based on where we are in the scale
~swing = {|m,a=0|
	[(m+2)/(m+1),(5+m)/(6+m)].wrapAt(a);
};

//call this once each step to play notes
~player = {|x|
	var k = ~scale.permute(x), scale = ~scale.permute((x/k.wrapAt(k.reverse[0])).asInt), m = scale.wrapAt(x), fm = ~modulation.(scale,m,x), ru = ~swing.(m,0), cycle = (x/~scale.size).floor;
  //play some pulser notes
	~scale.collect({|m,n| (m==~scale.permute(x).wrapAt(x+m)).if({~pulserPlayer.(scale,m,x);});});
  (~scale[0]==~scale.permute(x).wrapAt(x)).if({
		~sineClusterplayer.(~f,m *3/2* (fm / fm.nextPowerOfTwo),  
		  [1,scale.rotate(x).permute(m.asInt)[0..3]].flat.permute(x.asInt),
		  ru, cycle, ru*18/16,x);
		~sineClusterplayer.(~f,m *3/2* (fm / fm.nextPowerOfTwo),
		 [1/3,1,3,5,7,9,11].flat.permute(x),
		  0.9*ru,cycle,ru*7/10,x);
	});
	(scale.wrapAt(x) == scale.wrapAt(x/(scale.size))).if({
		~sineClusterplayer.(~f,m *3/2*( fm / fm.nextPowerOfTwo) * (1 / (2**(m.log2.floor))),
		  [[1,[23/2,11,13,17,19/4,29/2,31/2].permute(x)[0..(scale[0].round.asInt)]].flat *.x 
		  scale.rotate(x).permute(m.asInt)[0..1].collect({|p|(2*p)/p.nextPowerOfTwo}) ].flat.permute(x),
		  1/scale.size,  cycle, 1, x);
	});

	(~t*~swing.(m,1)).wait;	
};

~ff = [72];
~tempo = 1;

~calculateStep = {|x|
	var offset = (Date.localtime.format("%s").asInt/3600).floor*3600;
	([x,(x/~scale.wrapAt(x))].wrapAt(x/(90**2))+offset).asInt;
};

~calculateGlobals = {|x|
  ~scale = [((1.5**(0..3))*.x[1,2,4,8,9]),((1.5**(0..3))*.x[1,2,4,8,9]).sort].wrapAt(x/900)[0..(3..19).foldAt(x/300)];
	~scale = [~scale,~scale.ceil].wrapAt((x/7200));
	((x%300)==0).if({~ff =[~setTemp.("10001"),~setTemp.("11201")];});
	~f = ~ff.wrapAt(x);
	~f = (~f<1).if({64},{~f});
	~t = 2/9 * (128/~f);
};

~setTemp = {|zip="11201"|
	var p,l,a,url;
	url = "http://backtrace.us:9393/"++zip;
	p = Pipe.new("curl "++url,"r");
  a = "";
  l = p.getLine;
  while({l.notNil}, {a = a + l; l = p.getLine; });
  p.close;
  a.asInt;
};

/* our player routine */
~r = Routine {
	(inf).do({|x|
    		~calculateGlobals.(x);
		x= ~calculateStep.(x);
		~player.(x.asInt);
	});
};
~r.play;