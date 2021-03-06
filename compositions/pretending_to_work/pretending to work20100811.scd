z = Server.internal;

SynthDef("just-sine",{|freq=100,freq2=50, atk=1, rel=1, sus=1, amp=0.005,pan =0,gate=0,f2=2,a2=2|
	Out.ar(0,Mix.ar(Pan2.ar(FSinOsc.ar(  [1,1] * freq,0,0.25 *amp/((freq+128)/freq.log2)),pan)) * EnvGen.ar(Env.perc(atk,rel, 1, sus),gate, doneAction:2) );}).load(z);


SynthDef("just-sine-atk",{|freq=100,freq2=50, atk=1, rel=1, sus=1, amp=0.005,pan =0,gate=0,f2=0.5,a2=2, k=0.1|
	Out.ar(0,Mix.ar(Pan2.ar(SinOsc.ar(XLine.ar(3/4,1,1/64)*  [1,1] * freq,0,0.25 *amp/((freq+128)/freq.log2)),pan)) * EnvGen.ar(Env.perc(atk,rel, 1, sus),gate, doneAction:2) );}).load(z);

	
~clock = TempoClock.new(1/2,0,0,16384);
~clock.tempo_(3.5/1);
~tempo = 5/8;

~i = 0;
~r = Routine {

12.do({|n|	
	var a = (2**(n +15)).asInt;
	~i =a;
	(2**12).asInt.do({|x|
			var i=~i;
			i.postln;
			~play.value(a+i.asInt,x.asInt);
			~i = ~inc.value(i.asInt,a);
			"x: ".post;
			x.postln;
		});
	});
240.wait;
z.freeAll;
};

~inc = {|i,d|
	var a = ((2**(d.log2.ceil - 11)));
	(i+a).asInt ;
};
	
~w = [  {|p,i|(p.log10.nextPowerOfTwo/p.log10.ceil)*i.log10.ceil.nextPowerOfTwo}];
~w = [  {|p,i|p/p.nextPowerOfTwo}];

~n = {|i,il,ill|
var n = [[16,20,24,30,36,45,54]].wrapAt(ill.sort.reverse[2]).permute(il.sort.reverse[3].asInt);
n
};
/*
~n = {|i,il,ill|
var n = [[17,23,31,41],[19,29,37,47]].wrapAt(ill.sort.reverse[2]).permute(il.sort.reverse[3].asInt);
n.permute(i.log2.ceil.asInt)[0..(ill.sort.reverse[4].asInt%4)];  
//n=(n *.x [1,n]).flat;
n
};

*/

~play = {|i,x|
		var il,ill,r,w,hf,jf,ii,n,logTen;
		ii=i;
		il = ({|x|((2**x)*(i/(2**x)%2).floor)}!i.log2.ceil.asInt);
		ill = (1+il).log2.floor;
		ill.postln;


		i={
			var ils = 2-(i.log2-i.log2.floor),fils,iFunc;
			fils = {|ff,l|
				var r=ff;
				l.do({
				r=r**ff;
				});
				r.floor;
			};
	
			(i.log2.floor - i.log.ceil).floor.asInt.do({|x|
				(x+fils.(ils,x)).postln;
			});
			
			iFunc = 
			[
			{(((i.log2.floor - i.log.ceil).floor.asInt.collect({|x| i%il.flat.sort.reverse.wrapAt(x+fils.(ils,x))}).sum)).ceil.asInt}
			].wrapAt(ill.reverse[0]);
			iFunc.value;

			
			}.value;

		"i".post; i.postln;
		logTen = i.log10.ceil.asInt;
		i.factors.postln;

		hf = (i.factors.reverse[0].nextPowerOfTwo**3);
		
		"hf".post; hf.postln;
		w = ~w[0];

		n = ~n.value(i,il,ill);

		i.postln;
		r = Routine {
		i.factors.do({|p,j|
			var rr = Routine {
			(p.log2 * ((i > (2**20)).if({1/2},{1/2}))).ceil.asInt.do({|k|
				var pp = i.factors[j].asInt;
				(z.peakCPU > 90).if({z.freeAll});

				(1).ceil.asInt.do({|l|
					var s,freq;
					(p<3).if({	s = Synth("just-sine");},{	s = Synth("just-sine");});
					p=p.nextPowerOfTwo.nextPrime;
						freq ={
						var qq,il2, ils, oc, js;
						il2 = (i.log2 - i.log2.floor);
						ils = (ill.sum*(il2**2));
						qq=n.collect({|x|2*x/x}).flat.wrapAt(ill.sort.reverse.wrapAt(logTen/2).asInt.factors[0]);
						oc = [2**(j%(il2 * logTen).floor)].wrapAt(ill.reverse[0]);
						js = j * [(1+(ill.sort.reverse.wrapAt(i.factors.reverse[0].log2)))%2].wrapAt(ill.reverse[0]);
						((8/7)*(p *(2**((i.log10.floor+i.log2.floor+i.factors.size)%(i.log10.floor.asInt))) *.x n.permute(0).wrapAt((l+js+pp -2 + 0)*(1+(i.factors[j]%2))) * qq) *oc)
					}.value;
				
					freq = freq * ((hf + (j*([17,19,23,29,31,37,41].wrapAt(i.factors.size))))/(hf));

					(freq > (2**14)).if({freq = freq / (2**( i.factors.size.clip(2,i.log10.floor.asInt)))});

					s.set(\freq, freq);
					

					[
					{s.set(\rel,((4/(4+(i.log/19).floor))*((26+l)/pp.log2.ceil)/i.log10)*~tempo);},					{s.set(\rel,((4/(4+(i.log/19).floor))*((0.7+l)*p.log2.ceil)/i.log10)*~tempo);}
					].wrapAt(ill.reverse.wrapAt(logTen+1)).value;

					s.set(\pan,(2/(i.factors[j])) * (-1**((ii+j)%5)));

					s.set(\atk,(1/(2**(12-k))) * (i.factors[j]*pp.log10) * (1/(i.log*2)));
					s.set(\k,1/(pp));
					s.set(\sus,-1 * i.factors[j].log);
					s.set(\gate,1);
					s.set(\amp,{
						var c1, c2;
						c1 = 2 + (i.log2-i.log2.floor);
						c2 = (10**(2+(i.log2-i.log2.floor)));
						((c1/((p+c2).log10))
						*((1/((p+(1)).log10)) 
						/ ((k/p.log10.ceil)+1))
						*(i.factors[j].sqrt 
						* (c1/(pp+c2).log10)))
						* (x.factors[0] / x.factors[0].nextPowerOfTwo)
					}.value);
				});
				w.(i.factors[j],i).wait;
				});
				
			};
			~clock.play(rr,0);
			});
		};
		~clock.play(r,0);
		{
		var c =(ill.sort.reverse[1].asInt.isInteger).if({(2**ill.sort.reverse.wrapAt(2) / (2**i.log10.ceil.asInt))},{2});
		c.postln;
		([2/6,2/6]).wrapAt(x/c);
		}.value.wait;
		
};


~clock.play(~r,0);
z.scope;
