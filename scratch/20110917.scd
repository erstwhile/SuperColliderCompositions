s = Server(\backtrace,NetAddr("173.203.96.134",57110));
s.boot;
~g=Group.new(s);

s.queryAllNodes;
s.makeWindow;

   ~synthFactory.("honkestra",{|freq=128, n=#[1,2,3,4,5,6,7,8,9], p=#[1,2,3,4,5,6,7],x=3,of=1|	var a = n *.x p ,
  	b=SinOsc,
  	f=a*freq,
  	r=b.ar(1/f,a.log*of,b.ar(1/f.reverse,0,x,x));
  	b.ar(f*r.ceil,b.ar(f,0,pi*b.ar(1/f,r,r)),64/(f*f.log2)*b.ar(a,b.ar(a,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),1));  },{[-1,1]},s);


  ~synthFactory.("honkestra-t",{|freq=128, n=#[1,2,3,4,5,6,7,8,9], p=#[1,2,3,4,5,6,7],x=3,of=1|	var a = n *.x p ,
  	b=SinOsc,
  	f=a*freq,
  	r=b.ar(1/f,a.log*of,b.ar(1/f.reverse,0,x,x)),
  	t=b.ar(1/a,a.log*of,b.ar(1/a.reverse,0,x,x));

  	b.ar(f*t.ceil,b.ar(f,0,pi*b.ar(1/f,r,r)),64/(f*f.log2)*b.ar(a,b.ar(a,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),1));  },{[-1,1]},s);


s.sendMsg("/s_new","honkestra-t",~x=s.nextNodeID,1,1);
s.sendMsg("n_set",~x,"freq",120);
s.sendMsg("n_set",~x,"x",4);
s.sendMsg("n_set",~x,"of",0);
s.sendMsg("n_setn",~x,"p",7,1,2,3,4,81/32,27/8,9/4);
s.sendMsg("n_setn",~x,"n",9,2/3,1,3/2,3,4,2,27/8,1/2,9/4);
s.sendMsg("n_set",~x,"amp",1/2);
s.sendMsg("n_set",~x,"gate",1);

s.sendMsg("n_set",~x,"gate",0);





s.sendMsg("/s_new","honkestra",~x=s.nextNodeID,1,1);
s.sendMsg("n_set",~x,"freq",128);
s.sendMsg("n_set",~x,"x",3);
s.sendMsg("n_setn",~x,"p",7,(13/16),(17/16),(19/16),(23/16),29/16,31/16,37/16);
s.sendMsg("n_setn",~x,"n",9,2/3,1,2,3,4,5,6,7,8);
s.sendMsg("n_set",~x,"amp",1/2);
s.sendMsg("n_set",~x,"gate",1);

In.browse
s.scope
s.queryAllNodes





s.freeAll
s.makeWindow
  ~h.setn(\n,[2/3,1,2,3,4,5,6,7,8].flat);
  ~h.setn(\p,[13,17,19,23,29,31,37]/16);


    ~synthFactory.("ikat-yellow-lower-woven",{|a=#[1,1,1,1],t=#[128,129],xMod=1,xAdd=1,xRate=1,base=2,aExp=1|
      var x,p,h,
      e=1.exp,
      b=SinOsc;
      a=a*.x a*2;
      x=(b.ar((a**aExp) * xRate,0,xAdd,xMod)**e).tan;
      h =a *.x t;
      p =PinkNoise.ar(x.abs.log / base.log,h);
      b.ar(p,b.ar(p,0,((pi**(e/x)).sin)**x)*pi,1/64);
    },{[-1,1]/(1..4)},s);




s.sendMsg("/s_new","ikat-yellow-lower-woven",~y=s.nextNodeID,1,1);
s.sendMsg("/s_new","ikat-yellow-lower-woven",~z=s.nextNodeID,1,1);

s.sendMsg("n_setn",~y,"t",2,120,120 * 513/512);
s.sendMsg("n_set",~y,"amp",1);
s.sendMsg("n_set",~y,"base",9);
s.sendMsg("n_set",~y,"xRate",1/(3**9));
s.sendMsg("n_set",~y,"xAdd",1.exp);
s.sendMsg("n_set",~y,"aExp",1/2);
s.sendMsg("n_set",~y,"xMod",2.exp);
s.sendMsg("n_setn",~y,"a",4,3/7,21/8,2/3,16/7);
s.sendMsg("n_set",~y,"gate",1);


s.sendMsg("n_setn",~z,"t",2,120 * 513/512,120);
s.sendMsg("n_set",~z,"amp",1);
s.sendMsg("n_set",~z,"base",9);
s.sendMsg("n_set",~z,"xRate",1/(3**9));
s.sendMsg("n_set",~z,"xAdd",1);
s.sendMsg("n_set",~z,"aExp",1/2);
s.sendMsg("n_set",~z,"xMod",9/49);
s.sendMsg("n_setn",~z,"a",4,147/128,7/4,16/7,441/256);
s.sendMsg("n_set",~z,"gate",1);

s.sendMsg("n_free",~z);
s.sendMsg("n_free",~y);
s.sendMsg("n_free",~x);



 ~i=Synth("ikat-yellow-lower-woven"); ~i.setn(\a,[12/7,9/4,2/3,2]); ~i.setn(\t,[120,120*513/512]); ~i.set(\xRate,1/(3**9)); ~i.set(\xAdd,1.exp); ~i.set(\aExp,1/2); ~i.set(\xMod,2.exp); ~i.set(\gate,1); ~i.set(\base,9);  ~h=Synth("ikat-yellow-lower-woven"); ~h.setn(\a,[3/2,8/7,2,441/256]); ~h.setn(\t,[120*513/512,120]); ~h.set(\xRate,1/(3**9)); ~h.set(\xAdd,1); ~h.set(\aExp,1/2); ~h.set(\xMod,9/49); ~h.set(\gate,1); ~h.set(\base,9);  ~i.setn(\a,[3/7,21/8,2/3,16/7]); ~h.setn(\a,[147/128,7/4,16/7,441/256]);   6/7,8/7 =1:3/4 147/32:21/8 = 7:4  21/8:7/4 = 3/2:1 