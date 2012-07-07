Environment[ ('notesFunc' -> { |i,il,ill|
      var n = (8*[1,4/3,3/2,2,8/3,3,4] *.x[1,3/8,4/3,3/2,2/3,1/4]).permute(il.sort.reverse.wrapAt(ill.reverse.wrapAt(3)).asInt);
      n
}), ('iB' -> SCTextField.new), ('mm' -> Proto(Environment[ ('isPlaying' -> false) ])), ('migratory' -> {|i,il,ill,n,j,k,l,p,pp|
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

}), ('iFils' -> SCTextField.new), 
  ('initRoutine' -> {
  z = Server.default;

  ~clock = TempoClock.new(1/2,0,0,16384);
  ~clock.tempo_(1);
  ~tempo = 5/8;
  z.freeAll;
  ~i = 0;


  ~r = Routine {
  1.do({|n|  
    var a;
    a = (2**(n +12)).asInt;
    ~i =a;
    (2**13).asInt.do({|x|
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
  
  ~drone.();
}), ('mylib' -> SynthDescLib.new), ('iT' -> SCTextField.new), ('iI' -> SCTextField.new), ('unique' -> {|a|var t = Array.fill(a.size);
  a.collect({|i,j|(t.includes(i)).if({t.put(j,nil)}, {t.put(j,a[j])})}).reject({|i|i==nil});
  t.reject({|i|i==nil});
  }), 
  ('susFunc' -> {|i,j,k,l|
  -1 * i.factors.wrapAt(j+k+l).log10;
}), ('iCPU' -> SCTextField.new), ('kFunc' -> {|i,il,ill,j,p|
  ill.reject(_==0).size;
}), ('pChoose' -> {|ils,ill, p|
  [
    {p.nextPowerOfTwo.nextPrime},
    {p.nextPowerOfTwo}
  ].wrapAt(ils).value
}), ('lFunc' -> {|i,il,ill,j,k,p|
(8 - (Server.default.numSynths.log.floor.asInt)).clip(1,5);

}), 
  ('restoreFull' -> {|f|
  var path = ~path ++f, keys,file;
  Object.readArchive(path++"/_currentEnvironment.scd");
}), ('w' -> {|p,i|(p.log2.ceil/p.log2.nextPowerOfTwo)*2}), ('refresh' -> {|f|
  ~archive.(f,~restore.(f));
}), ('inc' -> {|i|
	var a = ((2**(i.log10.ceil)));
	(i+a).asInt;
}), ('ampFunc1' -> {|i,p,pp,l,k|
    var c1, c2;
    c1 = 2 + (i.log2-i.log2.floor);
    c2 = (10**(2+(i.log2-i.log2.floor)));

    ((c1/((p+c2).log10))
    *((1/((p+(10)).log10)) )
    * 4  * (1/(l+1)) * (1/(k+3).log)
    *(p.sqrt 
    * (c1/(pp+c2).log10)))
  }), 
  ('initGui' -> {~panel = GUI.window.new("Values",Rect(128,64,420,420));
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
}), ('start' -> SCButton.new), ('panFunc' -> {|i, j, ii,k,l,x|     ((1/(i.factors.size)) * (-1**(i.factors.size+j+k+x)) + (((2+k.log2)-1)**(-1**(k+l)))).clip(-1,1)    }), ('controls' -> SCWindow("Controls", Rect(2465.0, -210.0, 420.0, 420.0)).front;), ('countingFunc' -> {|i, il, ill|
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
  ('path' -> "/Users/thomasgillis/dev/supercollider/sc/scd/compositions/continuation_and_closure/archive/"), ('iX' -> SCTextField.new), ('rhythmFunc' -> {|p,ill,i,j|
  var il;
  il = ({|x|((2**x)*(i/(2**x)%2).floor)}!i.log2.ceil.asInt).asInt;
  ill = (1+il).log2.floor.asInt;
  p=i.factors.wrapAt(ill.sort.reverse.wrapAt(ill.sum.log2)).log2.ceil;
  [(1/[3,6,6].stutter(~x.log2.ceil.asInt.factors.reverse[0])).wrapAt(~x),[1,2].stutter(~x.log2.ceil.asInt.factors.reverse[0]).wrapAt(~x)/3].flat.wrapAt(~x);
}), ('clock' -> TempoClock.new), ('iFac' -> SCTextField.new), 
  ('atkFunc' -> {|i, ill, k, j, pp|
  (1/(1+ill.wrapAt(k).asInt.factors.reverse[0]))*((1/(2**12)) * (i.factors[j]*pp.log10) * (1/(i.log*2)));
}), ('incrementFunc' -> {|i,d,n|
  (i+(2**n)).asInt;
}), ('ampFunc2' -> {|i,p,pp,l,k|
    var c1, c2;
    c1 = 2 + (i.log2-i.log2.floor);
    c2 = (10**(2+(i.log2-i.log2.floor)));

    ((c1/((p+c2).log10))
    *((1/((p+(10)).log10)) )
    * 3  * (1/(l+1)) * (1/(k+3).log)
    *(pp.log2 
    * (c1/(p+c2).log10)))
  }), ('notesfunc' -> { |i,il,ill|
      var n = (8*[1,4/3,3/2,2,8/3,3,4] *.x[1,3/8,4/3,3/2,2/3,1/4]).permute(il.sort.reverse.wrapAt(ill.reverse.wrapAt(3)).asInt);
      n
}), ('moo' -> {|i,x|1}), 
  ('relFunc' -> {|i, ill, p, pp,l| 
    [
      {((4/(4+(i.log/16).floor))*((24+l)/(1+pp).log)/i.log10)*~tempo;},           
      {((4/(4+(i.log/16).floor))*((0.6+l)*(1+p).log)/i.log10)*~tempo;}
    ].wrapAt(ill.reverse.wrapAt(i.log10.ceil+1)).value;
}), ('iF' -> SCTextField.new), ('pitchFunc' -> {|i, il, ill, p, j, k, x, n, l|
  var qq, js;
//  ~p.set(\x,ill.sum.log2.ceil.clip(0,16));
//  ~p.set(\of,ill.sum.log2.ceil.clip(0,16));

qq=[2,n.collect({|x|(2*x)/(x.nextPowerOfTwo)}).flat.wrapAt(ill.sort.reverse.wrapAt(i.factors.reverse[0]).asInt.factors[0])].wrapAt(ill.sort.reverse[1]);
  qq = qq * (n.collect({|x|(2*x)/(x.nextPowerOfTwo)}).wrapAt(ill.reverse[0].asInt.factors[0]));
  
  js = j * [(1+(ill.sort.reverse.wrapAt(i.factors.reverse[0].log2)))%2].wrapAt(ill.reverse[0]);

  ((8/8)*(p *(2**((i.log10.floor+i.log2.floor+i.factors.size)%(i.log10.floor.asInt))) *.x n[0..i.factors.reverse[0].log10.ceil.asInt.clip(1,32)].wrapAt((js+l))* qq) * 
  [((2*l)+1),(l+1),(l.nthPrime / l.nthPrime.nextPowerOfTwo),1/(l.nthPrime / l.nthPrime.nextPowerOfTwo)].permute(ill.reverse[0].asInt).wrapAt(ill.sort.reverse[4].asInt.factors.reverse[0])  * 
  [(1+(2*(k%ill.sort.reverse[1].asInt.factors.reverse[0]))),1/(1+(2*(k%ill.sort.reverse[1].asInt.factors.reverse[0])))].wrapAt(i.factors.size);
  
  );

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
  ('waitFunc' -> {|i,il,ill|{|pp,i|[pp.log2.ceil/3,pp.log2.ceil/2].wrapAt(i.factors.sum)/(2**i.factors.size)}}), ('running' -> Dictionary[  ]), ('r' -> Routine({
  1.do({|n|  
    var a;
    a = (2**(n +12)).asInt;
    ~i =a;
    (2**13).asInt.do({|x|
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
}), ('allServers' -> Set[ Server.fromName('internal'), Server.fromName('localhost') ]), 
  ('pitchCorrect' -> {|f,s=1|
	(f < (2**14)).or(s>20).if ({f;},{ ~pitchCorrect.(f / (2**((f.log2.floor)/2).ceil),s+1);});
}), ('run' -> {
  Server.default.freeAll;
  ~initRoutine.();
  ~clock.play(~r,0);
}), ('synthFactory' -> {|name, func, pan =({[-1,1]}),l=(Server.internal)|
	SynthDef(name, {|gate =0, atk=18, rel=10,amp=1|
	var out;
	out = SynthDef.wrap(func);
		Out.ar(0,Mix.ar(Pan2.ar(out * amp,pan.value)) * EnvGen.ar(Env.asr(atk, 1, rel, 'linear'),gate, doneAction:2))
	}).send(l)
}), ('ampFunc' -> {|i,p,pp,l,k|
      var c1, c2,out;
      c1 = 2 + (i.log2-i.log2.floor);
      c2 = (10**(2+(i.log2-i.log2.floor)));

      out = ((c1/((p+c2).log10))
      *((1/((p+(3)).log)))
      * 16 * (1/(l+2).log2) * (1/(k+3).log)
      *(p.sqrt 
      * (c1/(pp+c2).log10)));
      out.clip(0.01,16);
}), ('drone' -> {
/*
~o= Synth("big-drone");
~o.setn(\p,[1/2,2/3,1,2,3,4,6,8]);
~o.setn(\n,[3/4,1,6/5,4/3,9/5,9/4,16/9]);

~o.setn(\freq,120);
~o.set(\atk,0);
~o.set(\x,3);
~o.set(\of,4);
~o.set(\gate,0);
*/
~p= Synth.new("big-drone",\target,Server.internal);
~p.setn(\p,[1,4/3,3/2,2,8/3,3,4]/8);
~p.setn(\n,[1,3/8,4/3,3/2,2/3,1/4]);
~p.set(\freq,128*16);
~p.set(\of,0);
~p.set(\x,4);
~p.set(\amp,1/12);

~p.set(\gate,1);
}), 
  ('i' -> 4158), ('n' -> OSCresponderNode.new), ('iIll' -> SCTextField.new), ('play' -> {|i,x|
    var il,ill,r,ii,w,e,ils = 2-(i.log2-i.log2.floor);
    ii=i;
    il = ({|x|((2**x)*(i/(2**x)%2).floor)}!i.log2.ceil.asInt);
    ill = (1+il).log2.floor;
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
            s.set(\bassCutoff, 256);            
            s.set(\gate,1);
            s.set(\amp,~ampFunc.valueWithEnvir(e)); 
            (~running.size < 1).if ({
              ~migratory.valueWithEnvir(e);
            });

           });
          w.(i.factors[j],i).wait;
        });
      };
      ~clock.play(rr,0);
      });
    };
    ~clock.play(r,0);
    (1/3).wait;
}), ('hf' -> {|i,ill|(i.factors.reverse[0].nextPowerOfTwo**2);}), 
  ('p' -> Synth.new), ('tempo' -> 0.76147098441152), ('harmonicFunc' -> {|i, il, j, freq, hf,x,mod,k,l|
   freq * ((((1024..1040) / 1024).permute(i).wrapAt(k+l)     + (((1..16).permute(il.reverse[0].asInt).wrapAt(j+i.factors.size  ))))/(1));
}), ('panel' -> SCWindow("Values", Rect(1712.0, 16.0, 420.0, 420.0)).front;), ('o' -> Synth.new) ]