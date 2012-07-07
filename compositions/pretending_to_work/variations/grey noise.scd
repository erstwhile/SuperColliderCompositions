//slow and unfocused
z = Server.internal;

//pink noise amplitude curve
SynthDef("just-sine",{|freq=100,freq2=50, atk=1, rel=1, sus=1, amp=0.005,pan =0,gate=0,f2=2,a2=2|
	Out.ar(0,Mix.ar(Pan2.ar(FSinOsc.ar( [1,1] * freq,0,128 * amp/(freq+64)),pan)) * EnvGen.ar(Env.perc(atk,rel, 1, sus),gate, doneAction:2) );}).load(z);
	
~clock = TempoClock.new(1/2,0,0,16384);
~clock.tempo_(3.5/2);
~tempo = 8/32;
~i= ((2**26)+(2**25)+(2**24)+(2**23)+(2**22)).asInt;
~r = Routine {
	(2**16).asInt.do({|x|
		var i=~i;
		~play.value(i.asInt,x.asInt);
		~i = ~inc.value(i.asInt);
		"x: ".post;
		x.postln;
	});
240.wait;
z.freeAll;
};

~inc = {|i|
	var a = ((2**(i.log10.floor)));
	(i+a).asInt;
};
	
~w = [  
	{|p,i|(p.ceil/p.nextPowerOfTwo)}
];

~play = {|i,x|
		var il,ill,r,w,hf,jf,ii,n,n2,logTen;
		ii=i;
		il = ({|x|((2**x)*(i/(2**x)%2).floor)}!i.log2.ceil.asInt);
		ill = (1+il).log2.floor;
		ill.postln;
		il.postln;
			i=( il.sort.reverse[0] + il.reverse[1] + il.sort.reverse.wrapAt(i.log10-1) +(i%il.sort.reverse.wrapAt(i.log10+1))- (2**il.sort.reject(_!=0).size)+  (i%il.sort.reverse.wrapAt(i.log10 - il.reject(_==0).size.log2.ceil))).ceil.asInt;
	
		logTen = i.log10.ceil.asInt;
		({|i|i}!~w.size).wrapAt(ill.reverse.wrapAt(logTen-3)).postln;
		hf = ([2**(i.log10+2).ceil,il.reject(_==0).reject(_ > (2**16))].flat.reverse.wrapAt(logTen+2)).floor.asInt;
		hf.postln;
		w = ~w.wrapAt(ill.reverse.wrapAt(logTen - 3));

		
		n=({|j|j.asInt.nextPrime}!i.log2.ceil);
		n =7/8* [[16,18,24,32*4/5],[16,16*4/3,24,16*(4/3)*(4/3),36],[16*6/5,25,32*5/4,36]].permute(ill.reverse[0..2].sum.asInt).wrapAt(ill.sum.log2.ceil).permute(il.sort.reverse.wrapAt(logTen-2).asInt)[0..((ill.reject(_==0).size)/2).floor.asInt];
		
		
		n2= [[16,18,24,27],[16,20,24,30,36,45,54],[100/3,25,30,45/2],[45*3/4,20,27,30,45,54]].permute(ill.reverse[0..6].sum.asInt).wrapAt(ill.sum.log.ceil).permute(il.sum.asInt)[0..((ill.reject(_==0).size)/2).floor.asInt];
		n2 = n2.collect({|i|2 * i/i.nextPowerOfTwo});
		n2 = n2 *.x n2;
		//make a big change if this is on or not
		n=n * n2.wrapAt(i);
		n2.postln;
		n.postln;
		i.postln;
		i.factors.postln;		
		r = Routine {
		(i > (2**27)).if({i = i.factors[2..(i.factors.size)].product});  //not in variant
    
		i.factors.do({|p,j|
			var rr = Routine {
				(p.log2 * ((i > (2**21)).if({1},{1}))).ceil.asInt.do({|k|
				var pp = i.factors[j].asInt;
				(z.peakCPU > 90).if({z.freeAll});

				(p.log10.ceil * ((i > (2**21)).if({1},{1}))).ceil.asInt.do({|l|
					var s,freq;
					s = Synth("just-sine");
					p=p.nextPowerOfTwo;		
					freq =((p  *.x n.permute(0).wrapAt((l+j+k+pp -2))) * (2**(i.factors.size%8)));
					(freq > 2).if({freq = freq *  (hf + ((j + k + l) * i.factors.reverse[0].log10.floor)) / hf},{freq = freq.floor}) ;
					(freq > (2**14)).if({freq = freq / (2**(p.log.ceil+1))});

					s.set(\freq, freq);
					

					[
					{s.set(\rel,((28+l)/pp.log2.ceil)*~tempo);},					
					{s.set(\rel,(0.33 * (3+l)*pp.log2.clip(1,10))*~tempo);}
					].wrapAt(ill.reverse.wrapAt(logTen+1)).value;

					s.set(\pan,(2/(i.factors[j])) * (-1**((ii+j)%5)));
					s.set(\atk,(1/freq) * (2**i.factors[j].log.clip(1,10).ceil) * (1/(i.log10*2)));
					s.set(\sus,-1 * (i.factors[j].log2.clip(1,12)/3));
					s.set(\gate,1);
					
					s.set(\amp,  0.05 / ((k/p.log10.ceil)+1));
					});
				w.(pp,i).wait;
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
