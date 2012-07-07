(a=(1..16)*.x[1,3/2,5/2,4];f=a*32;{Mix.ar(Pan2.ar(SinOsc.ar(f,SinOsc.ar(f,0,pi*SinOsc.ar(1/f,0,4),0),64/(f*f.log2)*SinOsc.ar(a,SinOsc.ar(a,0,pi*SinOsc.ar(1/a,0,1,0),0),1),0),[-1,1]))}.play;)

(a=(1..64);f=a*64;b={|x,y,z|SinOsc.ar(x,y,z)};{Mix.ar(Pan2.ar(b.(f,b.(f,0,b.(1/f,0,pi*4),0),64/(f*f.log2)*b.(a,b.(1/a,0,2*pi),1)),b.(a,0,2)))}.play;)

(a=(1..9);f=(e=a*.x a)*16;b={|x,y,z|SinOsc.ar(x,y,z)};{Mix.ar(Pan2.ar(b.(f,b.(f,0,pi*b.(1/e,0,e)),1/f),b.(e/9,0,2)))}.play;)//#supercollider

(f=(32..48)*.x[2,3,5,8]/2;b={|x,y,z|SinOsc.ar(x,y,z)};{Mix.ar(Pan2.ar(b.(f,b.(f,0,b.(1/f,0,f)),1/f),b.(1/f,0,2)))}.play;)//#supercollider

(a=(2..6)*.x(3..7);a=1/a+a;b={|x,y,z|SinOsc.ar(x,y,z)};play{Mix.ar(Pan2.ar(b.(f=a*9,b.(f,0,b.(1/a,0,a).ceil),4/f),[-1,1]))})//#supercollider

(a=(2..6)*.x(3..7);a=1/a+a;b=SinOsc;c=b.ar(1/a,0,a);play{Mix.ar(Pan2.ar(b.ar(f=a*9,b.ar(f,c,c.ceil),1/f),b.ar(1/f,c,1)))})//#supercollider


(a=(2..6)*.x(3..7);a=1/a+a;b=SinOsc;c=b.ar(1/a,0,a.log2);play{Mix.ar(Pan2.ar(b.ar(f=a*32,b.ar(f,c,c.ceil),1/f),b.ar(1/f,c,1)))})//#supercollider

(a=(2..6)*.x(2..6);a=(1/a)+ a;b=SinOsc;c=b.ar(1/a,0,a.log2).floor;play{Mix.ar(Pan2.ar(b.ar((f=a*64),b.ar(f,c,c),(c/f)),[-1,1]))})//#supercollider

(a=((2..6)*.x(2..6)).collect({|i|[2,8,4]*i/i.nextPowerOfTwo}).flat;b=Pulse;c=b.ar(1.25/a,1/a,1/a).floor;play{Mix.ar(Pan2.ar(b.ar(f=a*256,c/a,4*c/f),[-1,0,1]/a))});


(a=((2..6)*.x(2..6)).collect({|i|[2,8,4]*i/i.nextPowerOfTwo}).flat;b=Pulse;c=b.ar(1.25/a,1/a,1/a).floor;d=SinOsc.ar(1.25/a,1/a,1/a);play{Mix.ar(Pan2.ar(b.ar(f=a*256,d,4*c/f),[-1,0,1]/a))});

(a=((2..6)*.x(2..6)).collect({|i|[2,8,4]*i/i.nextPowerOfTwo}).flat;b=Pulse;c=b.ar(1.25/a,1/a,1/a).floor;play{Mix.ar(Pan2.ar(b.ar(f=a*256,c/a,2*c/f),[-1,0,1]))});


(a=((2..6)*.x(2..6)).collect({|i|[2,8,4]*i/i.nextPowerOfTwo}).flat;b=Pulse;c=b.ar(1.25/a,1/a,1/a).floor;play{Mix.ar(Pan2.ar([b.ar(f=a*256,a,c/f),b.ar(f=a*256,c/a,2*c/f)].flat,[-1,0,1]))});


//tweeted
(f=(2048..2056)*.x[2,3,5,8]/32;b={|x,y,z|SinOsc.ar(x,y,z)};{Mix.ar(Pan2.ar(b.(f,b.(f,0,b.(1/f,0,f)),1/f),b.(1/f,0,1)))}.play)
//tweeted
a=(2..6)*.x(3..7);a=1/a+a;b={|x,y,z|SinOsc.ar(x,y,z)};play{Mix.ar(Pan2.ar(b.(f=a*9,b.(f,0,b.(1/a,0,a).ceil),4/f),[-1,1]))}
#supercollider


(f=(2048..2056)*.x[2,3,5,8]/256;b={|x,y,z|Blip.ar(x,y,z)};{Mix.ar(Pan2.ar(b.(f,b.(f,0,b.(1/f,0,f)),1/f),b.(1/f,0,1)))}.play;)//#supercollider
//b.(a,0,pi*b.(1/a,0,1))

01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789

(b={|x,y,z|SinOsc.ar(x,y,z)};{Mix.ar(Pan2.ar(b.(f=(c=(a=(1..8))*.x a)*32,b.(f,0,pi*b.(1/f,0,4)),(8/f)*b.(c,b.(c,0,pi*b.(1/c,0,1),0),1)),[-1,1]))}.play)

