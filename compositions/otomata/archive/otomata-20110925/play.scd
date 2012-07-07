{|i,x|
		var il,ill,r,w,hf,jf,n,logTen,slope,totalSlope,t,fn;
		il = ({|x|((2**x)*(i/(2**x)%2).floor)}!i.log2.ceil.asInt);
		ill = (1+il).log2.floor;

		ill.postln;
		i=~iFunc.(i,il,ill, x);
		il = ({|x|((2**x)*(i/(2**x)%2).floor)}!i.log2.ceil.asInt);
		ill = (1+il).log2.floor;
		ill.postln;
		i.postln;
		logTen = i.log10.ceil.asInt;
		i.factors.postln;
		w = ~w[0];
		i.postln;
		t = x/512;
		totalSlope = ~fns.collect({|fn|(fn.(x)-fn.(x+1)).abs}).sum;
		r = Routine {
		i.factors.do({|p,j|
			var rr = Routine {
				fn = ~fns.wrapAt(j);
				slope = fn.(x+1)-fn.(x);
			
				((slope.abs+2).log).clip(1,4).do({|l|

				(1/(p+j+l).log2.ceil.nextPowerOfTwo).wait;
				(p.log2.ceil.asInt + il.reject(_!=0).size *2).clip(1,~k).do({|k|
				var pp = i.factors[j].asInt, s,freq,rel,atk,il2,kn;
					(~z.wrapAt(x+k).avgCPU > 80).if({~z.wrapAt(x+k).freeAll});
					p=~pFunc.( p );
					il2 = ((i).log2 - (i).log2.floor);
						freq ={
						var pitch,qq,slp,sls;
						slp=(slope>0).if({~pitches[0]},{~pitches[1]});
						slp = ~pitches.wrapAt(j);
						sls=(slope>0).if({-1},{1}); 
						pitch = fn.(x+k);
						// +( sls *(( k* slope).abs.ceil.asInt.factors.wrapAt(k)))
						(slp.wrapAt(pitch) + (k*l));
					}.value;

					freq = (freq >192).if({freq * ~jf.(i,j+l,k,x)},{freq});
					freq = ~pitchCorrect.(freq,k,i,p,j);
					s = Synth("just-sine",nil,~z.wrapAt(x+k+l));

					s.set(\freq, freq);
					rel =
					{((4/(4+(i.log2/19).floor))*((24-l)/pp.log2.ceil)/i.log10)*~tempo;}.value;
					s.set(\rel,rel / (1+l));
					s.set(\slope, slope);
					s.set(\pan,(((1/(i.factors.permute(x)[j].log2)) * (-1**((j+i.factors.size))))).clip(-1,1));
					s.set(\atk,0.01 + (rel) 
					* (x < 256).if({1/(9-(x+2).log2)},{1})
					* ((1/slope.abs.clip(0.33,4096))));
					s.set(\sus, -1 * ((slope.abs+10).log10));
					atk = 0.01 + (rel  * (1/(slope.abs)));
					s.set(\gate,1);
					s.set(\amp,{
						var c1, c2;
						c1 = 2 + (i.log2-i.log2.floor);
						c2 = (10**(2+(i.log2-i.log2.floor)));
						((c1/((p+c2).log10))
						*((1/((p+(6)).log10)) 
						* 0.020 * (2/(4+k+l).sqrt)) *
						(ill.reverse[0] > 14).if({(4 / (4+(l+k%i.factors.size.factors[0])))},{1})

						*(i.factors[j].sqrt.clip(1,(ill.reverse[0]**2)/(ill.reverse[0]+2).log2 )
						* (c1/(pp+c2).log10))) * 24 *(1000+(1/atk)).log10
					}.value);
					
				w.(i.factors[j],i,j,k,totalSlope).wait;
				});

				});

			};
			~clock.play(rr,0);
			});
		};
		~clock.play(r,0);
		([1/4].wrapAt(i.factors.size)).wait;
}
