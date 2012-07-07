Environment[ ('notesFunc' -> { |i,il,ill|
      var n = (12*[1,2,5/4,3/2,4,27/8,1] *.x[1,3/4,4/3,1,3/2,2/3]).permute(il.sort.reverse.wrapAt(ill.reverse.wrapAt(3)).asInt);
      n
}), ('a' -> [ [ 1, 1, 1, 1, 1, 1, 1, 1 ], [ 1, 1.5, 1.5, 2.25, 2.25, 3.375, 3.375, 5.0625 ], [ 1, 1.3125, 1.3125, 1.72265625, 1.72265625, 2.260986328125, 2.260986328125, 2.9675445556641 ], [ 1, 1.1428571428571, 1.1428571428571, 1.3061224489796, 1.3061224489796, 1.4927113702624, 1.4927113702624, 1.7059558517284 ], [ 1, 2.25, 2.25, 5.0625, 5.0625, 11.390625, 11.390625, 25.62890625 ], [ 1, 1.96875, 1.96875, 3.8759765625, 3.8759765625, 7.6308288574219, 7.6308288574219, 15.023194313049 ], [ 1, 1.7142857142857, 1.7142857142857, 2.9387755102041, 2.9387755102041, 5.0379008746356, 5.0379008746356, 8.6364014993753 ], [ 1, 1.72265625, 1.72265625, 2.9675445556641, 2.9675445556641, 5.1120591759682, 5.1120591759682, 8.8063206898514 ], [ 1, 1.3061224489796, 1.3061224489796, 1.7059558517284, 1.7059558517284, 2.2281872349106, 2.2281872349106, 2.9102853680465 ], [ 1.5, 1.5, 2.25, 2.25, 3.375, 3.375, 5.0625, 5.0625 ], [ 1.5, 2.25, 3.375, 5.0625, 7.59375, 11.390625, 17.0859375, 25.62890625 ], [ 1.5, 1.96875, 2.953125, 3.8759765625, 5.81396484375, 7.6308288574219, 11.446243286133, 15.023194313049 ], [ 1.5, 1.7142857142857, 2.5714285714286, 2.9387755102041, 4.4081632653061, 5.0379008746356, 7.5568513119534, 8.6364014993753 ], [ 1.5, 3.375, 5.0625, 11.390625, 17.0859375, 38.443359375, 57.6650390625, 129.74633789062 ], [ 1.5, 2.953125, 4.4296875, 8.720947265625, 13.081420898438, 25.754047393799, 38.631071090698, 76.054921209812 ], [ 1.5, 2.5714285714286, 3.8571428571429, 6.6122448979592, 9.9183673469388, 17.002915451895, 25.504373177843, 43.721782590587 ], [ 1.5, 2.583984375, 3.8759765625, 6.6769752502441, 10.015462875366, 17.253199718893, 25.879799578339, 44.581998492373 ], [ 1.5, 1.9591836734694, 2.9387755102041, 3.838400666389, 5.7576009995835, 7.5201319178234, 11.280197876735, 14.733319675736 ], [ 1.3125, 1.3125, 1.72265625, 1.72265625, 2.260986328125, 2.260986328125, 2.9675445556641, 2.9675445556641 ], [ 1.3125, 1.96875, 2.583984375, 3.8759765625, 5.0872192382812, 7.6308288574219, 10.015462875366, 15.023194313049 ], [ 1.3125, 1.72265625, 2.260986328125, 2.9675445556641, 3.8949022293091, 5.1120591759682, 6.7095776684582, 8.8063206898514 ], [ 1.3125, 1.5, 1.96875, 2.25, 2.953125, 3.375, 4.4296875, 5.0625 ], [ 1.3125, 2.953125, 3.8759765625, 8.720947265625, 11.446243286133, 25.754047393799, 33.802187204361, 76.054921209812 ], [ 1.3125, 2.583984375, 3.3914794921875, 6.6769752502441, 8.7635300159454, 17.253199718893, 22.644824631047, 44.581998492373 ], [ 1.3125, 2.25, 2.953125, 5.0625, 6.64453125, 11.390625, 14.9501953125, 25.62890625 ], [ 1.3125, 2.260986328125, 2.9675445556641, 5.1120591759682, 6.7095776684582, 11.55829590543, 15.170263375877, 26.1331490186 ], [ 1.3125, 1.7142857142857, 2.25, 2.9387755102041, 3.8571428571429, 5.0379008746356, 6.6122448979592, 8.6364014993753 ], [ 1.1428571428571, 1.1428571428571, 1.3061224489796, 1.3061224489796, 1.4927113702624, 1.4927113702624, 1.7059558517284, 1.7059558517284 ], [ 1.1428571428571, 1.7142857142857, 1.9591836734694, 2.9387755102041, 3.3586005830904, 5.0379008746356, 5.7576009995835, 8.6364014993753 ], [ 1.1428571428571, 1.5, 1.7142857142857, 2.25, 2.5714285714286, 3.375, 3.8571428571429, 5.0625 ], [ 1.1428571428571, 1.3061224489796, 1.4927113702624, 1.7059558517284, 1.9496638305468, 2.2281872349106, 2.5464996970407, 2.9102853680465 ], [ 1.1428571428571, 2.5714285714286, 2.9387755102041, 6.6122448979592, 7.5568513119534, 17.002915451895, 19.431903373594, 43.721782590587 ], [ 1.1428571428571, 2.25, 2.5714285714286, 5.0625, 5.7857142857143, 11.390625, 13.017857142857, 25.62890625 ], [ 1.1428571428571, 1.9591836734694, 2.2390670553936, 3.838400666389, 4.3867436187303, 7.5201319178234, 8.5944364775124, 14.733319675736 ], [ 1.1428571428571, 1.96875, 2.25, 3.8759765625, 4.4296875, 7.6308288574219, 8.720947265625, 15.023194313049 ], [ 1.1428571428571, 1.4927113702624, 1.7059558517284, 2.2281872349106, 2.5464996970407, 3.3260404206246, 3.8011890521424, 4.9648183538186 ], [ 2.25, 2.25, 5.0625, 5.0625, 11.390625, 11.390625, 25.62890625, 25.62890625 ], [ 2.25, 3.375, 7.59375, 11.390625, 25.62890625, 38.443359375, 86.49755859375, 129.74633789062 ], [ 2.25, 2.953125, 6.64453125, 8.720947265625, 19.622131347656, 25.754047393799, 57.946606636047, 76.054921209812 ], [ 2.25, 2.5714285714286, 5.7857142857143, 6.6122448979592, 14.877551020408, 17.002915451895, 38.256559766764, 43.721782590587 ], [ 2.25, 5.0625, 11.390625, 25.62890625, 57.6650390625, 129.74633789062, 291.92926025391, 656.84083557129 ], [ 2.25, 4.4296875, 9.966796875, 19.622131347656, 44.149795532227, 86.919909954071, 195.56979739666, 385.02803862467 ], [ 2.25, 3.8571428571429, 8.6785714285714, 14.877551020408, 33.474489795918, 57.384839650146, 129.11588921283, 221.34152436485 ], [ 2.25, 3.8759765625, 8.720947265625, 15.023194313049, 33.802187204361, 58.229549051262, 131.01648536534, 225.69636736764 ], [ 2.25, 2.9387755102041, 6.6122448979592, 8.6364014993753, 19.431903373594, 25.380445222654, 57.106001750971, 74.587430858411 ], [ 1.96875, 1.96875, 3.8759765625, 3.8759765625, 7.6308288574219, 7.6308288574219, 15.023194313049, 15.023194313049 ], [ 1.96875, 2.953125, 5.81396484375, 8.720947265625, 17.169364929199, 25.754047393799, 50.703280806541, 76.054921209812 ], [ 1.96875, 2.583984375, 5.0872192382812, 6.6769752502441, 13.145295023918, 17.253199718893, 33.96723694657, 44.581998492373 ], [ 1.96875, 2.25, 4.4296875, 5.0625, 9.966796875, 11.390625, 22.42529296875, 25.62890625 ], [ 1.96875, 4.4296875, 8.720947265625, 19.622131347656, 38.631071090698, 86.919909954071, 171.12357272208, 385.02803862467 ], [ 1.96875, 3.8759765625, 7.6308288574219, 15.023194313049, 29.576913803816, 58.229549051262, 114.63942469467, 225.69636736764 ], [ 1.96875, 3.375, 6.64453125, 11.390625, 22.42529296875, 38.443359375, 75.685363769531, 129.74633789062 ], [ 1.96875, 3.3914794921875, 6.6769752502441, 11.502133145928, 22.644824631047, 39.009248680826, 76.799458340377, 132.29906690666 ], [ 1.96875, 2.5714285714286, 5.0625, 6.6122448979592, 13.017857142857, 17.002915451895, 33.474489795918, 43.721782590587 ], [ 1.7142857142857, 1.7142857142857, 2.9387755102041, 2.9387755102041, 5.0379008746356, 5.0379008746356, 8.6364014993753, 8.6364014993753 ], [ 1.7142857142857, 2.5714285714286, 4.4081632653061, 6.6122448979592, 11.33527696793, 17.002915451895, 29.147855060391, 43.721782590587 ], [ 1.7142857142857, 2.25, 3.8571428571429, 5.0625, 8.6785714285714, 11.390625, 19.526785714286, 25.62890625 ], [ 1.7142857142857, 1.9591836734694, 3.3586005830904, 3.838400666389, 6.5801154280954, 7.5201319178234, 12.891654716269, 14.733319675736 ], [ 1.7142857142857, 3.8571428571429, 6.6122448979592, 14.877551020408, 25.504373177843, 57.384839650146, 98.374010828821, 221.34152436485 ], [ 1.7142857142857, 3.375, 5.7857142857143, 11.390625, 19.526785714286, 38.443359375, 65.902901785714, 129.74633789062 ], [ 1.7142857142857, 2.9387755102041, 5.0379008746356, 8.6364014993753, 14.805259713215, 25.380445222654, 43.509334667407, 74.587430858411 ], [ 1.7142857142857, 2.953125, 5.0625, 8.720947265625, 14.9501953125, 25.754047393799, 44.149795532227, 76.054921209812 ], [ 1.7142857142857, 2.2390670553936, 3.838400666389, 5.0134212785489, 8.5944364775124, 11.225386419608, 19.243519576471, 25.134392916207 ], [ 1.72265625, 1.72265625, 2.9675445556641, 2.9675445556641, 5.1120591759682, 5.1120591759682, 8.8063206898514, 8.8063206898514 ], [ 1.72265625, 2.583984375, 4.4513168334961, 6.6769752502441, 11.502133145928, 17.253199718893, 29.721332328249, 44.581998492373 ], [ 1.72265625, 2.260986328125, 3.8949022293091, 5.1120591759682, 8.8063206898514, 11.55829590543, 19.910970680838, 26.1331490186 ], [ 1.72265625, 1.96875, 3.3914794921875, 3.8759765625, 6.6769752502441, 7.6308288574219, 13.145295023918, 15.023194313049 ], [ 1.72265625, 3.8759765625, 6.6769752502441, 15.023194313049, 25.879799578339, 58.229549051262, 100.30949660784, 225.69636736764 ], [ 1.72265625, 3.3914794921875, 5.8423533439636, 11.502133145928, 19.814221552166, 39.009248680826, 67.19952604783, 132.29906690666 ], [ 1.72265625, 2.953125, 5.0872192382812, 8.720947265625, 15.023194313049, 25.754047393799, 44.365370705724, 76.054921209812 ], [ 1.72265625, 2.9675445556641, 5.1120591759682, 8.8063206898514, 15.170263375877, 26.1331490186, 45.018432489073, 77.551284092505 ], [ 1.72265625, 2.25, 3.8759765625, 5.0625, 8.720947265625, 11.390625, 19.622131347656, 25.62890625 ], [ 1.3061224489796, 1.3061224489796, 1.7059558517284, 1.7059558517284, 2.2281872349106, 2.2281872349106, 2.9102853680465, 2.9102853680465 ], [ 1.3061224489796, 1.9591836734694, 2.5589337775927, 3.838400666389, 5.0134212785489, 7.5201319178234, 9.822213117157, 14.733319675736 ], [ 1.3061224489796, 1.7142857142857, 2.2390670553936, 2.9387755102041, 3.838400666389, 5.0379008746356, 6.5801154280954, 8.6364014993753 ], [ 1.3061224489796, 1.4927113702624, 1.9496638305468, 2.2281872349106, 2.9102853680465, 3.3260404206246, 4.3442160595913, 4.9648183538186 ], [ 1.3061224489796, 2.9387755102041, 3.838400666389, 8.6364014993753, 11.280197876735, 25.380445222654, 33.149969270405, 74.587430858411 ], [ 1.3061224489796, 2.5714285714286, 3.3586005830904, 6.6122448979592, 8.6364014993753, 17.002915451895, 22.207889569822, 43.721782590587 ], [ 1.3061224489796, 2.2390670553936, 2.9244957458202, 5.0134212785489, 6.5481420781047, 11.225386419608, 14.661729201121, 25.134392916207 ], [ 1.3061224489796, 2.25, 2.9387755102041, 5.0625, 6.6122448979592, 11.390625, 14.877551020408, 25.62890625 ], [ 1.3061224489796, 1.7059558517284, 2.2281872349106, 2.9102853680465, 3.8011890521424, 4.9648183538186, 6.4846607070284, 8.4697609234657 ] ]), ('migratory' -> {|i,il,ill,n,j,k,l,p,pp|
var qq, id, ss, a, r; 
qq=[2,n.collect({|x|(2*x)/(x.nextPowerOfTwo)}).flat.wrapAt(ill.sort.reverse.wrapAt(i.factors.reverse[0]).asInt.factors[0])].wrapAt(ill.sort.reverse[1]);
qq = qq * (n.collect({|x|(2*x)/(x.nextPowerOfTwo)}).wrapAt(ill.reverse[0].asInt.factors[0]));
a = ~atkFunc.value(i, ill, (k+l), j, pp);
(a.isNumber).if ({a=a},{a=1});
r = ~relFunc.value(i, ill, p, pp,0);
(r.isNumber).if ({r=r},{r=1});

((a + r)>40).if({
  ss = Synth("medium-drone",nil,Server.local);
  ss.setn(\p,[1,2,3,4].permute(i+j+l));
  ss.setn(\n,n[0..6]/12);
  ss.set(\m,[1].wrapAt(l+j));
  (64*qq < 32).if ({ss.set(\freq,128)},{ss.set(\freq,[128,64].wrapAt(l)*qq)});
  ss.set(\atk,r);
  ss.set(\rel,r);
  ss.set(\x,k+l);
  ss.set(\amp,1);
  ss.set(\of,0);
  ss.set(\gate,1);
  id = ss.nodeID;
  ~running.put(id,true);
  id.postln;
  a.postln;
  r.postln;
  ~running.postln;

  ~clock.play(Routine {
    "hi".postln;
    (4*r).wait;
    ss.set(\gate,0);
    (2*r).wait;
    "ho".postln;
    ~running.removeAt(id);
    ss.free;
  },0);
});

}), ('j' -> {
	[[13,1],
	[1,45],[9,45],[16,45], [72,25],[2,5],
	[19,18],[24,25], [25,3],
	[13,371],[12,45],[7,45],[5,18],[33,19], 
  [37,372],[39, 3.5],[43,134],[48,18],
  [55,3],[57,19],
  [60,45], [64,45],[66,45], [69,22],  [65,4.5],[76,25], [80,25] ]

}), ('initRoutine' -> {
  z = Server.default;

  ~clock = TempoClock.new(1/2,0,0,16384);
  ~clock.tempo_(1/3);
  ~tempo = 5/8;
  z.freeAll;
  ~i = 0;


  ~r = Routine {
    //~drone.();
  //4.wait;
  1.do({|n|  
    var a;
    a = (2**(n +12)).asInt;
    ~i =a;
    (512).asInt.do({|x|
        var i=~i;
        ~play.value(a+i.asInt,x.asInt);
        ~i = ~incrementFunc.value(i.asInt,a,n);
        {~iX.string = x;}.defer;
      });
    });
  240.wait;
  z.freeAll;
  };
  OSCresponderNode.removeAddr(nil);
  ~n = OSCresponderNode(nil,"/n_end",{|time,responder,msg| ~running.removeAt(msg[1]);}).add;
  //set up a responder node when new code is pushed
  
  ~running = Dictionary.new;
  ~unique = {|a|var t = Array.fill(a.size);
  a.collect({|i,j|(t.includes(i)).if({t.put(j,nil)}, {t.put(j,a[j])})}).reject({|i|i==nil});
  t.reject({|i|i==nil});
  };
  
}), 
  ('atkFunc' -> {|i, ill, k, j,l, pp|
  (1/(2**ill.permute(i.asInt).wrapAt(k+l+j).asInt))*((1/(2**j)) * (i.factors[j].sqrt*pp.log) * (1/(i.log*2)));
}), ('mylib' -> SynthDescLib.new), ('incrementFunc' -> {|i,d,n|
  (i+(2**4)).asInt;
}), ('unique' -> {|a|var t = Array.fill(a.size);
  a.collect({|i,j|(t.includes(i)).if({t.put(j,nil)}, {t.put(j,a[j])})}).reject({|i|i==nil});
  t.reject({|i|i==nil});
  }), ('susFunc' -> {|i,j,k,l|
   -4 * i.factors.wrapAt(j+i).sqrt;
}), 
  ('notesfunc' -> { |i,il,ill|
      var n = (12*[1,2,5/4,3/2,4,27/8,1] *.x[1,3/4,4/3,1,3/2,2/3]).permute(il.sort.reverse.wrapAt(ill.reverse.wrapAt(3)).asInt);
      n
}), ('relFunc' -> {|i, ill, p, pp,l| 
    [
      {((5/(4+(i.log/16).floor))*((24+l)/(1+pp).log)/i.log)*~tempo;}    ].wrapAt(ill.reverse.wrapAt(i.log10.ceil+1)).value;
}), ('pitchFunc' -> {|i, il, ill, p, j, k, x, n, l|
  var js;
//  ~p.set(\of,ill.reject(_==0).size);
//  ~p.set(\x,ill.reject(_==0).size);
  js = j * [(1+(ill.sort.reverse.wrapAt(i.factors.reverse[0].log2)))%2].wrapAt(ill.reverse[0]);

  ((8/8)*(p *(2**((i.log10.floor+i.log2.floor+i.factors.size)%(i.log10.floor.asInt))) *.x n[0..i.factors.reverse[0].log10.ceil.asInt.clip(1,32)].wrapAt((js+l))* 2) * 
   [(l.nthPrime / l.nthPrime.nextPowerOfTwo),1/(l.nthPrime / l.nthPrime.nextPowerOfTwo)].permute(ill.reverse[0].asInt).wrapAt(ill.sort.reverse[4].asInt.factors.reverse[0])    );
}), ('archive' -> {|f,completeAction=({"done".postln;})|
var path,a;
path = ~path++f.asString;
//create the temp dir
Routine {
Pipe.new("mkdir "++path,"w");
0.1.wait;

Pipe.new("chmod -R 777 "++path,"w");
0.1.wait;

a=File(path++"/_keys.scd","w");
a.write(currentEnvironment.keys.asCompileString.asString);
a.close;
0.1.wait;
{a=File(path++"/_currentEnvironment.scd","w");
a.write(currentEnvironment.asCompileString.asString);
a.close;}.defer;
0.1.wait;

currentEnvironment.keys.do({|x|
  ((currentEnvironment.at(x).isFunction).or(currentEnvironment.at(x).isArray)).if({
    currentEnvironment.at(x).writeArchive(path++"/"++x.asString++".scd");
    0.1.wait;
  })
});
completeAction.();
}.play;
}), ('kFunc' -> {|i,il,ill,j,p|
 ((( ill.reject(_==0).size **2)).ceil.asInt -1)
}), 
  ('genSynthdef' -> {
	
  ~allServers = [Server.local,Server.internal];	

~allServers.collect({|x|  
  ~synthFactory.("big-drone1",{|freq=120, n=#[1,2,3,4,5,6], p=#[0.5,0.66,1,2,3,4],x=3,of=4, ra=3,tt=1|
	  var a=p *.x n,
  	f=a*freq,
  	b=SinOsc,
  	c=FSinOsc,
  	r=b.ar(1/f,c.ar(tt,of/a,of/a,0).tanh,c.ar(1/f.reverse,0,x,x));
	b.ar(PinkNoise.ar(f.log2,f) ,Blip.ar(PinkNoise.ar(r.sum**(f.log2 / 8192.log2),f),x,pi*b.ar(1/f,r,r)),((b.ar((r+r.sum).abs.sqrt/ra,r,2,2)**3)/f)*b.ar(a,b.ar(r.sum,r,pi*b.ar(1/a,r.sum,b.ar(1/a,r,a))),r/x,0))},{[-1,1]/(1..6)},x);


  ~synthFactory.("big-drone",{|freq=120, n=#[1,2,3,4,5,6], p=#[0.5,0.66,1,2,3,4],x=3,of=4, ra=3,tt=1|
	  var a=p *.x n,
  	f=a*freq,
  	b=SinOsc,
  	c=FSinOsc,
  	r=b.ar(1/f,c.ar(tt,of/a,of/a,0).tanh,c.ar(1/f.reverse,0,x,x));
	b.ar(PinkNoise.ar(f.log2,f) ,Blip.ar(PinkNoise.ar(f.log2,f),x,pi*b.ar(1/f,r,r)),((b.ar((r+r.sum).abs.sqrt/ra,r,2,2)**3)/f)*b.ar(a/p,b.ar(a,r,pi*b.ar(1/a,r.sum,b.ar(1/a,r,a))),r/x,0))},{[-1,1]/(1..6)},x);
});


}), ('restore' -> {|f|
  var path = ~path ++f, keys,file;
  keys = Object.readArchive(path++"/_keys.scd");
  keys.postln;
  keys.asArray.do({|key|
    file = path++"/"++key++".scd";
    (File.exists(file)).if({currentEnvironment.put(key.asSymbol,Object.readArchive(file));
    });
  })
}), ('waitFunc' -> {|i,il,ill|
  {|pp,i| pp.log2.ceil/[2,3].wrapAt(i.factors.sum)/(2**4) }
}), ('lFunc' -> {|i,il,ill,j,k,p|
(8 - (Server.default.numSynths.log.floor.asInt)).clip(1,5);

}), ('restoreFull' -> {|f|
  var path = ~path ++f, keys,file;
  Object.readArchive(path++"/_currentEnvironment.scd");
}), 
  ('z' -> 1857.1958539773), ('refresh' -> {|f|
  ~archive.(f,~restore.(f));
}), ('running' -> [  ]), ('freqs' -> {|j|[[(1.5**12),128],[121,120]].wrapAt(j)}), ('initGui' -> {~panel = GUI.window.new("Values",Rect(128,64,420,420));
~panel.view.decorator = FlowLayout(~panel.view.bounds);
~panel.view.background = Color(0.7,0.7,0.7);
~iB =  TextField(~panel, Rect(150, 10, 300, 20));
~iF =  TextField(~panel, Rect(150, 10, 300, 20));
~iT =  TextField(~panel, Rect(150, 10, 300, 20));
~iI =  TextField(~panel, Rect(150, 10, 300, 20));
~iFils =  TextField(~panel, Rect(150, 10, 300, 20));
~iIll =  TextField(~panel, Rect(150, 10, 300, 20));
~iX = TextField(~panel, Rect(150, 10, 300, 20));
~iFac =TextField(~panel, Rect(150, 10, 300, 20));
~iCPU = TextField(~panel, Rect(150, 10, 300, 20));
~panel.front;
~controls = GUI.window.new("Controls",Rect(128,64,420,420));
~start = Button(~controls,Rect(20,20,340,30)).states_([
  ["Start Sequence",Color.green,Color.black],
  ["Stop Sequence",Color.red,Color.black]
  ])
  .action_({
    |b|
      [{b.value.postln;
        Server.default.freeAll;
        ~clock.stop;~clock.clear;},
      {~r.reset();~run.()}
      ].wrapAt(b.value).value;
  });
~controls.front;
}), 
  ('pFunc' -> {|ill, ils, p|
  p=p.nextPowerOfTwo;
  (p > (ils**ill.reverse[1])).if({p =p /(2**((ill.reverse[0]/2).ceil.asInt))});    
  (p <2).if ({2},{p});
}), ('pitchCorrect' -> {|f,s=1|
	(f < (2**14)).or(s>20).if ({f;},{ ~pitchCorrect.(f / (2**((f.log2.floor)/2).ceil),s+1);});
}), ('allServers' -> [ Server.fromName('localhost'), Server.fromName('internal') ]), ('run' -> {
  Server.default.freeAll;
  ~initRoutine.();
  ~clock.play(~r,0);
}), ('synthFactory' -> {|name, func,pan,l|
	SynthDef(name, {|gate =0, atk=18, rel=10,amp=1|
	var out;
	out = SynthDef.wrap(func);
		Out.ar(0,Mix.ar(Pan2.ar(out * amp,pan.value)) * EnvGen.ar(Env.asr(atk, 1, rel, 'linear'),gate, doneAction:2))
	}).load(l)
}), 
  ('ampFunc' -> {|i,p,pp,l,k|
      var c1, c2,out;
      c1 = 2 + (i.log2-i.log2.floor);
      c2 = (10**(2+(i.log2-i.log2.floor)));

      out = ((c1/((p+c2).log10))
      *((1/((p+(3)).log)))
      * 4 * (1/(l+3).log) * ((k+1).log10)
      * (i.factors.wrapAt(k).log2)
      *(p.sqrt 
      * (c1/(pp+c2).log10)));
      out.clip(0.01,16);
}), ('panFunc' -> {|i, j, ii,k,l,x|     ((1/(i.factors.size)) *(-1**(i.factors.size+j+l+k+x))+ ((1/(k+2).log2) *(-1 **(j+l)) )).clip(-1,1)    }), ('drone' -> {
~i = [1,3/2,21/16,8/7];
~i = ~unique.(~i *.x ~i);
~a = Array.fill(~i.size**2);
~i.collect({|x,a|
  ~i.collect({|y,b|
    var p=1,n=Array.fill(8);
    8.do({|z|
      p=p*[x,y].wrapAt(z);
      n.put(z,p);
    });
    ~a.put(b+(a*~i.size),n);
  });
});
~z = 0;
~score =[];
~running = [];
~freqs = [[(1.5**12),128],[121,120]];
~a.size.postln;
  Routine {
    var k = ~j.();
    k.collect({|l|
      var o, q,t,tt,j,freq;
      j=l[0];
      freq = ~freqs.wrapAt(j/35);
      p = ~a.wrapAt(j);
      p = (p.reject(_ > 8) *.f [1,1,1,1,1,1,1,1]);
      t = (1.5 - (p[0..1].wrapAt(j)*pi).sin);
      tt=(p[0..1].wrapAt(j)**[1,2,1,2,1]).sum**t;
      tt = (tt / (2**(tt.log10))); 
      j.postln;
      p.collect({|x|Rational(x)}).postln;
      (1/tt.log10).wait;
      o= Synth.new("big-drone1",\target,[Server.internal,Server.local].wrapAt(j+1));
      o.setn(\p,(p[0..5]/128).reverse);
      o.setn(\n,p[0..1]**[1,2,3,4,5,6]/(p[0..1]**3));
      o.set(\freq,(freq[1]*128));
      o.set(\amp,1/4);
      q= Synth.new("big-drone1",\target,[Server.internal,Server.local].wrapAt(j));
      q.setn(\p,(p[0..5]/128));
      q.setn(\n,p[0..1]**[1,2,3,4,5,6]/(p[0..1]**3));
      q.set(\freq,freq[1]* 128);
      q.set(\amp,1/4);
      [q,o].collect({|d,i|d.set(\x,p.wrapAt(j) + (pi * p.wrapAt(j)).sin)});
      (p.wrapAt(j) + (pi * p.wrapAt(j)).sin).postln;
      [q,o].collect({|d,i|d.set(\ra,p[0..1].wrapAt(j)**6)});
      [q,o].collect({|d,i|d.set(\tt,(p[0]/(tt)))});
      [q,o].collect({|d,i|d.set(\rel,tt.log10)});
      [q,o].collect({|d,i|d.set(\atk,1/tt.log10)});
      [q,o].collect({|d,i|d.set(\of,p.wrapAt(j)*pi)});
      [q,o].collect({|d,i|d.set(\gate,1)});
      (tt).postln;
      (tt).wait;
      ~z = ~z+tt;
//      ~running.add([q,o]);
      ~running.postln;
     // ~score.add(Dictionary("duration",tt,"j",j,"x",p.wrapAt(j) + (pi * p.wrapAt(j)).sin,"freq",[128,(1.5**12)]));
      [q,o].collect({|d,i|d.set(\gate,0)});
      (tt.log10).wait;
      (1/tt.log10).wait;
    });
  }.play;
}), ('i' -> [ 1, 1.5, 1.3125, 1.1428571428571, 2.25, 1.96875, 1.7142857142857, 1.72265625, 1.3061224489796 ]), ('countingFunc' -> {|i, il, ill|
  var ils = 2-(i.log2-i.log2.floor),fils,iFunc, il2 = (i.log2-i.log2.floor), lt,f=0;
  lt = ill.sort.reverse[1].asInt.factors.reverse[0];
  {~iF.string = "il2"+il2; ~iFils.string = lt;  ~iB.string = ill.sum; ~iT.string = "test: "+((ill.sum**il2)*il2)}.defer;
  f=(((ill.sum**il2)*il2) > lt).if({0},{1});
  [
  {
    fils = {|ff,l|
      var r=ff;
      l.do({
      r=r**ff;
      });
      //clip r
      r.clip(0,i.log2.ceil.asInt).floor;
    };

    ill.sort.reverse[1].asInt.factors.reverse[0].do({|x|
      (fils.(ils,x));
      });
      {((ill.sort.reverse[1].asInt.factors.reverse[0].collect({|x|i%  
        il.sort.flat.reverse.wrapAt(fils.(ils,x))}).sum)).ceil.asInt}.value;
  }, 
  { 
    ( il.sort.reverse[0] + il.reverse[1] + il.sort.reverse.wrapAt(i.log10-1) 
    +(i%il.sort.reverse.wrapAt(i.log10+1))+ (i%il.sort.reverse.wrapAt(i.log10-2))).ceil.asInt;
  }].permute(ill.reverse[0].asInt).wrapAt(f).value.asInt;
}), 
  ('path' -> "/Users/thomasgillis/dev/supercollider/sc/scd/compositions/continuation_and_closure/archive/"), ('play' -> {|i,x|
    var il,ill,r,ii,w,e,ils;
    ils = 2-(i.log2-i.log2.floor);
    (i< 2).if ({i=2},{i=i});
    ii=i;
    il = ({|x|((2**x)*(i/(2**x)%2).floor)}!i.log2.ceil.asInt);
    il = (il==[0]).if({[2]},{il});
    ill = (1+il).log2.floor;
    ill = (ill==[0]).if({[2]},{ill});
    e = Environment.make({~i = i; ~il = il; ~ill = ill;~x=x; });
    e.know = true;
    e.ils = ils;
    e.ii = i;
    i= ~countingFunc.valueWithEnvir(e);
    e.i = i;
//    il = ({|x|((2**x)*(i/(2**x)%2).floor)}!i.log2.ceil.asInt);
//    ill = (1+il).log2.floor;
    {~iIll.string = ill;}.defer;
    e.il = il;
    e.ill = ill;
    {~iI.string = i;}.defer;
    {~iFac.string = i.factors}.defer;
    e.hf = (i.factors.reverse[0].nextPowerOfTwo**3);
    w = ~waitFunc.valueWithEnvir(e);
    e.n = ~notesFunc.valueWithEnvir(e);
    ~tempo = ((e.ill.sum/2).log2)/5;

    r = Routine {
      i.factors.do({|p,j|
        var rr;
        e.p =p; e.j =j;
        rr = Routine {
        (~kFunc.valueWithEnvir(e)).do({|k|
          e.k = k;
          e.pp = i.factors[j];

          (~lFunc.valueWithEnvir(e)).do({|l|
            var s,freq,pitchCorrect;
              s = Synth("just-sine");          
            e.l =l; e.p = p;

            p=~pFunc.valueWithEnvir(e);
            e.l =l; e.p = p;

            freq = ~pitchFunc.valueWithEnvir(e);
            e.freq = freq;
            freq = ~harmonicFunc.valueWithEnvir(e);

            pitchCorrect = {|f,i,safe|
              f=f.abs;
              (f < (2**14)).or(safe >20).if ({f=f;},{ f=pitchCorrect.(f / (2**( i.factors.size.clip(2,i.log.floor.asInt))),i,safe+1);});
              f;
            };
            
            freq = pitchCorrect.(freq,i,0);
            pitchCorrect = {|f,i,safe|
              f=f.abs;
              (f > 48).or(safe>20).if ({ f=f; },{ f= pitchCorrect.(f  * (16),i,safe+1);});
              f;
            };
            freq = pitchCorrect.(freq,i,0);

            s.set(\freq, freq);
            s.set(\rel, ~relFunc.valueWithEnvir(e));
            s.set(\pan,~panFunc.valueWithEnvir(e));
            s.set(\atk, ~atkFunc.valueWithEnvir(e));
            s.set(\sus, ~susFunc.valueWithEnvir(e));
            s.set(\bassCutoff, 64);            
            s.set(\gate,1);
            s.set(\amp,~ampFunc.valueWithEnvir(e)); 
            (~running.size < 1).if ({
              //~migratory.valueWithEnvir(e);
            });

           });
          w.(i.factors[j],i).wait;
        });
      };
      ~clock.play(rr,0);
      });
    };
    ~clock.play(r,0);
    (1/2).wait;
}), ('hf' -> {|i,ill|(i.factors.reverse[0].nextPowerOfTwo**2);}), ('harmonicFunc' -> {|i, il, j, freq, hf,x,mod,k,l|
   freq * (((1024..1040) / 1024).permute(i).wrapAt(k+l) + (((1..8)*2)-1).permute(i).wrapAt(j));
}), ('score' -> [  ]) ]