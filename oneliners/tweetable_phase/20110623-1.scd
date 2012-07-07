
(a=(1..64)*.x[2,3/2,9/4,27/8];f=a*16;b=SinOsc;{Mix.ar(Pan2.ar(b.ar(f,b.ar(f,0,pi*b.ar(1/f,0,a),0),48/(f*f.log2)*b.ar(a,b.ar(a,0,pi*b.ar(1/a,0,a,0),0),1),0),[-1,1]))}.play;);

(a=(1..48)*.x[1/4,3/8,10/4,27/8];f=a*128;b=SinOsc;{Mix.ar(Pan2.ar(b.ar(f,b.ar(f,0,pi*b.ar(1/f,0,b.ar(1/a,0,a))),48/(f*f.log2)*b.ar(a,b.ar(a,0,pi*b.ar(1/a,0,b.ar(1/a,0,a))),1)),[-1,1]))}.play;);


(a=(1..64)*.x[1/4,3/8,10/4,27/8];f=a*128;b=SinOsc;{Mix.ar(Pan2.ar(b.ar(f,b.ar(f,0,pi*b.ar(1/f,0,b.ar(1/(f),0,a))),48/(f*f.log2)*b.ar(a,b.ar(a,0,pi*b.ar(1/a,0,b.ar(1/a,0,a))),1)),[-1,1]))}.play;);


(a=(1..48)*.x[1/4,3/8,10/4,27/8];f=a*128;b=SinOsc;r=b.ar(1/f,0,a);{Mix.ar(Pan2.ar(b.ar(f,b.ar(f,0,pi*b.ar(1/f,r,r)),48/(f*f.log2)*b.ar(a,b.ar(a,0,pi*b.ar(1/a,0,b.ar(1/a,0,a))),1)),[-1,1]))}.play;);


(a=(((1..32)*2))*.x[1/4,3/8,10/4,27/8];f=a*64;b=SinOsc;r=b.ar(1/f,0,a);{Mix.ar(Pan2.ar(b.ar(f,b.ar(f,0,pi*b.ar(1/f,r,r)),48/(f*f.log2)*b.ar(a,b.ar(a,0,pi*b.ar(1/a,0,b.ar(1/a,0,a))),1)),[-1,1]))}.play;);

(a=(((1..32)*2))*.x[1/4,3/8,10/4,27/8];f=a*64;b=SinOsc;r=b.ar(1/(a*8),0,a);{Mix.ar(Pan2.ar(b.ar(f,b.ar(f,0,pi*b.ar(1/f,r,r)),48/(f*f.log2)*b.ar(a,b.ar(a,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),1)),[-1,1]))}.play;);


(a=(1..6)*.x[1,3/2,10/4,27/8,9/4,3/4,15/8];f=a*64;b=SinOsc;r=b.ar(1/f,0,6);{Mix.ar(Pan2.ar(b.ar(f,b.ar(f,0,pi*b.ar(1/f,r,r)),48/(f*f.log2)*b.ar(a,b.ar(a,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),1)),[-1,1]))}.play;);

(a=(1..1)*.x[1,3/2,10/4,27/8,9/4,3/4,15/8];f=a*256;b=SinOsc;r=b.ar(1/f,0,1);{Mix.ar(Pan2.ar(b.ar(f,b.ar(f,0,pi*b.ar(1/f,r,r)),128/(f*f.log2)*b.ar(a,b.ar(a,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),1)),[-1,1]))}.play;);


(a=(1..2)*.x[1,3/2,10/4,27/8,9/4,3/4,15/8];f=a*128;b=SinOsc;r=b.ar(1/f,0,2);{Mix.ar(Pan2.ar(b.ar(f,b.ar(f,0,pi*b.ar(1/f,r,r)),96/(f*f.log2)*b.ar(a,b.ar(a,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),1)),[-1,1]))}.play;);

(a=(1..4)*.x[1,3/2,10/4,27/8,9/4,3/4,15/8];f=a*96;b=SinOsc;r=b.ar(1/f,0,4);{Mix.ar(Pan2.ar(b.ar(f,b.ar(f,0,pi*b.ar(1/f,r,r)),96/(f*f.log2)*b.ar(a,b.ar(a,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),1)),[-1,1]))}.play;);


//these 2 together
(a=(1..8)*.x[1/4,3/2,10/4,27/8,9/4,3/8,15/8];f=a*256;b=SinOsc;r=b.ar(1/a,0,a).floor;{Mix.ar(Pan2.ar(b.ar(f,b.ar(f,0,pi*b.ar(1/f,r,r)),192/(f*f.log2)*b.ar(a,b.ar(a,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),1)),[-1,1]/r.clip(1,128)))}.play;);
            

(a=(1..6)*.x[1,3/2,10/4,27/8,9/4,3/4,15/8];f=a*64;b=SinOsc;r=b.ar(1/f,0,6);{Mix.ar(Pan2.ar(b.ar(f,b.ar(f,0,pi*b.ar(1/f,r,r)),64/(f*f.log2)*b.ar(a,b.ar(a,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),1)),[-1,1]))}.play;);


(a=(1..16)*.x[2/7,2/3,16/7,3,9/4,1/3,8/7];f=a*343*2/3;b=SinOsc;r=b.ar(1/a,0,a).floor;{Mix.ar(Pan2.ar(b.ar(f,b.ar(f,0,pi*b.ar(1/f,r,r)),96/(f*f.log2)*b.ar(a,b.ar(a,r,pi*b.ar(1/a,r,b.ar(1/a,r,a))),1)),[-1,1]/r.clip(1,128)))}.play;);



(a=(1..16)*.x[1,3/2,5/2,4];f=a*32;b=SinOsc;{Mix.ar(Pan2.ar(b.ar(f,b.ar(f,0,pi*b.ar(1/f,0,4),0),48/(f*f.log2)*b.ar(a,b.ar(a,0,pi*b.ar(1/a,0,1,0),0),1),0),[-1,1]))}.play;);

(a=((3..6)*.x(3..6)).collect({|i|[2,8,4]*i/i.nextPowerOfTwo}).flat;b=Pulse;c=b.ar(1.0/a,1/a,1/a).floor;d=SinOsc.ar(1/512*1.25/a,0,1/a);play{Mix.ar(Pan2.ar(b.ar(f=a*256,d,2*c/f),c/16))});



(a=(1..64);f=a*64;b={|x,y,z|SinOsc.ar(x,y,z)};{Mix.ar(Pan2.ar(b.(f,b.(f,0,b.(1/f,0,pi*4),0),64/(f*f.log2)*b.(a,b.(1/a,0,2*pi),1)),b.(a,0,2)))}.play;)

(a=(1..9);f=(e=a*.x a)*16;b={|x,y,z|SinOsc.ar(x,y,z)};{Mix.ar(Pan2.ar(b.(f,b.(f,0,pi*b.(1/e,0,e)),1/f),b.(e/9,0,2)))}.play;)//#supercollider

(f=(32..48)*.x[2,3,5,8]/2;b={|x,y,z|SinOsc.ar(x,y,z)};{Mix.ar(Pan2.ar(b.(f,b.(f,0,b.(1/f,0,f)),1/f),b.(1/f,0,2)))}.play;)//#supercollider

(a=(2..6)*.x(3..7);a=1/a+a;b={|x,y,z|SinOsc.ar(x,y,z)};play{Mix.ar(Pan2.ar(b.(f=a*8,b.(f,0,b.(1/a,0,a).ceil),4/f),[-1,1]))})//#supercollider

(a=(2..6)*.x(3..7);a=1/a+a;b=SinOsc;c=b.ar(1/a,0,a);play{Mix.ar(Pan2.ar(b.ar(f=a*9,b.ar(f,c,c.ceil),4/f),b.ar(1/f,c,1)))})//#supercollider


(a=(2..6)*.x(3..7);a=1/a+a;b=SinOsc;c=b.ar(1/a,0,a.log2);play{Mix.ar(Pan2.ar(b.ar(f=a*32,b.ar(f,c,c.ceil),4/f),b.ar(1/f,c,1)))})//#supercollider

(a=(2..6)*.x(2..6);a=(1/a)+ a;b=SinOsc;c=b.ar(1/a,0,a.log2).floor;play{Mix.ar(Pan2.ar(b.ar((f=a*64),b.ar(f,c,c),(4*c/f)),[-1,1]))})//#supercollider



(a=((2..6)*.x(2..6)).collect({|i|[2,8,4]*i/i.nextPowerOfTwo}).flat;b=Pulse;c=b.ar(1.25/a,1/a,1/a).floor;play{Mix.ar(Pan2.ar(b.ar(f=a*256,c/a,4*c/f),[-1,0,1]/a))});



(a=((3..6)*.x(3..6)).collect({|i|[2,8,4]*i/i.nextPowerOfTwo}).flat;b=Pulse;c=b.ar(1.25/a,1/a,1/a).floor;d=SinOsc.ar(1/512*1.25/a,0,1/a);play{Mix.ar(Pan2.ar(b.ar(f=a*256,d,4*c/f),c/16))});

(a=((2..6)*.x(2..6)).collect({|i|[2,8,4]*i/i.nextPowerOfTwo}).flat;b=Pulse;c=b.ar(1.25/a,1/a,1/a).floor;d=SinOsc.ar(1.25/a,0,1/a);play{Mix.ar(Pan2.ar(b.ar(f=a*256,d,4*c/f),[-1,0,1]))});


(a=((2..6)*.x(2..6)).collect({|i|[2,8,4]*i/i.nextPowerOfTwo}).flat;b=Pulse;c=b.ar(1.25/a,1/a,1/a).floor;play{Mix.ar(Pan2.ar(b.ar(f=a*32,c/a,c/f),[-1,0,1]))});

(a=((2..6)*.x(2..6)).collect({|i|[2,8,4]*i/i.nextPowerOfTwo}).flat;b=Pulse;c=b.ar(1.25/a,1/a,1/a).floor;play{Mix.ar(Pan2.ar(b.ar(f=a*64,c/a,2*c/f),[-1,0,1]))});
(a=((2..6)*.x(2..6)).collect({|i|[2,8,4]*i/i.nextPowerOfTwo}).flat;b=Pulse;c=b.ar(1.25/a,1/a,1/a).floor;play{Mix.ar(Pan2.ar(b.ar(f=a*256,a,2*c/f),[-1,0,1]))});


(a=((2..6)*.x(2..6)).collect({|i|[2,8,4]*i/i.nextPowerOfTwo}).flat;b=Pulse;c=b.ar(1.25/a,1/a,1/a).floor;play{Mix.ar(Pan2.ar([b.ar(f=a*256,a,c/f),b.ar(f=a*256,c/a,2*c/f)].flat,[-1,0,1]))});

