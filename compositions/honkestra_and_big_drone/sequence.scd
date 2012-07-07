
//vanilla honkestra test
{
  ~h = Synth("honkestra");
  ~h.setn(\n,[2/3,1,2,3,4,5,6,7,8].flat);
  ~h.setn(\p,[13,17,19,23,29,31,37]/16);
  ~h.set(\freq,128);
  ~h.set(\atk,0);
  ~h.setn(\gate,1);
}.value

~h.setn(\gate,0);

//utonic honks
{
  ~h = Synth("honkestra");
  ~h.setn(\n,6/[2/3,1,2,3,4,5,6,7,8].flat);
  ~h.setn(\p,24/[13,17,19,23,29,31,37]);
  ~h.set(\freq,121);
  ~h.set(\atk,0);
  ~h.setn(\gate,1);
}.value  
  
  

//fade in slow - classic honk to transcendendent big drone
Routine {

  ~h = Synth("honkestra2");
  ~h.setn(\n,[2/3,1,2,3,4,5]);
  ~h.setn(\p,[13,17,19,23,29,31,37]/16);
  ~h.set(\amp,2.5);
  ~h.set(\freq,120);

  ~j = Synth("honkestra3");
  ~j.setn(\n,[2/3,1,2,3,4,5]);
  ~j.setn(\p,[13,17,19,23,29,31,37]/16);
  ~j.set(\freq,120);

  ~j.set(\gate,1);
  ~h.set(\gate,1);
  "1-180".postln;
  (180 * (16/15)).wait;

  ~h.set(\gate,0);
  ~j.set(\gate,0);
  ~h = Synth("honkestra2");
  ~h.setn(\n,[2/3,1,2,3,4,5]);
  ~h.set(\amp,2.5);
  ~h.set(\of,0);
  ~h.set(\freq,120);

  ~j = Synth("honkestra3");
  ~j.setn(\n,[2/3,1,2,3,4,5]);
  ~j.set(\of,0);
  ~j.set(\freq,120);
  ~j.setn(\p,[1,9/8,21/16,4/3,3/2,27/16,9/4]);
  ~h.setn(\p,[1,9/8,21/16,4/3,3/2,27/16,9/4]);

  ~j.set(\gate,1);
  ~h.set(\gate,1);
  "2-180".postln;
  (180 * (16/15)).wait;


  ~h.set(\gate,0);
  ~j.set(\gate,0);
  ~h = Synth("honkestra2");
  ~h.setn(\n,[2,4,6,8,10,12]/3);
  ~h.setn(\p,[12,16,18,24,30,32,36]/16);
  ~h.set(\amp,2.5);
  ~h.set(\of,2);
  ~h.set(\freq,90);

  ~j = Synth("honkestra3");
  ~j.setn(\n,[2,4,6,8,10,12]/3);
  ~j.setn(\p,[12,16,18,24,30,32,36]/16);
  ~j.set(\freq,90);
  ~j.set(\of,0);
  ~j.set(\gate,1);
  ~h.set(\gate,1);
  "3-300".postln;
  (300 * (16/15)).wait;
  "32-fade".postln;
  ~h.set(\rel,32);
  ~j.set(\rel,32);
  ~h.set(\gate,0);
  ~j.set(\gate,0);
}.play;


//big drone vs honkestra
Routine {
  8.do({|o|
    ~h = Synth("honkestra");
    ~h.setn(\n,[2/3,(1..8)].flat);
    ~h.setn(\p,(5..11).nthPrime/16);
    ~h.set(\freq,96);
    ~h.set(\x,3);
    ~h.set(\of,o);
    ~h.set(\atk,16);
    ~h.set(\rel,32);
    ~h.set(\amp,1);
    ~h.set(\gate,1);
    (180 + (120 * (o.sin))).wait;
    ~h.set(\gate,0);
    ~p= Synth("big-drone");
    ~p.setn(\p,[0.5,1/3,1,2,3,4,6,8]);
    ~p.setn(\n,[16,18,20,24,30,32,36]/16);
    ~p.setn(\freq,120);
    ~p.set(\atk,16);
    ~p.set(\rel,32);
    ~p.set(\of,o);
    ~p.set(\amp,1);    
    ~p.set(\gate,1);
    (192 + (128 * (o.sin))).wait;
    ~p.set(\gate,0);
  })
}.play;




//big drone, different chord
{
~o= Synth("big-drone");
~o.setn(\p,[1/2,2/3,1,2,3,4,6,8]);
~o.setn(\n,[3/4,1,5/4,3/2,15/8,9/4,45/16]);

~o.setn(\freq,120);
~o.set(\atk,0);
~o.set(\x,3);
~o.set(\of,4);
~o.set(\gate,1);

~p= Synth("big-drone");
~p.setn(\p,[1/2,2/3,1,2,3,4,6,8]);
~p.setn(\n,[3/4,1,5/4,3/2,15/8,9/4,45/16]);
~p.setn(\freq,120);
~p.set(\of,0);
~p.setn(\gate,1);
}.value



//classic big drone

~p.setn(\gate,0);
~o.setn(\gate,0);
{
~o= Synth("big-drone");
~o.setn(\p,[1/2,2/3,1,2,3,4,6,8]);
~o.setn(\n,[16,18,20,24,30,32,36]/16);
~o.setn(\freq,120);
~o.set(\atk,0);
~o.set(\x,3);
~o.set(\of,4);
~o.set(\gate,1);

~p= Synth("big-drone");
~p.setn(\p,[1/2,2/3,1,2,3,4,6,8]);
~p.setn(\n,[16,18,20,24,30,32,36]/16);
~p.setn(\freq,120);
~p.set(\of,0);
~p.setn(\gate,1);
}.value;


//sibelius 5
//~z = [Server.internal,Server.local];
~r = {
var n = [1,3/8,4/3,3/2,2/3,4], p = [1,4/3,3/2,2,8/3,3,1/4], freq=300,of=1,r=[];
  4.do({|x|
    var h = Synth(["honkestra2","honkestra3"].wrapAt(x),nil,~z.wrapAt(x));
    h.setn(\n,n,\p,p);
    h.set(\amp,[1/2,1/2].wrapAt(x));
    h.set(\of,of);
    h.set(\freq,freq);
    h.set(\x,[2.5,2.5,2,2].wrapAt(x));  

    h.set(\gate,1);
    r=r.add(h);
  });
  r
}.value;

~r.collect({|h| h.setn(\rel,1,\gate,0)})

//henry flynt
~s = {
var n = [1,3/2,5/3,2,2/3,1], p = [1,5/3,3/2,2,2/3,3/4,1/2]*2, freq=150,of=0,r=[];
  2.do({|x|
    var h = Synth(["honkestra2","honkestra3"].wrapAt(x));
    h.setn(\n,n,\p,p);
    h.set(\amp,[1.5,1/3].wrapAt(x));
    h.set(\of,of);
    h.set(\freq,freq);
    h.set(\x,[16].wrapAt(x));  
    h.set(\gate,1);
    r=r.add(h);
  });
  r
}.value;
~s.collect({|h| h.setn(\rel,1,\gate,0)})


//minor key variant
{
~o= Synth("big-drone");
~o.setn(\p,[1/2,2/3,1,2,3,4,6,8]);
~o.setn(\n,[3/4,1,6/5,4/3,9/5,9/4,16/9]);

~o.setn(\freq,120);
~o.set(\atk,0);
~o.set(\x,3);
~o.set(\of,4);
~o.set(\gate,1);

~p= Synth("big-drone");
~p.setn(\p,[1/2,2/3,1,2,3,4,6,8]);
~p.setn(\n,[3/4,1,6/5,4/3,9/5,9/4,16/9]);
~p.setn(\freq,120);
~p.set(\of,0);
~p.setn(\gate,1);
}.value;








~migratory  = {[
  //big drone
{  ~synthFactory.("medium-drone",{|freq=120, n=#[1,2,3,4,5,6,7], p=#[1,2,3,4],x=3,of=4,m=1|
  	var a=p *.x n,
  	f=a*freq,
  	b=SinOsc,
  	r=b.ar(m/f,of/(1..f.size),b.ar(m/f.reverse,0,x,x));
b.ar(f,b.ar(f,0,pi*b.ar(1/f,r,r)),32/(f*f.log)*b.ar(a,b.ar(a,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),1))},{[-1,1]},s);
},
{
~o= Synth("medium-drone");
~o.setn(\p,[3,1,1,3]/3);
~o.setn(\n,[1,3/2,9/4,45/16,5/4,15/8,1]);
~o.set(\m,2);
~o.setn(\freq,128*3);
~o.set(\atk,1);
~o.set(\rel,1);
~o.set(\x,4);
~o.set(\amp,1/2);
~o.set(\of,0);
~o.set(\gate,1);
};
]
}
