//cheerful and ethereal
z = Server.internal;

//pink noise amplitude curve
SynthDef("just-sine",{|freq=100,freq2=50, atk=1, rel=1, sus=1, amp=0.005,pan =0,gate=0|
	Out.ar(0,Mix.ar(Pan2.ar(FSinOsc.ar( [1,1] * freq,0,128 * amp/freq),pan)) * EnvGen.ar(Env.perc(atk,rel, 1, sus),gate, doneAction:2) );}).load(z);
	
~clock = TempoClock.new(1/2,0,0,16384);
~clock.tempo_(2.5);
~tempo = 8/8;
~i= (2**4).asInt;
~r = Routine {

	(75297).asInt.do({|x|
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
	var a = ((2**(i.log10.ceil)));
	(i+a).asInt;
};
	
~w = [  
	{|p,i|(p.log2.ceil/p.log2.nextPowerOfTwo)*2}
];

~play = {|i,x|
		var il,ill,r,w,hf,jf,ii,n,logTen;
		ii=i;
		il = ({|x|((2**x)*(i/(2**x)%2).floor)}!i.log2.ceil.asInt);
		ill = (1+il).log2.floor;
		//ill.postln;
		//il.postln;
		//i.postln;
		i=( il.sort.reverse[0] + il.reverse[1] + il.sort.reverse.wrapAt(i.log10-1) +(i%il.sort.reverse.wrapAt(i.log10+1))+ (i%il.sort.reverse.wrapAt(i.log10-2))).ceil.asInt;
		logTen = i.log10.ceil.asInt;

		hf = ([2**(i.log10+2).ceil,il.reject(_==0).reject(_ > (2**16))].flat.reverse.wrapAt(logTen+2)).floor.asInt;
		//hf.postln;
		w = ~w.wrapAt(ill.reverse.wrapAt(logTen - 3));

		n = [[16,18,24,27,36,40],[16,20,24,30,36,45,54],[45*3/4,20,27,30,45,54]].permute(ill.reverse[0].asInt).wrapAt(ill.reverse.wrapAt(logTen));
		
		//n.postln;
		//i.postln;
		//i.factors.postln;		
		r = Routine {
		i.factors.do({|p,j|
			var rr = Routine {
				(p.log2 * ((i > (2**21)).if({3/4},{1}))).ceil.asInt.do({|k|
				var pp = i.factors[j].asInt;
				(z.peakCPU > 90).if({z.freeAll});

				(p.log10.ceil * ((i > (2**21)).if({3/4},{1}))).ceil.asInt.do({|l|
					var s,freq;
					s = Synth("just-sine");
					p=p.nextPowerOfTwo;
									
					freq =((p *(2**((i.log2.ceil %4)+i.log10.floor) ) *.x n.permute(i).wrapAt((l+j+k+pp -2)*(1+(i.factors[j]%2))) *.x [1,9/8].wrapAt(ill.sort.wrapAt(i.log.floor-1)) /16) * (2**i.factors.size)) * (1/2**l);
					
					freq = freq * ({|jj|jj=jj+1; jj=(jj*(1 + (({|q|q}!i.log2.ceil)*i.factors.reverse[0].log10.floor).permute(i)/32).wrapAt(j+k+l)+hf); jj/jj.nextPowerOfTwo}).value(j+k+l);

					
					(freq > (2**14)).if ({freq = freq * (1/(2**7))});
					(freq > (2**14)).if ({freq = freq * (1/(2**7))});
					(freq > (2**14)).if ({freq = freq * (1/(2**7))});
					(freq > (2**14)).if ({freq.postln; freq = freq * (1/(2**7))});

					(freq < (2**7)).if ({freq = freq * 2});
					(freq > 192).if({freq = freq + ({|i|i * (2.5/8)}!(i.log/2).ceil.asInt).permute(i).wrapAt(j +pp -2)});

					s.set(\freq, freq);
					

					[
					{s.set(\rel,((4/(4+(i.log2/19).floor))*((28+l)/pp.log2.ceil)/i.log10)*~tempo);},					{s.set(\rel,((4/(4+(i.log2/19).floor))*((0.8+l)*p.log2.ceil)/i.log10)*~tempo);}
					].wrapAt(ill.reverse.wrapAt(logTen+1)).value;

					s.set(\pan,(2/(i.factors[j])) * (-1**((ii+j)%5)));

					s.set(\atk,(1/freq) * (i.factors[j]) * (1/(i.log*2)));

					s.set(\sus,-1 * i.factors[j].log);
					s.set(\gate,1);
					s.set(\amp,((2/((p+100).log10))*((1/((p+(1)).log10)) * 0.015 / ((k/p.log10.ceil)+1))*(i.factors[j].sqrt * (2/(pp+100).log10)))/(l+1));
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
Ê