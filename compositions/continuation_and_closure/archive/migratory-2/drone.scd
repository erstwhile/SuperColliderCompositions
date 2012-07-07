{
/*
~o= Synth("big-drone");
~o.setn(\p,[1/2,2/3,1,2,3,4,6,8]);
~o.setn(\n,[3/4,1,6/5,4/3,9/5,9/4,16/9]);

~o.setn(\freq,120);
~o.set(\atk,0);
~o.set(\x,3);
~o.set(\of,4);
~o.set(\gate,0);
*/
~p= Synth.new("big-drone",\target,Server.internal);
~p.setn(\p,[1,4/3,3/2,2,8/3,3,4]/8);
~p.setn(\n,[1,3/8,4/3,3/2,2/3,1/4]);
~p.set(\freq,128*16);
~p.set(\of,0);
~p.set(\x,4);
~p.set(\amp,1/12);

~p.set(\gate,1);
}
