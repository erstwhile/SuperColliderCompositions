z = Server.internal;
y =  Server.local;
~z = [Server.local,Server.internal];
//~z.collect({|x|x.boot});
/*
~z.collect({|x|SynthDef("just-sine",{|freq=100,atk=1, rel=1, sus=1, amp=0.005,pan =0,gate=0, mr=1, ma=1, mm=1|
  Out.ar(0,Mix.ar(Pan2.ar(SinOsc.ar(  [1,1] *.x SinOsc.kr([0,mr],0,ma,mm)  *.x freq,0,4 *amp/(freq+128)),pan)) * EnvGen.ar(Env.perc(atk,rel, 1, sus),gate, doneAction:2) );}).load(x)});
*/
~z.collect({|x|SynthDef("just-sine",{|freq=100,atk=1, rel=1, sus=1, amp=0.005,pan =0,gate=0, mr=1, ma=1, mm=1|
  Out.ar(0,Mix.ar(Pan2.ar(FSinOsc.ar(  [1,1] *.x freq,0,2 *amp/(freq+192)),pan)) * EnvGen.ar(Env.perc(atk,rel, 1, sus),gate, doneAction:2) );}).load(x)});

  
~clock = TempoClock.new(1/2,0,0,16384);
~clock.tempo_(3.5);
~i = 0;
~k = 0;
~x = 0;
~active = 0;
~r = Routine {

1.do({|n|  
  var a = (2**(n +17)).asInt;
  ~i =a;
  (2**14).asInt.do({|x|
      var i=~i;
      ~play.value(a+i.asInt,x.asInt);
      ~i = ~inc.value(i.asInt,a,n);
    });
  });
240.wait;
z.freeAll;
};

~inc = {|i,d,n|
  (i+(2**(n+4))).asInt ;
};


~rhythmFunc =  {|p,ill,i,j|
  var il;
  il = ({|x|((2**x)*(i/(2**x)%2).floor)}!i.log2.ceil.asInt).asInt;
  ill = (1+il).log2.floor.asInt;
  p=i.factors.wrapAt(ill.sort.reverse.wrapAt(ill.sum.log2)).log2.ceil;
  [(1/[3,6,6].stutter(~x.log2.ceil.asInt.factors.reverse[0])).wrapAt(~x),[1,2].stutter(~x.log2.ceil.asInt.factors.reverse[0]).wrapAt(~x)/3].flat.wrapAt(~x);
};

~notesFunc = {|i,il,ill|
  var n,a,na;
  il = ({|x|((2**x)*(i/(2**x)%2).floor)}!i.log2.ceil.asInt).asInt;
  ill = (1+il).log2.floor.asInt;
  na = [[4,18,32/3,24,27,28,16,20,6,30,36,45,54], [24/5,36/5,12,18,64/3,24,48/5,72/5,128/3 *(6/5),32,192/5]];
  //na =[[8,18,64/3,24,27]];
  na = na.wrapAt(ill.reverse[2]);
  a = Array.fill(ill.size);
  ill.size.do({|x|
    a.put(x,ill.count(_==x));
  }); 
  n= na.permute(il.reverse.wrapAt(ill.reverse[1].asInt.factors.reverse[0]).asInt);
  [{n},
  {  var c;
    c = ill.reject({|i|i==0}).size;
    c.do({|x|
      var nn = n.wrapAt(ill.sort.reverse.wrapAt(ill.sum.log10).factors.reverse.wrapAt(x));
      n = n * [nn /  nn.nextPowerOfTwo,nn.nextPowerOfTwo/nn].wrapAt(x);
    });
  n
  }].wrapAt(a.reverse[1]).value[0..(i.factors.reverse[0].log10.ceil.asInt)];
};

~countingFunc = {|i,il,ill| 
  var ils = 2-(i.log2-i.log2.floor),fils,ij;
  fils = {|ff,l|
    var r=ff;
    l.do({
      r=r**ff;
    });
    r.clip(0,2**i.log2.ceil.asInt).floor;
  };
  ij = ill.sort.reverse.wrapAt(1).asInt.factors.reverse[0];
  {(ill.sort.reverse.wrapAt((ij >ill.sum.log).if({1},{ill.sum.log});
).factors.reverse[0]+1).collect({|x|[il.sort.flat.reverse.wrapAt(x+fils.(ils,x)),i%il.sort.flat.reverse.wrapAt(x+fils.(ils,x))].wrapAt(ill.sum*0)}).sum}.value;
};

~relFunc = {|i,ill,p,pp|
  var il = ({|x|((2**x)*(i/(2**x)%2).floor)}!i.log2.ceil.asInt).asInt;
  ill = (1+il).log2.floor.asInt;
  [{  (((20)/pp.log2.ceil));},
  {  (( 2* pp.log2.ceil + pp.log.ceil));}].wrapAt(ill.reverse.wrapAt(i.log10.ceil+1)).value * (4/((~active+10).log10**3));
};

/*

recursive function
  list.factors.reverse[0].log2.factors.reverse[0].log2...until 1
*/

~atkFunc = {|i,j,k,pp,ill|
  var il = ({|x|((2**x)*(i/(2**x)%2).floor)}!i.log2.ceil.asInt).asInt,xa;
  ill = (1+il).log2.floor.asInt;
    xa = 1+(~x%ill.reverse[1].factors.reverse[0]);

  (1/(1+ill.wrapAt(j).asInt.factors.reverse[0]))*((1/(2**(16-i.factors.size))) * (pp.log10) * (1/(i.log2))) * ((xa/xa.nextPowerOfTwo)**2)
};

~ampFunc ={|i,il,ill,k,p,pp,x|
  var c1, c2, xa;
  c1 = 2 + (i.log2-i.log2.floor);
  c2 = (10**(2+(i.log2-i.log2.floor)));
  ((c1/((p+c2).log10))
  *((1/((p+(10)).log10)) )
  * 3 
  *((p.sqrt / (p+1).log) * 
   (c1/(pp+c2).log10)))
   
};


~harmonicFunc = {|i,il,ill,j,x,freq|
  var ils = 2-(i.log2-i.log2.floor),hf = i.asInt.factors.reverse[0].nextPowerOfTwo**3;
  il = ({|x|((2**x)*(i/(2**x)%2).floor)}!i.log2.ceil.asInt).asInt;
  ill = (1+il).log2.floor.asInt;
  freq *((hf + (j*(({|pr|pr.nthPrime}!(i.asInt.factors.size)).permute(il.reverse[0].asInt).wrapAt(i.asInt.factors.size))))/(hf));
};

~pitchFunc  ={|i,il,ill,k,p,j|
  var js =j * ((1+(ill.sort.wrapAt(i.factors.wrapAt(j))))%2), ka;
  ka =  2*({|x|x=x+1;x}!p.log2.ceil.asInt).permute(il.wrapAt(i.factors.sum+j));
    ((18/7)*(p *(2**((i.factors.size)%(i.log10.floor.asInt))) * ~notesFunc.value(i,il,ill).wrapAt(js))  * [ka.wrapAt(i),1+ka.wrapAt(i)].wrapAt(ill.reverse[j]))};
  

~modFunc ={|i, il, ill, k,j,p,x,freq|
    var f, a, m=1;
    f =  (5/3)/ (1+il).log2.floor.asInt.reject(_==0).wrapAt(i).factors.wrapAt(j);
    a = ((p.log2.floor-1)*(5/24))/freq;
    [f,0,a+1];
};

~play = {|i,x|
    var il,ill,ils = 2-(i.log2-i.log2.floor),r,w,ii,n;
    ii=i;
    il = ({|x|((2**x)*(i/(2**x)%2).floor)}!i.log2.ceil.asInt).asInt;
    ill = (1+il).log2.floor.asInt;
    ill.postln;
    i= ~countingFunc.(i,il,ill);
    r = Routine {
    i.factors.do({|p,j|
      var rr = Routine {
        (p.log2).ceil.asInt.do({|k|
          var pp = i.factors[j],s,freq, pitchCorrect,mrf =[1,1,1];
          p=p.nextPowerOfTwo.asInt.nextPrime;
          (p > (ils**ill.reverse[0])).if({p =p /(2**((ill.reverse[0]/2).ceil.asInt))});          (p <2).if ({p=2});
          freq = ~pitchFunc.(i,il,ill,k,p,j);
          freq = (freq >128).if ({freq * ~harmonicFunc.(i,il,ill,j,x,freq)},{freq});
          pitchCorrect = {|f,i,safe|
            f=f.abs;
            (f < (2**14)).or(safe >20).if ({f=f;},{ f=pitchCorrect.(f / (2**( (freq.log2.floor)/2)),i,safe+1);});
            f;
          };
          freq = pitchCorrect.(freq,i,0);
          pitchCorrect = {|f,i,safe|
            f=f.abs;
            (f > 48).or(safe>20).if ({ f=f; },{ f= pitchCorrect.(f  * (64),i,safe+1);});
            f;
          };
          freq = pitchCorrect.(freq,i,0);
          

          s = Synth.new("just-sine",\target,~z.wrapAt(x));  
          ~active = ~active +1;
          ~clock.play(Routine {
            (~atkFunc.(i,j,k,pp,ill) + ~relFunc.(i,ill,p,pp)).wait;
            ~active = ~active -1;
          },0);
          s.set(\freq, freq,\rel,~relFunc.(i,ill,p,pp),\pan,(2/(i.factors.wrapAt(j+k))) * (-1**((ii+j)%5)));
          s.set(\atk,~atkFunc.(i,j,k,pp,ill));
          mrf = ~modFunc.(i,il,ill,k,j,p,x,freq);
          s.set(\mr,mrf[0], \ma,mrf[1], \mm,mrf[2]);
          s.set(\sus,-1 * ((4+(2+ill.wrapAt(j)).log2)),\gate,1,\amp, ~ampFunc.(i,il,ill,k,p,pp));
          (~rhythmFunc.(i.factors[j],ill,i,j)+ (j/freq)).wait;

        });
        
      };
      ~clock.play(rr,0);
      });
      ~x =~x+1;
    };
    i.factors.postln;
    ~clock.play(r,0);
    (1/3).wait;
};
~clock.play(~r,0);
z.scope;