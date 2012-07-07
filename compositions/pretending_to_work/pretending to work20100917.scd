//variant of "more of the same"
z = Server.internal;

SynthDef("just-sine",{|freq=100,freq2=50, atk=1, rel=1, sus=1, amp=0.005,pan =0,gate=0,f2=2,a2=2|
	Out.ar(0,Mix.ar(Pan2.ar(SinOsc.ar(  [1,1] * freq,0,0.02 *amp) * AmpComp.kr(freq,32,1.025),pan)) * EnvGen.ar(Env.linen(atk,rel, 1, sus),gate, doneAction:2) );}).load(z);


~clock = TempoClock.new(1/2,0,0,16384);
~clock.tempo_(3.5/1);
~tempo = 5/8;
~z = 3999999991;
~i = 0;
~r = Routine {

16.do({|n|	
	var a = (2**(n +12)).asInt;
	~i =a;
	(2**12).asInt.do({|x|
			var i=~i;
			i.postln;
			~play.value(a+i.asInt,x.asInt);
			~i = ~inc.value(i.asInt,a);
			"x: ".post;
			x.postln;
		});
	a = 	((2**(n +13)) - (2**12)).asInt;
	~i = a;
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
	var a = 2;
	(i+a).asInt ;
};
	
~w = [  {|p,i|p.log2.ceil/p.log2.ceil.nextPowerOfTwo} *4/3];





~n = {|i,il,ill|
var n = [[16,18,32/3,24,27,28]].wrapAt(ill.sort.reverse[2]).permute(il.sort.reverse[3].asInt);
n
};

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
				//clip r
				r.clip(0,i.log2.ceil.asInt).floor;
				
			};
	
			(i.log2.floor - i.log.ceil).floor.asInt.do({|x|
				(fils.(ils,x)).postln;
			});
			
			iFunc = 
			[
			{(((i.log2.floor - i.log.ceil).floor.asInt.collect({|x|i% il.sort.flat.reverse.wrapAt(fils.(ils,x))}).sum)).ceil.asInt}

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
		~tempo = ((ill.sum/2).log2)/6;
		~tempo.postln;
		r = Routine {
		i.factors.do({|p,j|
			var rr = Routine {
			(p.log2 * ((i > (2**20)).if({1},{1}))).ceil.asInt.do({|k|
				var pp = i.factors[j].asInt;
				(z.peakCPU > 90).if({z.freeAll});
				(1).ceil.asInt.do({|l|
					var s,freq,atk,rel;
					(p<~z).if({	s = Synth("just-sine");},{	s = Synth("just-sine");});
					p=p.nextPowerOfTwo.nextPrime;
						freq ={
						var qq,il2, ils, oc, js;
						il2 = (i.log2 - i.log2.floor);
						ils = (ill.sum*(il2**2));
						qq=[2,n.collect({|x|(2*x)/(x.nextPowerOfTwo)}).flat.wrapAt(ill.sort.reverse.wrapAt(i.factors.reverse[0]).asInt.factors[0])].wrapAt(ill.sort.reverse[1]);
						qq = qq * (n.collect({|x|(2*x)/(x.nextPowerOfTwo)}).wrapAt(ill.reverse[0].asInt.factors[0]));
						oc = [2**(j%(il2 * logTen).floor)].wrapAt(ill.reverse[0]);
						js = j * [(1+(ill.sort.reverse.wrapAt(i.factors.reverse[0].log2)))%2].wrapAt(ill.reverse[0]);
						((8/7)*(p *(2**((i.log10.floor+i.log2.floor+i.factors.size)%(i.log10.floor.asInt))) *.x n[0..i.factors.reverse[0].log10.ceil.asInt].wrapAt((js+pp -2 + 0)) * qq) *oc * (k+1))
					}.value;
				
					freq = freq * ((hf + (j*([17,19,23,29,31,37,41].wrapAt(i.factors.size))))/(hf));

					(freq > (2**14)).if({freq = freq / (2**( i.factors.size.clip(2,i.log10.floor.asInt)))});

					s.set(\freq, freq);
				rel = [
					{((4/(4+(i.log/19).floor))*((26+l)/pp.log2.ceil)/i.log10)*~tempo;},	
					{((4/(4+(i.log/19).floor))*((0.7+l)*p.log2.ceil)/i.log10)*~tempo;}
					].wrapAt(ill.reverse.wrapAt(logTen+1)).value;

					s.set(\pan,(2/(i.factors[j])) * (-1**((ii+j)%5)));
					atk = ((1/(2**(12-(k%i.factors.size)))) * (i.factors[j]/pp.log10)).clip(0,32) * (1/(i.log*2));
					s.set(\atk,[atk,rel].wrapAt(i.factors.reverse[0].log10));
					s.set(\rel,[atk,rel].wrapAt(i.factors.reverse[0].log10+1));
					s.set(\k,1/(pp));
					s.set(\sus,-1 * i.factors[j].log);
					s.set(\gate,1);
					s.set(\amp,{
						var c1, c2;
						c1 = 2 + (i.log2-i.log2.floor);
						c2 = (10**(2+(i.log2-i.log2.floor)));
						((c1/((p+c2).log10))
						*((1/((p+(10)).log10)) )
						* 4
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
