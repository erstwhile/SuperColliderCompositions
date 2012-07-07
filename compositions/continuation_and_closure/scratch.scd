z = Server.default;

~clock = TempoClock.new(1/2,0,0,16384);
~clock.tempo_(3);
~tempo = 5/8;
z.freeAll;
~i = 0;


~r = Routine {

6.do({|n|  
  var a;
  a = (2**(n +13)).asInt;
  ~i =a;
  (2**14).asInt.do({|x|
      var i=~i;
      ~play.value(a+i.asInt,x.asInt);
      ~i = ~incrementFunc.value(i.asInt,a,n);
      {~iX.string = x;}.defer;
    });
  });
240.wait;
z.freeAll;
};


~play = {|i,x|
    var il,ill,r,ii,w,n,e,ils = 2-(i.log2-i.log2.floor),logTen,hf;
    ii=i;
    il = ({|x|((2**x)*(i/(2**x)%2).floor)}!i.log2.ceil.asInt);
    ill = (1+il).log2.floor;
    e = Environment.make({~i = i; ~il = il; ~ill = ill});
    e.know = true;
    {~iIll.string = ill;}.defer;
    e.ils = ils;
    i= ~countingFunc.valueWithEnvir(e);
    hf = (i.factors.reverse[0].nextPowerOfTwo**3);//.clip(2,2**(ill.reverse[0]));
    e.hf = (i.factors.reverse[0].nextPowerOfTwo**3);

    e.i = i;
    logTen= i.log10.ceil.asInt;
    w = ~waitFunc.valueWithEnvir(e);
    n = ~notesFunc.valueWithEnvir(e);
    e.n = n;
    ~tempo = ((e.ill.sum/2).log2)/5;

    r = Routine {
      i.factors.do({|p,j|
        var rr;
        e.p =p; e.j =j;
        rr = Routine {
        (p.log2).ceil.asInt.do({|k|
          var pp = i.factors[j];
          e.k = k;
          e.pp = i.factors[j];

          p.log10.ceil.asInt.do({|l|
            var s,freq;
            s = Synth("just-sine");          
            p=p.nextPowerOfTwo;
          (p > (ils**ill.reverse[0])).if({p =p /(2**((ill.reverse[0]/2).ceil.asInt))});          
          (p <2).if ({p=2});

          
          e.l =l; e.p = p;

          //~pFunc.valueWithEnvir(e).postln;


          freq = ~pitchFunc.valueWithEnvir(e);
          e.freq = freq;
          freq = ~harmonicFunc.valueWithEnvir(e);

          (freq > (2**14)).if({freq = freq / (2**( i.factors.size.clip(2,i.log10.floor.asInt)))});


          s.set(\freq, freq);
          (p !=~pFunc.valueWithEnvir(e)).({p.postln; ~pFunc.valueWithEnvir(e).postln; i.postln});

          s.set(\rel,~relFunc.valueWithEnvir(e));
          s.set(\pan,(2/(i.factors[j])) * (-1**((ii+j)%5)));
          s.set(\atk, ~atkFunc.valueWithEnvir(e));
          s.set(\sus, ~susFunc.valueWithEnvir(e));
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
};

~clock.play(~r,0);
z.scope;
