{
  ~o= Synth.new("big-drone",\target,Server.internal);
  ~o.setn(\p,[1,2,4,3/2,4,2,1].reverse/32);
  ~o.setn(\n,[1,1/2,4/3,1,2,1/2].reverse);
  ~o.set(\freq,127*32);
  ~o.set(\of,0);
  ~o.set(\x,3);
  ~o.set(\amp,1/8);

  ~o.set(\gate,1);

~p= Synth.new("big-drone",\target,Server.internal);
~p.setn(\p,[1,2,4,3/2,4,2,1]/32);
~p.setn(\n,[1,1/2,4/3,1,2,1/2]);
~p.set(\freq,128*32);
~p.set(\of,0);
~p.set(\x,3);
~p.set(\amp,1/8);

~p.set(\gate,1);



~q= Synth.new("big-drone",\target,Server.internal);
~q.setn(\p,[1,2,5/4,3/2,4,27/8,1]/32);
~q.setn(\n,[1,1/2,4/3,1,2,1/2]);
~q.set(\freq,128*32);
~q.set(\of,0);
~q.set(\x,3);
~q.set(\amp,1/8);
~q.set(\gate,1);


~qq= Synth.new("big-drone",\target,Server.internal);
~qq.setn(\p,[1,2,5/4,3/2,4,27/8,1]/32);
~qq.setn(\n,[1,1/2,4/3,1,2,1/2]);
~qq.set(\freq,127*32);
~qq.set(\of,0);
~qq.set(\x,3);
~qq.set(\amp,1/8);

~qq.set(\gate,1);


}


