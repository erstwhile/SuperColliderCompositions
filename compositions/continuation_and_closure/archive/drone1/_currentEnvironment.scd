Environment[ ('notesFunc' -> { |i,il,ill|
      var n = (12*[1,2,5/4,3/2,4,27/8,1] *.x[1,3/4,4/3,1,3/2,2/3]).permute(il.sort.reverse.wrapAt(ill.reverse.wrapAt(3)).asInt);
      n
}), ('iB' -> SCTextField.new), ('migratory' -> {|i,il,ill,n,j,k,l,p,pp|
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

}), ('iFils' -> SCTextField.new), ('initRoutine' -> {
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
  ('mylib' -> SynthDescLib.new), ('iT' -> SCTextField.new), ('iI' -> SCTextField.new), ('unique' -> {|a|var t = Array.fill(a.size);
  a.collect({|i,j|(t.includes(i)).if({t.put(j,nil)}, {t.put(j,a[j])})}).reject({|i|i==nil});
  t.reject({|i|i==nil});
  }), ('susFunc' -> {|i,j,k,l|
   -4 * i.factors.wrapAt(j+i).sqrt;
}), 
  ('iCPU' -> SCTextField.new), ('kFunc' -> {|i,il,ill,j,p|
 ((( ill.reject(_==0).size **2)).ceil.asInt -1)
}), ('q' -> Synth.new), ('lFunc' -> {|i,il,ill,j,k,p|
(8 - (Server.default.numSynths.log.floor.asInt)).clip(1,5);

}), ('restoreFull' -> {|f|
  var path = ~path ++f, keys,file;
  Object.readArchive(path++"/_currentEnvironment.scd");
}), 
  ('refresh' -> {|f|
  ~archive.(f,~restore.(f));
}), ('initGui' -> {~panel = GUI.window.new("Values",Rect(128,64,420,420));
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
}), ('start' -> SCButton.new), ('panFunc' -> {|i, j, ii,k,l,x|     ((1/(i.factors.size)) *(-1**(i.factors.size+j+l+k+x))+ ((1/(k+2).log2) *(-1 **(j+l)) )).clip(-1,1)    }), ('controls' -> SCWindow("Controls", Rect(2258.0, 346.0, 420.0, 420.0)).front;), 
  ('countingFunc' -> {|i, il, ill|
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
}), ('path' -> "/Users/thomasgillis/dev/supercollider/sc/scd/compositions/continuation_and_closure/archive/"), ('iX' -> SCTextField.new), ('a' -> [ [ 1.2, 1.3333333333333, 1.6, 1.7777777777778, 2.1333333333333, 2.3703703703704, 2.8444444444444, 3.1604938271605 ], [ 1.2, 1.5, 1.8, 2.25, 2.7, 3.375, 4.05, 5.0625 ], [ 1.2, 1.7142857142857, 2.0571428571429, 2.9387755102041, 3.5265306122449, 5.0379008746356, 6.0454810495627, 8.6364014993753 ], [ 1.2, 2.0, 2.4, 4.0, 4.8, 8.0, 9.6, 16.0 ], [ 1.2, 1.35, 1.62, 1.8225, 2.187, 2.460375, 2.95245, 3.32150625 ], [ 1.2, 1.5428571428571, 1.8514285714286, 2.3804081632653, 2.8564897959184, 3.6726297376093, 4.4071556851312, 5.6663430237401 ], [ 1.2, 1.8, 2.16, 3.24, 3.888, 5.832, 6.9984, 10.4976 ], [ 1.2, 2.16, 2.592, 4.6656, 5.59872, 10.077696, 12.0932352, 21.76782336 ], [ 1.2, 1.3714285714286, 1.6457142857143, 1.8808163265306, 2.2569795918367, 2.5794052478134, 3.0952862973761, 3.5374700541441 ], [ 1.2, 1.6, 1.92, 2.56, 3.072, 4.096, 4.9152, 6.5536 ], [ 1.2, 1.92, 2.304, 3.6864, 4.42368, 7.077888, 8.4934656, 13.58954496 ], [ 1.2, 1.4, 1.68, 1.96, 2.352, 2.744, 3.2928, 3.8416 ], [ 1.2, 1.68, 2.016, 2.8224, 3.38688, 4.741632, 5.6899584, 7.96594176 ], [ 1.2, 2.1, 2.52, 4.41, 5.292, 9.261, 11.1132, 19.4481 ], [ 1.2, 1.44, 1.728, 2.0736, 2.48832, 2.985984, 3.5831808, 4.29981696 ] ]), ('clock' -> TempoClock.new), 
  ('iFac' -> SCTextField.new), ('atkFunc' -> {|i, ill, k, j,l, pp|
  (1/(2**ill.permute(i.asInt).wrapAt(k+l+j).asInt))*((1/(2**j)) * (i.factors[j].sqrt*pp.log) * (1/(i.log*2)));
}), ('incrementFunc' -> {|i,d,n|
  (i+(2**4)).asInt;
}), ('notesfunc' -> { |i,il,ill|
      var n = (12*[1,2,5/4,3/2,4,27/8,1] *.x[1,3/4,4/3,1,3/2,2/3]).permute(il.sort.reverse.wrapAt(ill.reverse.wrapAt(3)).asInt);
      n
}), ('qq' -> Synth.new), 
  ('relFunc' -> {|i, ill, p, pp,l| 
    [
      {((5/(4+(i.log/16).floor))*((24+l)/(1+pp).log)/i.log)*~tempo;}    ].wrapAt(ill.reverse.wrapAt(i.log10.ceil+1)).value;
}), ('iF' -> SCTextField.new), ('pitchFunc' -> {|i, il, ill, p, j, k, x, n, l|
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
  (currentEnvironment.at(x).isFunction).if({
    currentEnvironment.at(x).writeArchive(path++"/"++x.asString++".scd");
    0.1.wait;
  })
});
completeAction.();
}.play;
}), ('restore' -> {|f|
  var path = ~path ++f, keys,file;
  keys = Object.readArchive(path++"/_keys.scd");
  keys.postln;
  keys.asArray.do({|key|
    file = path++"/"++key++".scd";
    (File.exists(file)).if({currentEnvironment.put(key.asSymbol,Object.readArchive(file));
    });
  })
}), 
  ('waitFunc' -> {|i,il,ill|
  {|pp,i| pp.log2.ceil/[2,3].wrapAt(i.factors.sum)/(2**4) }
}), ('running' -> Dictionary[  ]), ('r' -> Routine({
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
  })), ('pFunc' -> {|ill, ils, p|
  p=p.nextPowerOfTwo;
  (p > (ils**ill.reverse[1])).if({p =p /(2**((ill.reverse[0]/2).ceil.asInt))});    
  (p <2).if ({2},{p});
}), ('pitchCorrect' -> {|f,s=1|
	(f < (2**14)).or(s>20).if ({f;},{ ~pitchCorrect.(f / (2**((f.log2.floor)/2).ceil),s+1);});
}), 
  ('allServers' -> [ Server.fromName('localhost'), Server.fromName('internal') ]), ('run' -> {
  Server.default.freeAll;
  ~initRoutine.();
  ~clock.play(~r,0);
}), ('synthFactory' -> {|name, func,pan,l|
	SynthDef(name, {|gate =0, atk=18, rel=10,amp=1|
	var out;
	out = SynthDef.wrap(func);
		Out.ar(0,Mix.ar(Pan2.ar(out * amp,pan.value)) * EnvGen.ar(Env.asr(atk, 1, rel, 'linear'),gate, doneAction:2))
	}).load(l)
}), ('drone' -> {

 ~o= Synth.new("big-drone",\target,Server.internal);
  ~o.setn(\p,[1,243/128,2,3/2,15/8,27/8,1/3].reverse/32);
  ~o.setn(\n,[1,1/2,4/3,2,1,1/2].reverse);
  ~o.set(\freq,(1.5**12)*48);
  ~o.set(\of,0);
  ~o.set(\x,3);
  ~o.set(\amp,1/4);

  ~o.set(\gate,1);

~p= Synth.new("big-drone",\target,Server.internal);
~p.setn(\p,[1,2,4,3/2,4,2,1/3]/32);
~p.setn(\n,[1,1/2,4/3,1,2,1/2]);
~p.set(\freq,(((1.5**12)/256)+128)*48);
~p.set(\of,0);
~p.set(\x,3);
~p.set(\amp,1/4);

~p.set(\gate,1);



~q= Synth.new("big-drone",\target,Server.internal);
~q.setn(\p,[1,2,5/4,3/2,4,27/8,1/3]/32);
~q.setn(\n,[1,1/2,4/3,1,2,1/2]);
~q.set(\freq,128*48);
~q.set(\of,0);
~q.set(\x,3);
~q.set(\amp,1/4);
~q.set(\gate,1);
[~q,~p,~o].collect({|d|d.dump})
/*
~qq= Synth.new("big-drone",\target,Server.internal);
~qq.setn(\p,[1,2,5/4,3/2,4,27/8,1]/48);
~qq.setn(\n,[1,1/2,4/3,1,2,1/2]);
~qq.set(\freq,127*32);
~qq.set(\of,0);
~qq.set(\x,3);
~qq.set(\amp,1/8);

~qq.set(\gate,1);
*/

}), ('ampFunc' -> {|i,p,pp,l,k|
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
}), 
  ('i' -> [ 1.1111111111111, 1.25, 1.4285714285714, 1.6666666666667, 1.125, 1.2857142857143, 1.5, 1.8, 1.1428571428571, 1.3333333333333, 1.6, 1.1666666666667, 1.4, 1.75, 1.2 ]), ('n' -> OSCresponderNode.new), ('iIll' -> SCTextField.new), ('play' -> {|i,x|
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
}), ('hf' -> {|i,ill|(i.factors.reverse[0].nextPowerOfTwo**2);}), 
  ('p' -> Synth.new), ('tempo' -> 0.7047123912114), ('harmonicFunc' -> {|i, il, j, freq, hf,x,mod,k,l|
   freq * (((1024..1040) / 1024).permute(i).wrapAt(k+l) + (((1..8)*2)-1).permute(i).wrapAt(j));
}), ('panel' -> SCWindow("Values", Rect(1652.0, -121.0, 420.0, 420.0)).front;), ('o' -> Synth.new) ]