
~clock = TempoClock.new(1/2,0,0,16384);
~clock.tempo_((3.5/1.25));
~tempo = 10/2;
~z = {|i,il| (il.size - il.reject(_!=0).size)*2 };
~i = 0;
~r = Routine {

12.do({|n|	
	var a = (2**(n +12)).asInt;
	~i =a;
	(2**(10+(n%4))).asInt.do({|x|
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
	var a = ((2**(d.log2.ceil - (12+(d.log2.ceil%3)))));
	(i+a).asInt ;
};

~w = [  {|p,i|(2/3)* p.log2.ceil/p.log2.ceil.nextPowerOfTwo}];

~n = {|i,il,ill| var n = [[8,10,12,27/2,15,18]].wrapAt(ill.sort.reverse[1]).permute(il.sort.reverse[3].asInt); n };

~play = {|i,x|
		var il,ill,r,w,jf,ii,n,logTen;
		ii=i;
		il = ({|x|((2**x)*(i/(2**x)%2).floor)}!i.log2.ceil.asInt);
		ill = (1+il).log2.floor;
		ill.postln;


		i={
			var ils = 2-(i.log2-i.log2.floor),fils,iFunc;
			fils = {|ff,l|
				var r=ff;
				l.do({
				r=r*ff;
				});
				//clip r
				r.floor;
				
			};
	
			(i.log2.floor - i.log.ceil).floor.asInt.do({|x|
				(fils.(ils,x)+x).postln;
			});
			
			iFunc = 
			
			{(il.sort.reverse[1] + 
			(i.log2.floor - i.log.ceil).floor.asInt.collect({|x|il.flat.reverse.wrapAt(fils.(ils,x))}).sum +
			([(i.log2.floor - i.log.ceil).floor.asInt.collect({|x|i% il.flat.reverse.wrapAt(fils.(ils,x)+x)}).reject(_==0),il.sort.reverse[1]].flat.sort[0])).ceil.asInt};

			 iFunc.value;

			
			}.value;

		"i".post; i.postln;
		logTen = i.log10.ceil.asInt;
		i.factors.postln;
		w = ~w[0];

		n = ~n.value(i,il,ill);

		i.postln;
		~tempo = ((ill.sum/2).log2 / (ill.reverse[0] > 19).if({1.5},{1.25}));
		~tempo.postln;
		(z.peakCPU > 85).if({z.freeAll});

		r = Routine {
		i.factors.do({|p,j|
			var rr = Routine {
			p.log2.ceil.asInt.do({|k|
				var pp = i.factors[j].asInt;
				(1).ceil.asInt.do({|l|
					var s,freq;
					(p<~z.(i,il)).if({	s = Synth("just-sine");},{s = nil});
					p=p.nextPowerOfTwo;
						freq ={
						var qq,il2, ils, oc, js;
						il2 = (i.log2 - i.log2.floor);
						ils = (ill.sum*(il2**2));
						qq=[2,n.collect({|x|(2*x)/(x.nextPowerOfTwo)}).flat.permute(il.sort.reverse[1].asInt).wrapAt(ill.sort.reverse.wrapAt(1))].wrapAt(ill.sort.reverse[1].asInt );
						oc = [2**(j%(il2 * logTen).floor)].wrapAt(ill.reverse[0]);
						js = j * [(1+(ill.sort.reverse.wrapAt(i.factors.reverse[0].log2)))%2].wrapAt(ill.reverse[0]);
						((30/7)*(p *(2**((i.log10.floor+i.log2.floor+i.factors.size)%(i.log10.floor.asInt))).asInt *.x n.permute(i.factors.sum.asInt)[0..i.factors.reverse[0].log10.ceil.asInt].wrapAt(js+k) * qq *oc))
					}.value;
				
					//freq = (freq>128).if({freq * ((j+512)/512)},{freq});
					(freq > (2**13)).if({freq = freq / (2**( i.factors.size.clip(2,i.log10.floor.asInt)))});
					//(freq < (2**2)).if({freq = freq *4});
					s.set(\rz,~tempo/(2+i.factors.permute(i.asInt)[0].log2.ceil));
					s.set(\freq, freq);
					s.set(\zc, (freq/(2**il.reject(_!=0).size))* (5/7) * 3);
					s.set(\k, (16 - freq.log2.ceil.asInt).nextPowerOfTwo);
					s.set(\k2, (1/i.factors.permute(i.factors.reverse[0])[j]));				[
					{s.set(\rel,((1/(4+(i.log/19).floor))*((26+l)/(i.factors.permute(i.factors.reverse[0])[j]).log2.ceil)/i.log2)*~tempo);},
					
					{s.set(\rel,((i.factors.permute(i.factors.reverse[0])[j]).log2.ceil)*~tempo/i.log10);}
					
					].wrapAt(ill.sort.reverse.wrapAt(logTen+1)).value;
					

					s.set(\pan,(2/(i.factors[j])) * (-1**((ii+j)%5)));

					s.set(\atk,(1/(2**(i.factors[0].log10 + i.log2-(i.factors.size)))) / freq.log2);
					s.set(\sus,-1 * (10+i.factors.permute(i)[j]).log10);
					s.set(\gate,1);
					s.set(\amp,{
						var c1, c2;
						c1 = 3+ (i.log2-i.log2.floor);
						c2 = (10**(3+(i.log2-i.log2.floor)));
						((c1/((p+c2).log10))
						*((3/((p+(1000)).log10)) )
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
		(1/3).wait;	
};


~clock.play(~r,0);
z.scope;
