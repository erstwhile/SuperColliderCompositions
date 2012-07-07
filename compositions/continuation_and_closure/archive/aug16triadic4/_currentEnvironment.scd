Environment[ ('iB' -> SCTextField.new), ('clock' -> TempoClock.new), ('iFils' -> SCTextField.new), ('iFac' -> SCTextField.new), ('atkFunc' -> {|i, ill, k, j, pp|
  (1/(1+ill.wrapAt(k).asInt.factors.reverse[0]))*((1/(2**12)) * (i.factors[j]*pp.log10) * (1/(i.log*2)));
}), 
  ('mylib' -> SynthDescLib.new), ('iT' -> SCTextField.new), ('iI' -> SCTextField.new), ('incrementFunc' -> {|i,d,n|
  (i+(2**n)).asInt;
}), ('susFunc' -> {|i,j|
  -1 * i.factors[j].log;
}), 
  ('iCPU' -> SCTextField.new), ('relFunc' -> {|i, ill, p, pp| 
    [
      {((4/(4+(i.log/16).floor))*((26)/(1+pp).log)/i.log10)*~tempo;},           
      {((4/(4+(i.log/16).floor))*((0.7)*(1+p).log)/i.log10)*~tempo;}
    ].wrapAt(ill.reverse.wrapAt(i.log10.ceil+1)).value;
}), ('iF' -> SCTextField.new), ('kFunc' -> {|i,il,ill,j,p|
  3;
}), ('pitchFunc' -> {|i, il, ill, p, j, k, x, n, l|
  var qq, js;
qq=[2,n.collect({|x|(2*x)/(x.nextPowerOfTwo)}).flat.wrapAt(ill.sort.reverse.wrapAt(i.factors.reverse[0]).asInt.factors[0])].wrapAt(ill.sort.reverse[1]);
  qq = qq * (n.collect({|x|(2*x)/(x.nextPowerOfTwo)}).wrapAt(ill.reverse[0].asInt.factors[0]));
  js = j * [(1+(ill.sort.reverse.wrapAt(i.factors.reverse[0].log2)))%2].wrapAt(ill.reverse[0]);

  ((8/7)*(p *(2**((i.log10.floor+i.log2.floor+i.factors.size)%(i.log10.floor.asInt))) *.x n[0..i.factors.reverse[0].log10.ceil.asInt.clip(1,32)].wrapAt((js+l))* qq) * 
  [((2*l)+1),(l+1),(l.nthPrime / l.nthPrime.nextPowerOfTwo),1/(l.nthPrime / l.nthPrime.nextPowerOfTwo)].permute(ill.reverse[0].asInt).wrapAt(ill.sort.reverse[4].asInt.factors.reverse[0])  * 
  (1+(2*(k%ill.sort.reverse[1].asInt.factors.reverse[0]))))
}), 
  ('archive' -> {|f|
var path,a;
path = "/Users/thomasgillis/dev/supercollider/sc/scd/compositions/continuation_and_closure/archive/"++f.asString;
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

}.play;
}), ('waitFunc' -> {|i,il,ill|{|pp,i|[pp.log2.ceil/3,pp.log2.ceil/2].wrapAt(i.factors.sum)/(2**i.factors.size)}}), ('lFunc' -> {|i,il,ill,j,k,p|
  var z = Server.default.peakCPU;
  (z > 70).if ({
    //query all nodes
    //kill the oldest
    
  });
(8 - (Server.default.numSynths.log.floor.asInt)).clip(1,5);
}), ('r' -> Routine({

8.do({|n|  
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
}), 
  ('allServers' -> Set[ Server.fromName('localhost'), Server.fromName('internal') ]), ('synthFactory' -> {|name, func, pan =({[-1,1]}),l=(Server.internal)|
	SynthDef(name, {|gate =0, atk=18, rel=10,amp=1|
	var out;
	out = SynthDef.wrap(func);
		Out.ar(0,Mix.ar(Pan2.ar(out * amp,pan.value)) * EnvGen.ar(Env.asr(atk, 1, rel, 'linear'),gate, doneAction:2))
	}).send(l)
}), ('ampFunc' -> {|i,p,pp,l,k|
    var c1, c2;
    c1 = 2 + (i.log2-i.log2.floor);
    c2 = (10**(2+(i.log2-i.log2.floor)));

    ((c1/((p+c2).log10))
    *((1/((p+(10)).log10)) )
    * 2  * (1/(l+1)) * (1/(k+3).log)
    *(p.sqrt 
    * (c1/(pp+c2).log10)))
  }), ('panFunc' -> {|i, j, ii,k,l|
  ((1/(i.factors.size)) * (-1**(ii+j)) + (((2+k.log2)-1)**(-1**(k+l))) - (((2+l.log2)-1)**(-1**(k+l)))).clip(-1,1)
}), ('i' -> 4096), 
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
}), ('iIll' -> SCTextField.new), ('iX' -> SCTextField.new), ('play' -> {|i,x|
    var il,ill,r,ii,w,e,ils = 2-(i.log2-i.log2.floor);
    ii=i;
    il = ({|x|((2**x)*(i/(2**x)%2).floor)}!i.log2.ceil.asInt);
    ill = (1+il).log2.floor;
    e = Environment.make({~i = i; ~il = il; ~ill = ill;~x=x;});
    e.know = true;
    {~iIll.string = ill;}.defer;
    e.ils = ils;
    e.ii = i;
    i= ~countingFunc.valueWithEnvir(e);
    e.i = i;
    {~iI.string = i;}.defer;
    {~iFac.string = i.factors}.defer;
    e.hf = (i.factors.reverse[0].nextPowerOfTwo**3);
    w = ~waitFunc.valueWithEnvir(e);
    "hi".postln;
    e.n = ~notesFunc.valueWithEnvir(e);
    ~tempo = ((e.ill.sum/2).log2)/5;
      "hi".postln;

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
              (f < (2**14)).or(safe >20).if ({f=f;},{ f=pitchCorrect.(f / (2**( i.factors.size.clip(2,i.log10.floor.asInt))),i,safe+1);});
              f;
            };
            
            freq = pitchCorrect.(freq,i,0);
            pitchCorrect = {|f,i,safe|
              f=f.abs;
              (f > 48).or(safe>20).if ({ f=f; },{ f= pitchCorrect.(f  * (64),i,safe+1);});
              f;
            };
            freq = pitchCorrect.(freq,i,0);
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
  //        ~running.removeAt(~running.keys.asArray[0]);
        });
      };
      ~clock.play(rr,0);
      });
    };
    ~clock.play(r,0);
    (1/3).wait;
}), ('tempo' -> 0.625), 
  ('harmonicFunc' -> {|i, il, j, freq, hf|
   freq * ((hf + (j*([2,3,5,7,11,13,17,19,23,29,31,37,41].permute(il.reverse[0].asInt).wrapAt(i.factors.size  ))))/(hf));
}), ('panel' -> SCWindow("Values", Rect(128.0, 64.0, 420.0, 420.0)).front;) ]