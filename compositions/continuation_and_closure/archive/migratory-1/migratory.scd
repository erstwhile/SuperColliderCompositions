{|i,il,ill,n,j,k,l,p,pp|
var qq, id, ss, a, r; 
qq=[2,n.collect({|x|(2*x)/(x.nextPowerOfTwo)}).flat.wrapAt(ill.sort.reverse.wrapAt(i.factors.reverse[0]).asInt.factors[0])].wrapAt(ill.sort.reverse[1]);
qq = qq * (n.collect({|x|(2*x)/(x.nextPowerOfTwo)}).wrapAt(ill.reverse[0].asInt.factors[0]));
a = ~atkFunc.value(i, ill, (k+l), j, pp);
(a.isNumber).if ({a=a},{a=1});
r = ~relFunc.value(i, ill, p, pp,0);
(r.isNumber).if ({r=r},{r=1});

((a + r)>4).if({
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

}
