z = Server.internal;

SynthDef("just-sine",{|freq=100,freq2=50, atk=1, rel=1, sus=1, amp=0.005,pan =0,gate=0,f2=2,a2=2|
  Out.ar(0,Mix.ar(Pan2.ar(FSinOsc.ar(  [1,1] * freq,0,0.25 *amp/((freq+128)/freq.log2)),pan)) * EnvGen.ar(Env.perc(atk,rel, 1, sus),gate, doneAction:2) );}).load(z);

  
~clock = TempoClock.new(1/2,0,0,16384);
~clock.tempo_(3);
~tempo = 5/8;

~i = 0;
~r = Routine {

6.do({|n|  
  var a;
  a = (2**(n +13)).asInt;
  ~i =a;
  (2**14).asInt.do({|x|
      var i=~i;
      ~play.value(a+i.asInt,x.asInt);
      ~i = ~inc.value(i.asInt,a,n);
      "x: ".post;
      x.postln;
    });
  });
240.wait;
z.freeAll;
};
~inc = {|i,d,n|
  (i+(2**n)).asInt ;
};


~w = [  {|p,i|[p.log2.ceil/3,p.log2.ceil/2].wrapAt(i.factors.sum)}];


~n = {|i,il,ill|
var n = [8,128/7,32/3,24,27,28,4,20,6,30,36,45,54].permute(il.sort.reverse.wrapAt(ill.reverse.sort[1].asInt.factors.reverse[0]).asInt);
n 
};





~play = {|i,x|
    var il,ill,ils = 2-(i.log2-i.log2.floor),r,w,hf,jf,ii,n,logTen;
    ii=i;
    il = ({|x|((2**x)*(i/(2**x)%2).floor)}!i.log2.ceil.asInt);
    ill = (1+il).log2.floor;
    ill.postln;
    "i".post;i.postln;

    i={
      var ils = 2-(i.log2-i.log2.floor),fils,iFunc;
      fils = {|ff,l|
        var r=ff;
        l.do({
        r=r**ff;
        });
        //clip r
        r.clip(0,i.log2.ceil.asInt).floor;
        
      };
  
      ill.sort.reverse[1].asInt.factors.reverse[0].do({|x|
        (fils.(ils,x)).postln;
      });
      
      {((ill.sort.reverse[1].asInt.factors.reverse[0].collect({|x|i% il.sort.flat.reverse.wrapAt(fils.(ils,x))}).sum)).ceil.asInt}.value;

      
      }.value;

    "i".post; i.postln;
    logTen = i.log10.ceil.asInt;
    i.factors.postln;

    hf = (i.factors.reverse[0].nextPowerOfTwo**3);//.clip(2,2**(ill.reverse[0]));
    

    "hf".post; hf.postln;
    w = ~w[0];

    n = ~n.value(i,il,ill);

    i.postln;
    ~tempo = ((ill.sum/2).log2)/5;
    ~tempo.postln;
    r = Routine {
    i.factors.do({|p,j|
      var rr = Routine {
      (p.log2 ).ceil.asInt.do({|k|
        var pp = i.factors[j].asInt;
        
        (z.peakCPU > 90).if({z.freeAll});
        (p.log10.ceil).ceil.asInt.do({|l|
          var s,freq;
            s = Synth("just-sine",nil,~s);          
            p=p.nextPowerOfTwo;
          (p > (ils**ill.reverse[0])).if({p =p /(2**((ill.reverse[0]/2).ceil.asInt))});          
          (p <2).if ({p=2});
            freq ={
            var qq,il2, ils, js;
            il2 = (i.log2 - i.log2.floor);
            ils = (ill.sum*(il2**2));
            qq=[2,n.collect({|x|(2*x)/(x.nextPowerOfTwo)}).flat.wrapAt(ill.sort.reverse.wrapAt(i.factors.reverse[0]).asInt.factors[0])].wrapAt(ill.sort.reverse[1]);
            qq = qq * (n.collect({|x|(2*x)/(x.nextPowerOfTwo)}).wrapAt(ill.reverse[0].asInt.factors[0]));
            js = j * [(1+(ill.sort.reverse.wrapAt(i.factors.reverse[0].log2)))%2].wrapAt(ill.reverse[0]);

          ((8/7)*(p *(2**((i.log10.floor+i.log2.floor+i.factors.size)%(i.log10.floor.asInt))) *.x n[0..i.factors.reverse[0].log10.ceil.asInt].wrapAt((js))* qq) * (l.nthPrime / l.nthPrime.nextPowerOfTwo)  * (1+(2*k)))
            
          }.value;
          freq = freq * ((hf + (j*([2,3,5,7,11,13,17,19,23,29,31,37,41].permute(il.reverse[0].asInt).wrapAt(i.factors.size  ))))/(hf));

          (freq > (2**14)).if({freq = freq / (2**( i.factors.size.clip(2,i.log10.floor.asInt)))});
        

          s.set(\freq, freq);
          

          [
          {s.set(\rel,((4/(4+(i.log/16).floor))*((26)/(1+pp).log)/i.log10)*~tempo);},          
          {s.set(\rel,((4/(4+(i.log/16).floor))*((0.7)*(1+p).log)/i.log10)*~tempo);}
          ].wrapAt(ill.reverse.wrapAt(logTen+1)).value;

          s.set(\pan,(2/(i.factors[j])) * (-1**((ii+j)%5)));

          s.set(\atk,(1/(1+ill.wrapAt(k).asInt.factors.reverse[0]))*((1/(2**12)) * (i.factors[j]*pp.log10) * (1/(i.log*2))));
          s.set(\sus,-1 * i.factors[j].log);
          s.set(\gate,1);
          s.set(\amp,{
            var c1, c2;
            c1 = 2 + (i.log2-i.log2.floor);
            c2 = (10**(2+(i.log2-i.log2.floor)));

            ((c1/((p+c2).log10))
            *((1/((p+(10)).log10)) )
            * 4  * (1/(l+1))
            *(p.sqrt 
            * (c1/(pp+c2).log10)))
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
