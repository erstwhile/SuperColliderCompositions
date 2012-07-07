z =Server.internal;
~clock = TempoClock.new(1/2,0,0,1024);
~clock.tempo_(0.5 * 0.75);
SynthDef("just-sine",{|freq=100,freq2=50, atk=1, rel=1, sus=1, amp=0.005,pan =0,gate=0|
	Out.ar(0,Mix.ar(Pan2.ar(SinOsc.ar( XLine.ar(freq2, 1,sus.abs/freq) *freq * [1,1],0,amp),pan)) * EnvGen.ar(Env.perc(atk,rel, 1, sus),gate, doneAction:2) );}).load(z);

~tempo = 5;
~f = {|p,w,v,ffs=0,ffe=1,
	relf = ({|i,p,r,v,w|
	w = w*~tempo;
		(   (((i.factors[0] +v).isPrime).if({1},{0}) * (v.log2/~tempo)) +(~tempo * w.wrapAt(v + (i / v.log2).floor)))
		}),
	vol=1,
	susf = ({|i,p,v,w|
		w = w * ~tempo;
		-1 * (w.wrapAt(v + (i / v.log2).floor) * (v+3).log10)
		}),
	atkf = ({|i,p,v,w|
		(0.001 * (v+i).factors[0].log2);
		})
	wf =({|i,v,w|w.wrapAt(v + ((i%v.log) ).floor)})|
	var r = Routine {
	//p = p.stutter(2);

		(p.size).do({|i|
		var freq,ff,s,rel,ps, freq2,famp=1;
		
		ps = p.size.log.ceil.asInt;
		//i = ((v/64).floor.asInt.even).if({(i % v.factors.reverse[0].log2.ceil.asInt) + v.factors.reverse[0]},{i});
		s = Synth("just-sine");
			ff =
				{
					var e = 2, x1, x2, s1,s2,slope;
					x1 = (v*pi) / 16;
					x2 = ((v+1)*pi) /16;
					s1 = x1.sin;
					s2 = x2.sin;
					slope = (s1/s2)**3;		
					(i ** v.log10/v);
				};
			freq = ff.value;
			freq2 = p.wrapAt(freq+1);
			freq = p.wrapAt(freq);
			(freq < 90).if({},{});

			s.set(\freq,freq);
			(freq2 <= 0).if({freq2 = 2});
			s.set(\freq2,freq/freq2);
			s.set(\sus, susf.value(i,p,v,w));
			s.set(\atk,atkf.value(i,p,v,w));
			rel = relf.value(i,p,r,v,w);
			s.set(\rel, rel);
			s.set(\pan,(i / p.size) * (-1**(i)));
			s.set(\gate,1);
			s.set(\amp,(1/ ((10+rel).log10)) * famp * (2/(i%v.factors.reverse[0].log2.ceil.asInt+2))* vol * (freq.log2/(freq+120)) * 4 / (2+(i%v.log.floor.asInt)).log2);
		wf.value(i,v,w).wait;
		});
	v.postln;
	"done".postln;
	};
	r;
};

~xpost = 0;


~p =[
	[[1/2,1,2,3,5,9/2,4,6,8] , [1/2,1,3/2,2,9/2,3,4,6,8,12,16]],
	[[1/2,1,2,3,5,4,15/4,6,8] , [1/2,1,3/2,2,3,4,6,8,12,16]],
 	[[1/2,1,5/4,4/3,3/2,2,8/3,3,4,5,6,8],[1,2,3,4,6,8,12,16]],
	[[1/2,1,9/4,5/4,3/2,2,3,4,5,6,8],[1,2,3,4,6,8,12,16]],
	[[1/2,1,5/4,4/3,3/2,2,8/3,3,4,5,6,8],[1,2,3,4,6,8,12,16]],
 	[[1/2,1,2,4,8,16],[1/2,1,2,4,8,16]],
 	[[1/2,1,3/2,2,3,4,6,8],[1/2,1,2,4,6,8,12,16]],
 	[[1/2,1,2,3,22/9,9/2,15/4,6,8] , [1/2,1,121/80,2,9/4,121/40,6,9,18]],
	[[1/2,1,2,3,21/4,7/2,16/7,6,8] , [1/2,1,3/2,2,9/4,3,6,9,18]],
 	[[1/2,1,2,3,13/4,9/2,26/9,6,8] , [1/2,1,3/2,2,9/4,3,4,6,8,12,16]],
 	[[1/2,1,2,3,21/4,9/2,7/2,6,8] , [1/2,1,3/2,2,9/4,3,4,6,8,12,16]],
	[[1/2,1,2,3,24/5,9/2,4,6,8] , [1/2,1,3/2,2,9/2,3,4,6,8,12,16]],
	[[1/2,1,2,3,24/5,4,7/2,6,8] , [1/2,1,3/2,2,3,4,6,8,12,16]],
 	[[1/2,1,6/5,4/3,3/2,2,8/3,3,4,24/5,6,8],[1,2,3,4,6,8,12,16]],
	[[1/2,1,9/4,6/5,3/2,2,3,4,24/5,6,8],[1,2,3,4,6,8,12,16]],
	[[1/2,1,6/5,4/3,3/2,2,8/3,3,4,24/5,6,8],[1,2,3,4,6,8,12,16]],
 	[[1/2,1,2,4,8,16],[1/2,1,2,4,8,16]],
 	[[1/2,1,3/2,2,3,4,6,8],[1/2,1,2,4,6,8,12,16]],
 	[[1/2,1,2,3,24/9,9/2,15/4,6,8] , [1/2,1,3/2,2,9/4,3,6,9,18]],
	[[1/2,1,2,3,21/4,7/2,16/7,6,8] , [1/2,1,3/2,2,9/4,3,6,9,18]],
 	[[1/2,1,2,3,12/4,9/2,24/9,6,8] , [1/2,1,3/2,2,9/4,3,4,6,8,12,16]]
 	[[1/2,1,2,3,21/4,9/2,7/2,6,8] , [1/2,1,3/2,2,9/4,3,4,6,8,12,16]]] ;

 
~play = Routine{
	(2**16).asInt.do({|ww|
	var p,p2,s,r,t,u, www,wr,pp, tweak,wf, tweaker, w, pw;
	ww = (ww) + (2**16);
	w =  (ww/(ww.asInt.factors[0].log2)).floor.asInt;
	pw = (w /(w.factors[0] * w.log2));
	www = (w/(w.factors[0]* w.log10)).floor.asInt;
	(www < 1).if ({www = 1},{});
	pp= ~p.permute(www)[0..(www.log2.floor.asInt)];
	p = pp.reverse.permute(w.log2.floor.asInt).reverse.wrapAt(pw);
	

	p = (p[0] *.x p[1]).sort;
	p = p * ((0.5 * p).reject({|i|i>1.5}).reject({|i|i < 0.75}).permute(w).wrapAt(w/w.log));

	p = ((p * 128).reject({|i|i<30}).reject({|i|i>22050}));
	wr = [1,(({|i|i}!www.log2.floor.asInt) +1)].flat /(16);
	wr.postln;
	w.postln;
	u = ~f.value(p,wr,w);
	~clock.play(u,0);

	tweak = w /(w.nextPowerOfTwo /2);
	tweak = 1 /(wr.permute(w).wrapAt(w)*4);
	(tweak <= 0).if({tweak=1},{});
	tweaker = (w.factors[0])/(w.factors[0].nextPowerOfTwo / 2);
	(tweaker <=0).if({tweaker =1},{});
	(tweaker ==inf).if({tweaker = 1},{});
	(tweaker ==2).if({tweaker = 1},{});
	p = p.collect({|i|((i >120)).if({(i*tweaker)+tweak},{i})});

	t = ~f.value(p,wr,w);
	~clock.play(t,0);
	
	wf = 0;
	(p.size/w.log).floor.do({|i|
	wf = wf + (wr.wrapAt(w + ((i%w.log)).floor))
	});
	wf.postln;
	wf.wait;
	});
	
};
~clock.play(~play,0);
z.scope;

