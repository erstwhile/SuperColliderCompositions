Environment[ ('notesFunc' -> { |i,il,ill|
  z = Server.default;

  ~clock = TempoClock.new(1/2,0,0,16384);
  ~clock.tempo_(3);
  ~tempo = 5/8;
  z.freeAll;
  ~i = 0;


  ~r = Routine {
  4.do({|n|  
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
  ~n = OSCresponderNode(nil,"/n_end",{|time,responder,msg|~running.removeAt(msg[1]);}).add;
  //set up a responder node when new code is pushed

  ~running = Dictionary.new;
  ~unique = {|a|var t = Array.fill(a.size);
  a.collect({|i,j|(t.includes(i)).if({t.put(j,nil)}, {t.put(j,a[j])})}).reject({|i|i==nil});
  t.reject({|i|i==nil});
  };
}), ('mylib' -> SynthDescLib.new), 
  ('iT' -> SCTextField.new), ('iI' -> SCTextField.new), ('unique' -> {|a|var t = Array.fill(a.size);
  a.collect({|i,j|(t.includes(i)).if({t.put(j,nil)}, {t.put(j,a[j])})}).reject({|i|i==nil});
  t.reject({|i|i==nil});
  }), ('susFunc' -> {|i,j,k,l|
  -1 * i.factors.wrapAt(j+k+l).log10;
}), ('iCPU' -> SCTextField.new), 
  ('kFunc' -> {|i,il,ill,j,p|
  2;
}), ('pChoose' -> {|ils,ill, p|
  [
    {p.nextPowerOfTwo.nextPrime},
    {p.nextPowerOfTwo}
  ].wrapAt(ils).value
}), ('lFunc' -> {|i,il,ill,j,k,p|
(8 - (Server.default.numSynths.log.floor.asInt)).clip(1,5);
}), ('w' -> {|p,i|(p.log2.ceil/p.log2.nextPowerOfTwo)*2}), ('restoreFull' -> {|f|
  var path = ~path ++f, keys,file;
  Object.readArchive(path++"/_currentEnvironment.scd");
}), 
  ('metaAmpFunc' -> {|i,p,pp,l,k|
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
}), ('refresh' -> {|f|
  ~archive.(f,~restore.(f));
}), 
  ('start' -> SCButton.new), ('panFunc' -> {|i, j, ii,k,l,x|
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
}), ('path' -> "/Users/thomasgillis/dev/supercollider/sc/scd/compositions/continuation_and_closure/archive/"), 
  ('iX' -> SCTextField.new), ('rhythmFunc' -> {|p,ill,i,j|
  var il;
  il = ({|x|((2**x)*(i/(2**x)%2).floor)}!i.log2.ceil.asInt).asInt;
  ill = (1+il).log2.floor.asInt;
  p=i.factors.wrapAt(ill.sort.reverse.wrapAt(ill.sum.log2)).log2.ceil;
  [(1/[3,6,6].stutter(~x.log2.ceil.asInt.factors.reverse[0])).wrapAt(~x),[1,2].stutter(~x.log2.ceil.asInt.factors.reverse[0]).wrapAt(~x)/3].flat.wrapAt(~x);
}), ('clock' -> TempoClock.new), ('iFac' -> SCTextField.new), ('atkFunc' -> {|i, ill, k, j, pp|
  (1/(1+ill.wrapAt(k).asInt.factors.reverse[0]))*((1/(2**12)) * (i.factors[j]*pp.log10) * (1/(i.log*2)));
}), 
  ('incrementFunc' -> {|i,d,n|
  (i+(2**n)).asInt;
}), ('notesfunc' -> { |i,il,ill|
  var n = [8,128/7,32/3,24,27,28,4,20,6,30,36,45,54].permute(il.sort.reverse.wrapAt(ill.reverse.sort[1].asInt.factors.reverse[0]).asInt);
  n
}), ('moo' -> {|i,x|1}), ('ampFunc2' -> {|i,p,pp,l,k|
    var c1, c2;
    c1 = 2 + (i.log2-i.log2.floor);
    c2 = (10**(2+(i.log2-i.log2.floor)));

    ((c1/((p+c2).log10))
    *((1/((p+(10)).log10)) )
    * 3  * (1/(l+1)) * (1/(k+3).log)
    *(pp.log2 
    * (c1/(p+c2).log10)))
  }), ('relFunc' -> {|i, ill, p, pp| 
    [
      {((4/(4+(i.log/16).floor))*((26)/(1+pp).log)/i.log10)*~tempo;},           
      {((4/(4+(i.log/16).floor))*((0.7)*(1+p).log)/i.log10)*~tempo;}
    ].wrapAt(ill.reverse.wrapAt(i.log10.ceil+1)).value;
}), 
  ('iF' -> SCTextField.new), ('pitchFunc' -> {|i, il, ill, p, j, k, x, n, l|
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
}), ('waitFunc' -> {|i,il,ill|{|pp,i|[pp.log2.ceil/3,pp.log2.ceil/2].wrapAt(i.factors.sum)/(2**i.factors.size)}}), 
  ('running' -> Dictionary[  ]), ('r' -> Routine({
  4.do({|n|  
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
  (p > (ils**ill.reverse[0])).if({p =p /(2**((ill.reverse[0]/2).ceil.asInt))});    
  (p <2).if ({2},{p});
}), ('pitchCorrect' -> {|f,s=1|
	(f < (2**14)).or(s>20).if ({f;},{ ~pitchCorrect.(f / (2**((f.log2.floor)/2).ceil),s+1);});
}), ('allServers' -> Set[ Server.fromName('internal'), Server.fromName('localhost') ]), 
  ('ampFunc' -> {|i,p,pp,l,k|
      var c1, c2,out;
      c1 = 2 + (i.log2-i.log2.floor);
      c2 = (10**(2+(i.log2-i.log2.floor)));

      out = ((c1/((p+c2).log10))
      *((1/((p+(10)).log10)))
      * 3  * (1/(l+1)) * (1/(k+3).log)
      *(p.sqrt 
      * (c1/(pp+c2).log10)));
      out.clip(0.01,32);
    }), ('synthFactory' -> {|name, func, pan =({[-1,1]}),l=(Server.internal)|
	SynthDef(name, {|gate =0, atk=18, rel=10,amp=1|
	var out;
	out = SynthDef.wrap(func);
		Out.ar(0,Mix.ar(Pan2.ar(out * amp,pan.value)) * EnvGen.ar(Env.asr(atk, 1, rel, 'linear'),gate, doneAction:2))
	}).send(l)
}), ('run' -> {
  Server.default.freeAll;
  ~initRoutine.();
  ~clock.play(~r,0);
}), ('superInt' -> Proto(Environment[ ('i' -> 1) ])), ('f' -> 0.5), 
  ('i' -> 98304), ('n' -> OSCresponderNode.new), ('iIll' -> SCTextField.new), ('play' -> {|i,x|
    var il,ill,r,ii,w,e,ils = 2-(i.log2-i.log2.floor);
    ii=i;
    il = ({|x|((2**x)*(i/(2**x)%2).floor)}!i.log2.ceil.asInt);
    ill = (1+il).log2.floor;
    e = Environment.make({~i = i; ~il = il; ~ill = ill;~x=x; ~mod = {|n|((4..8)/4).wrapAt(n)}});
    e.know = true;
    {~iIll.string = ill;}.defer;
    e.ils = ils;
    e.mod = ~moo;
    e.ii = i;
    i= ~countingFunc.valueWithEnvir(e);
    e.i = i;
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

            (p !=~pFunc.valueWithEnvir(e)).({p.postln; ~pFunc.valueWithEnvir(e).postln; i.postln});

            s.set(\freq, freq);
            s.set(\rel,~relFunc.valueWithEnvir(e));
            s.set(\pan,~panFunc.valueWithEnvir(e));
            s.set(\atk, ~atkFunc.valueWithEnvir(e));
            s.set(\sus, ~susFunc.valueWithEnvir(e));
            s.set(\bassCutoff, 256);
            
            s.set(\gate,1);
            s.set(\amp,~ampFunc.valueWithEnvir(e));         
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
  ('tempo' -> 1.2110564871002), ('harmonicFunc' -> {|i, il, j, freq, hf,x,mod,k|
   freq * ((hf + (k * ([2,3,5,7,11,13,17,19,23,29,31,37,41].permute(il.reverse[0].asInt).wrapAt(j+i.factors.size  ))))/(hf));
}), ('panel' -> SCWindow("Values", Rect(1898.0, -143.0, 420.0, 420.0)).front;) ]