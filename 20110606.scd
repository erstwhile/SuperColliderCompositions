
(
~z = Server.internal.options;
~z.numBuffers_(16384);
(0..3).do({|i|
	var j = (16*i);
~synthFactory.("pitch-pendulum-16-5-"++i, {|f=72,a=12,p=#[1,1.5,2.5,3.375],t=512,w=0.5,tr=1,mr=1,mm=4,ma=4,m=1|
	var tRate,mRate,az;
	az = (1..16).collect({|k|
		var m; 
		k=k+i;
		m=(2048 / k.log2.ceil).asInt;
		(k.nextPowerOfTwo != k).if({k=(k * m).nextPrime},{k=k*m});
		k/m;
	});
	p=p*.x(((az))) * f;
	tRate = p/t;

	mRate = (1.5**LFSaw.kr(mr,0,mm,ma).ceil);
	(SinOsc.ar(p*m,0,(1/((p+4) * 10))*(LFPulse.kr(tRate * mRate * SinOsc.kr(mRate/(p/(1)),0,1,0).abs,0,SinOsc.kr(tRate * tr * mRate,0,1,0)+w,1,0) * a)))},{({|i|i=i+1; i/16}!16)*.x[-1,1]},Server.internal);
})
)
(
(0..3).do({|i|

~synthFactory.("pitch-pendulum-16-5-"++i, {|f=72,a=12,p=#[1,1.5,2.5,3.375],t=512,w=0.5,tr=1,mr=1,mm=4,ma=4,m=1|
	var tRate,mRate;
	p=p*.x(1..16) * f;
	tRate = p/t;
	mRate = (1.5**LFSaw.kr(mr,0,mm,ma).ceil);
	(SinOsc.ar(p*m,0,(1/((p+4) * p.log2))*(LFPulse.kr(tRate * mRate * SinOsc.kr(mRate/(p),0,1,0).abs,0,SinOsc.kr(tRate * tr * mRate,0,1,0)+w,1,0) * a)))},{({|i|i=i+1; i/16}!16)*.x[-1,1]},Server.internal);

})

)
(
~s = Synth("pitch-pendulum-16-5-0");
~s.set(\a,48);
~s.set(\atk,32);

~t = Synth("pitch-pendulum-16-5-0");
~t.set(\a,48);
~t.set(\atk,32);

~q = Synth("pitch-pendulum-16-5-1");
~q.set(\a,48);
~q.set(\atk,32);

~r = Synth("pitch-pendulum-16-5-1");
~r.set(\a,48);
~r.set(\atk,32);

Routine {
	inf.do({|i|
		~loop.(i.asInt);
	});	
}.play;

[~q,~r,~t,~s].collect({|i| i.set(\tr,1/128)});
[~q,~r,~t,~s].collect({|i| i.setn(\p,[1,3/2,9/4,27/8])});
[~q,~r,~t,~s].collect({|i| i.set(\t,80)});
[~q,~r,~t,~s].collect({|i| i.set(\f,80)});

~r.set(\m,(1.5**12)/128);
~t.set(\m,(1.5**12)/128);


~t.set(\a,48);
~q.set(\a,48);
~r.set(\a,48);

~r.set(\gate,1);
~q.set(\gate,1);
~t.set(\gate,1);
~s.set(\gate,1);

		[~q,~r,~s,~t].collect({|i|i.set(\tr,2048);});

//~t.set(\m,2401/2400);
//~r.set(\m,2401/2400);
)
(
~loop= {|i|
		var a = [-2,0,2,4,8].permute(i).wrapAt(i);
		var b = [-2,0,2,4,8].reverse.permute(i).wrapAt(i);
		i.postln;
		[~q,~r,~s,~t].collect({|i|i.set(\ma,-4);});
		[~q,~r,~s,~t].collect({|i|i.set(\mm,2);});
		[~q,~r,~s,~t].collect({|i|i.set(\mr,1/8);});
		//[~q,~r,~s,~t].collect({|j|j.set(\tr,1/(2**(i.ceil%16)));});
		[~q,~r,~s,~t].collect({|i|i.set(\tr,2048);});

		[~q,~r,~s,~t].collect({|j|
		j.setn(\p,[[1,3/2,5/2,27/8],[1,3/2,9/4,27/8],[1,3/2,8/3,27/8],[15/16,3/2,5/2,15/4],[9/8,4/3,27/8,4],[3/4,5/4,9/4,15/8],
[2/3,9/8,27/8,4],[3/4,5/4,2,9/2],[1,3/2,5/2,4]].wrapAt((i/256)+((i/16)%[4,6,3].permute((i/256).ceil.asInt).wrapAt(i/128))));
});
		[~q,~r,~s,~t].collect({|j|j.set(\w,[0.25,0.125,0,-0.125,-0.25,-0.5].permute(i).foldAt(i));});
		
		((i/[3,4,6,8].permute((i/16).ceil.asInt).wrapAt(i/8)).ceil.asInt.factors.size.nextPowerOfTwo/4).wait;
};
)

~loop= {|i|
		var a = [-2,0,2,4,8].permute(i).wrapAt(i);
		var b = [-2,0,2,4,8].reverse.permute(i).wrapAt(i);
		[~q,~r,~s,~t].collect({|i|i.set(\ma,a);});
		[~q,~r,~s,~t].collect({|i|i.set(\mm,8-b);});
		[~q,~r,~s,~t].collect({|i|i.set(\mr,1/(2**a));});
		[~q,~r,~s,~t].collect({|j|j.set(\tr,2**(11-((i/32).floor%24)));});

		[~q,~r,~s,~t].collect({|j|
		j.setn(\p,[[1,3/2,5/2,27/8],[1,3/2,9/4,27/8],[1,3/2,8/3,27/8],[15/16,3/2,5/2,15/4],[9/8,4/3,27/8,4],[3/4,5/4,9/4,15/8],
[2/3,9/8,27/8,4],[3/4,5/4,2,9/2],[1,3/2,5/2,4]].permute(i).wrapAt(i));
});
		[~q,~r,~s,~t].collect({|j|j.set(\w,[0.25,0.125,0,-0.125,-0.25].permute(i).wrapAt(i));});
		(1/(2**a)).wait;
};
