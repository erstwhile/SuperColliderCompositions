{




~i = ((9..2).reject(_==5)/.x(9..1).reject(_==5)).reject(_>=2).reject(_<=1);
~i = [1,3/2,4/3,8/7,9/8];
~i = [1,4/3,21/16,8/7,9/8];
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

~a.size.postln;
  Routine {
    ~a.collect({|p,j|
      var o, q,t,tt;
      p = (p.reject(_ > 8) *.f [1,1,1,1,1,1,1,1]);
      t = (1.5 - (p[0..1].wrapAt(j)*pi).sin);
      tt=(p[0..1].wrapAt(j)**[1,2,1,2,1]).sum**t;
      tt = (tt / (2**(tt.log10))); 
      j.postln;
      p.collect({|x|Rational(x)}).postln;
      (1/tt.log10).wait;
      (1/tt.log10).wait;
      o= Synth.new("big-drone",\target,[Server.internal,Server.local].wrapAt(j+1));
      o.setn(\p,(p[0..6]/128).reverse);
      o.setn(\n,p[0..1]**[1,2,3,4,5,6]/(p[0..1]**3));
      o.set(\freq,(1.5**12)**2);
      o.set(\amp,1/4);
      q= Synth.new("big-drone",\target,[Server.internal,Server.local].wrapAt(j));
      q.setn(\p,(p[0..6]/128));
      q.setn(\n,p[0..1]**[1,2,3,4,5,6]/(p[0..1]**3));
      q.set(\freq,128**2);
      q.set(\amp,1/4);
      [q,o].collect({|d,i|d.set(\x,p.wrapAt(j) + (pi * p.wrapAt(j)).sin)});
      (p.wrapAt(j) + (pi * p.wrapAt(j)).sin).postln;
      [q,o].collect({|d,i|d.set(\ra,p[0..1].wrapAt(j)**6)});
      [q,o].collect({|d,i|d.set(\tt,(p[0]/(tt)))});
      [q,o].collect({|d,i|d.set(\rel,tt.log10**tt.log10)});

      [q,o].collect({|d,i|d.set(\rs,j/~a.size)});
      [q,o].collect({|d,i|d.set(\atk,1/tt.log10)});
      [q,o].collect({|d,i|d.set(\of,p.wrapAt(j)*pi)});
      [q,o].collect({|d,i|d.set(\gate,1)});
      (tt).postln;
      (tt).wait;
      [q,o].collect({|d,i|d.set(\gate,0)});
      (tt.log10**tt.log10).wait;

    });
  }.play;
}.value;

