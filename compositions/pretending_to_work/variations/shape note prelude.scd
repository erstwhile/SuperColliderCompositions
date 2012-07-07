//slow and unfocused
z = Server.internal;

//pink noise amplitude curve
SynthDef("just-sine",{|freq=100,freq2=50, atk=1, rel=1, sus=1, amp=0.005,pan =0,gate=0,f2=2,a2=2|
	Out.ar(0,Mix.ar(Pan2.ar(FSinOsc.ar( [1,1] * freq,0,128 * amp/(freq+256)),pan)) * EnvGen.ar(Env.perc(atk,rel, 1, sus),gate, doneAction:2) );}).load(z);
	
~clock = TempoClock.new(1/2,0,0,16384);
~clock.tempo_(3.5/2);
~tempo = 7/32;
~i= (2**[23,24,25,26]).sum.asInt;
~r = Routine {
	1.do({|s|
	(2**15).asInt.do({|x|
		var i=~i;
		x = (x + (s*(2**11))).asInt;
		s=s%4;
		~play.value(i.asInt,x.asInt);
		~i = ~inc.value(i.asInt,-1*s);
		"x: ".post;
		x.postln;
	});
	});
240.wait;
z.freeAll;
};

~inc = {|i,s|
	var a = ((2**(i.log10.floor+s)));
	(i+a).asInt;
};
	
~w = [{|p,i,j|(p/p.nextPowerOfTwo)},{|p,i,j|j / p.log2.ceil}];


~play = {|i,x|
		var il,ill,r,w,hf,jf,ii,n,n2,logTen,preWait,postWait;
		ii=i;
		il = ({|x|((2**x)*(i/(2**x)%2).floor)}!i.log2.ceil.asInt);
		ill = (1+il).log2.floor;
		ill.postln; il.postln;
		logTen = i.log10.ceil.asInt;

		w = [{|p,i,j|0},~w.wrapAt(ill.reverse.wrapAt(logTen))];
		preWait =w.wrapAt(ill.reverse.wrapAt(logTen + 1));
		postWait = w.wrapAt(ill.reverse.wrapAt(logTen + 1)+1);
		
		hf = ([2**(i.log10+2).ceil,il.reject(_==0).reject(_ > (2**14))].flat.reverse.wrapAt(logTen+2)).floor.asInt;
		hf.postln;

		n = 7/8 * ({|jj|jj=(jj*2)+2; jj=jj.nextPowerOfTwo/jj}!il.reject(_==0).size);
		n=[n,1/n].wrapAt((ill.sum).log2) *32;
		
		i=( il.sort.reverse[0] + il.reverse[1] - il.reject(_==0).wrapAt(2) + il.sort.reverse.wrapAt(i.log10-1) +(i%il.sort.reverse.wrapAt(i.log10+1))- (2**il.sort.reject(_!=0).size)+  (i%il.sort.reverse.wrapAt(i.log10 - il.reject(_==0).size.log2.ceil))).ceil.asInt;
		
		n.postln; i.postln; i.factors.postln;		
		r = Routine {
			i.factors.do({|p,j|
				var rr = Routine {
					(z.peakCPU > 90).if({z.freeAll});
					p.log2.ceil.asInt.do({|k|
						var pp = i.factors[j].asInt;
						preWait.(pp,i,j).wait;
						p.log10.ceil.asInt.do({|l|
							var s,freq;
							s = Synth("just-sine");
							p=p.nextPowerOfTwo;		
							freq =((p *.x n.wrapAt(((l*(0**il.reverse.wrapAt(logTen-2)))+(j*(0**il.reverse.wrapAt(logTen)))+(k*(0**il.reverse.wrapAt(logTen-1)))+pp-2 + ill.sum.log2))) * (2**(i.factors.size%8)));
							
							(freq > 192).if({freq = freq *  (hf + ((j + k + l) * i.factors.reverse[0].log10.floor)) / hf},{freq = freq});
							(freq > (2**14)).if({freq = freq / (2**(p.log.ceil+1))});
							s.set(\freq, freq);
							s.set(\rel,((28+l)/pp.log2.ceil)*~tempo);
							s.set(\pan,(2/(i.factors[j])) * (-1**((ii+j)%5)));
							s.set(\atk,(1/freq) * (2**i.factors[j].log.clip(1,10).ceil) * (1/64));
							s.set(\sus,-1 * (i.factors[j].log2.clip(1,12)/3));
							s.set(\amp,	0.05 / ((k/p.log10.ceil)+1));
																			s.set(\gate,1);
							});
							postWait.(pp,i,j).wait;
						});
					};
				~clock.play(rr,0);
			});
		};
		~clock.play(r,0);
		(1/2).wait;
};


~clock.play(~r,0);
z.scope;

