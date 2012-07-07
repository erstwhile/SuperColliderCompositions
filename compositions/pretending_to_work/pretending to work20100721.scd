z = Server.internal;

SynthDef("just-sine",{|freq=100,freq2=50, atk=1, rel=1, sus=1, amp=0.005,pan =0,gate=0,f2=2,a2=2|
	Out.ar(0,Mix.ar(Pan2.ar(FSinOsc.ar(  [1,1] * freq,0,32*amp/((freq+128)/freq.log)),pan)) * EnvGen.ar(Env.perc(atk,rel, 1, sus),gate, doneAction:2) );}).load(z);

	
~clock = TempoClock.new(1/2,0,0,16384);
~clock.tempo_(3.5);
~tempo = 8/8;

~i = 0;
~r = Routine {

8.do({|n|	
	var a = (2**(n +20)).asInt;
	~i =a;
	(2**12).asInt.do({|x|
			var i=~i;
			i.postln;
			~play.value(a+i.asInt,x.asInt);
			~i = ~inc.value(i.asInt,a);
			"x: ".post;
			x.postln;
		});
		
	a = (2**(n +20) + (2**(n+19))).asInt;
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
	var a = ((2**(d.log10.ceil)));
	(i+a).asInt ;
};
	
~w = [  {|p,i|(p.log2.ceil/p.log2.nextPowerOfTwo)*1}];

~n = {|i,il,ill|
var n = [[18,21,27,32,49/2,24],[16,18,27,49/2],[16,21,24,28]].wrapAt(ill.sort.reverse[2]).permute(il.sort.reverse[3].asInt);
n
};

~play = {|i,x|
		var il,ill,r,w,hf,jf,ii,n,logTen;
		ii=i;
		il = ({|x|((2**x)*(i/(2**x)%2).floor)}!i.log2.ceil.asInt);
		ill = (1+il).log2.floor;
		ill.postln;

		i={
			var ils = 2-(i.log2-i.log2.floor),fils;
			fils = {|ff,l|
				var r=ff;
				l.do({
				r=r**ff;
				});
				r.floor;
			};
	
			i.log10.floor.asInt.do({|x|
				(x+fils.(ils,x)-1).postln;
			});
			
			( ((i.log2.floor-i.log10.ceil).floor.asInt.collect({|x| i%il.reverse.wrapAt(fils.(ils,x)+x-1)}).sum)).ceil.asInt;
			
			}.value;

		i.postln;
		logTen = i.log10.ceil.asInt;
		i.factors.postln;

		hf = ([2**(i.log10+4).ceil,il.reject(_==0)].flat.reverse.wrapAt(logTen+2)).floor.asInt / (2**logTen).asInt;
		hf = [2**(0..(ill.sort.reverse[1]).asInt),2**i.log10.ceil].flat.reverse.wrapAt(i.factors.reverse[0]).floor.asInt;
		//hf = [2**(i.log10+4).ceil,il.reject(_==0)].flat.reverse.wrapAt(i.factors.reverse[0]).floor.asInt;		
		hf.postln;
		w = ~w[0];


		n = ~n.value(i,il,ill);

		i.postln;
		r = Routine {
		i.factors.do({|p,j|
			var rr = Routine {
				(p.log2 * ((i > (2**20)).if({1/2},{1/2}))).ceil.asInt.do({|k|
				var pp = i.factors[j].asInt;
				(z.peakCPU > 90).if({z.freeAll});

				(p.log10.ceil * ((i > (2**21)).if({1},{1}))).ceil.asInt.do({|l|
					var s,freq;
					s = Synth("just-sine");
					p=p.nextPowerOfTwo;
						freq ={
						var qq,il2, ils, oc, js;
						il2 = (i.log2 - i.log2.floor);
						ils = (ill.sum*(il2**2));
						qq=[2,({|q|q=q+1;((q+1)/q)}!logTen)].flat;
						oc = [2**(j%(il2 * logTen).floor)].wrapAt(ill.reverse[0]);
						js = j * [(1+(ill.reject(_==0).reverse.wrapAt(logTen * ils))%2)].wrapAt(ill.reverse[0]);
						((7/3)*(p *(2**((i.log10.floor+i.log2.floor+i.factors.size)%(1+i.log10.floor.asInt)) ) *.x n.permute(0).wrapAt((l+js+k+pp -2 + 0)*(1+(i.factors[j]%2))) * qq.wrapAt(ill.sort.wrapAt(i.log.floor-1))) *oc* (1/2**l))
					}.value;
				(freq > (2**14)).if({freq = freq / (2**( i.factors.size.clip(2,i.log10.ceil.asInt)))});
				
					(freq > 192).if({freq = freq * ({|jj|jj=jj+1; jj=(jj*(1 + (({|q|q}!i.log2.ceil)).permute(0)).wrapAt(k+j)+hf); (jj+1)/jj}).value(j+k+l)});

					(freq > 192).if({freq = freq + ({|i|i * (3.5/8)}!(i.log/2).ceil.asInt).permute(0).wrapAt(j +pp -2)});

					s.set(\freq, freq);
					

					[
					{s.set(\rel,((4/(4+(i.log2/19).floor))*((28+l)/pp.log2.ceil)/i.log10)*~tempo);},					{s.set(\rel,((4/(4+(i.log2/19).floor))*((0.7+l)*p.log2.ceil)/i.log10)*~tempo);}
					].wrapAt(ill.reverse.wrapAt(logTen+1)).value;

					s.set(\pan,(2/(i.factors[j])) * (-1**((ii+j)%5)));

					s.set(\atk,(1/(2**14)) * (i.factors[j]*pp.log10) * (1/(i.log*2)));

					s.set(\sus,-1 * i.factors[j].log);
					s.set(\gate,1);
					s.set(\amp,{
						var c1, c2;
						c1 = 2 + (i.log2-i.log2.floor);
						c2 = (10**(2+(i.log2-i.log2.floor)));
						((c1/((p+c2).log10))
						*((1/((p+(1)).log10)) 
						* 0.015 
						/ ((k/p.log10.ceil)+1))
						*(i.factors[j].sqrt 
						* (c1/(pp+c2).log10)))
					}.value);
				});
				w.(i.factors[j],i).wait;
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