~e = Proto ({
  ~scales = [[1,3/2,9/4,27/8,81/16,243/32,16/3,2],
            [1/2,3/4,2,9/4,5/2,3,27/8,15/4] , 
            [1,3/2,2,9/4,5/2,8/3,3,27/8],
            [1,3/2,2,5/2,3,15/4,9/2,5]];
  ~offset = 0;
  ~pitch = 110 *6/5;
  ~tempo = 1/2;
  ~oe ={|i|[0,2,3,7,5,0].permute((~allvals/(2048)).floor.asInt).wrapAt((~allvals / 512));0};
  ~om ={|i|[1,9/4,3/2].wrapAt(~o.a.collect({|i|i.d.sum}).sum);1};
  ~so ={|i|(~o.a.collect({|i|i.xy.sum}).sum*0) + (~allvals /(~o.a.size**3))};
  ~allvals = 0;
  //leave this as a placeholder so it can be changed dynamically
  ~synthFunc = true;
  ~s = Server.default;
  ~g1 = Group.new(~s);
  ~g2 = Group.new(~s);
  ~g3 = Group.new(~s);
  ~echoPulse = Synth( "echo", nil,~g2, \addToTail );
  ~echoPhase = Synth( "echo", nil, ~g3, \addToTail );
  ~wah = Synth( "wah", nil, ~g1, \addToTail );
  ~wah2 = Synth( "wah", nil, ~g3, \addToTail );
  ~echo = Synth( "echo", nil, ~g1, \addToTail );
  ~all = Synth("all",nil, Server.internal, \addToTail);
  ~o = nil;

  ~playSine = {|note, i|
    [1,3/2].collect({|f,j|
      var s  = Synth("oto-sine", nil,~g1),h;
      ~allvals = ~allvals + 1;
      h = [1,(0..20).nthPrime.permute((i+(2**j)).asInt)[0..4]].flat;
      h = [1,3,5,7,9,11].flat;

      s.setn(\harm,h);
      ~wah.set(\rate,9/4);
      ~wah.set(\ffreq,128 * (2**~o.a.collect({|i|i.d.sum;}).sum.abs.clip(0,8)));
      s.set(\bus,6);
      s.setn(\phase,Array.fill(12, {|i|(1024+[i,0].wrapAt(i))/1024 })); 
      s.set(\freq, note);
      s.set(\atk, 1/~o.a.collect({|i|i.xy.sum}).sum);
      s.set(\sus,-2-~o.a.collect({|i|i.d.sum}).sum.abs);
      s.set(\rel, 3/4* ~tempo);
      s.set(\gate,1); 
      s.set(\amp, (1/(~o.a.size.log2+2)));
    });
  };

  ~playBass = {|note,i|
    var p;
    p= Synth("oto-bass",nil, ~g3);
    p.set(\freq,note*(2**~o.a.collect({|i|i.d.sum;}).sum.clip(-4,4)));
    ~echoPhase.set(\length,1/(note*(2**~o.a.collect({|i|i.d.sum;}).sum.clip(-2,4))));
    ~echoPulse.set(\length,~o.a.collect({|i|i.d.sum;}).sum.abs/36);
    p.set(\amp,(3/(~o.a.size.log2+2)));
    p.set(\atk,0.01/(1+~o.a.collect({|i|i.xy.sum}).sum.log2));
    p.set(\rel, (4/~o.a.collect({|i|i.xy.sum}).sum.log2) * ~tempo );
    p.set(\w,(2**(~o.a.collect({|i|i.d.sum;}).sum.clip(-6,6)* (-1))));
    p.set(\b,2**(~o.a.collect({|i|i.d.sum;}).sum));
    p.set(\k,[4.5,9].wrapAt(~o.a.collect({|i|i.xy.sum}).sum.factors.size));
  //  ~wah2.set(\rate,[4.5,9].wrapAt(~o.a.collect({|i|i.xy.sum}).sum.factors.size)/2.5);
    p.set(\sus,(-1) * (~o.a.collect({|i|i.d.sum;}).sum.abs));
    p.set(\bus,2);
    p.set(\gate,1);
    p.set(\a,0.1/~o.a.collect({|i|i.xy.sum;}).sum.abs);
  };


  ~playPulse = {|note,inval|
    var p;
    p = Synth("oto-pulse",nil, ~g2);
    p.set(\amp,(1/(~o.a.size.log+3)));
    p.set(\atk, note.log2/~o.a.collect({|i|i.xy.sum}).sum.log);
    p.set(\freq,(note) * (2**~o.a.collect({|i|i.d.sum;}).sum.clip(-2,2)));
    p.set(\w, (1/((~o.a.collect({|i|i.xy.sum}).sum+10).log10)).clip(0,1));
    p.set(\a,1.25/12);
    p.set(\gate,1);
    p.set(\bus,4);
    p.set(\rel,~o.a.collect({|i|i.xy.sum}).sum.log2 *~tempo*2);
    Routine {
      (~o.a.collect({|i|i.xy.sum}).sum.log2  *~tempo*2 ).wait;
      p.set(\gate,0);
    }.play;
  };

  ~playPhase = {|note,i|
    var p;
    p= Synth("oto-phase",nil, ~g3);
    p.set(\freq,note*(2**~o.a.collect({|i|i.d.sum;}).sum.clip(-4,4)));
    p.set(\amp,(3/(~o.a.size.log2+2)));
    p.set(\atk,0.01/(1+~o.a.collect({|i|i.xy.sum}).sum.log2));
    p.set(\rel, (1/~o.a.collect({|i|i.xy.sum}).sum.factors.size) * ~tempo );
    p.set(\w,(2**(~o.a.collect({|i|i.d.sum;}).sum.clip(-6,6)* (-1))));
    p.set(\b,2**(~o.a.collect({|i|i.d.sum;}).sum));
    p.set(\sus,-1 * ~o.a.size);

    p.set(\bus,2);
    p.set(\gate,1);
    p.set(\a,0.1/~o.a.collect({|i|i.xy.sum;}).sum.abs);
  };


  ~setup = {|oto|
    ~o = oto;
    ~all.set(\in_bus,20);
    ~all.set(\master,1/4);
    ~echoPhase.set(\length,(1/110) / (64/49));
    ~echoPhase.set(\decay,6);
    ~echoPhase.set(\in_bus,2);
    ~echoPhase.set(\out_bus,24);
    ~echoPhase.set(\wet,0);

    ~echoPulse.set(\length,10/18);
    ~echoPulse.set(\decay,6);
    ~echoPulse.set(\in_bus,2);
    ~echoPulse.set(\out_bus,22);
    ~echoPulse.set(\wet,0);

    ~wah.set(\rate,5/128);
    ~wah.set(\ffreq,1000);
    ~wah.set(\depth,127/128);
    ~wah.set(\rq,0.4);
    ~wah.set(\in_bus,6);
    ~wah.set(\out_bus,8);
    ~wah.set(\wet,1);

    ~echo.set(\length,2/9);
    ~echo.set(\decay,6);
    ~echo.set(\wet,1);
    ~echo.set(\in_bus,6);
    ~echo.set(\out_bus,20);

    ~wah2.set(\rate,9/3);
    ~wah2.set(\ffreq,8000);
    ~wah2.set(\depth,7/8);
    ~wah2.set(\rq,0.1);
    ~wah2.set(\in_bus,2);
    ~wah2.set(\out_bus,26);
    ~wah2.set(\wet,0);
    Server.default.queryAllNodes;

  };
  ~askAgain={|note, i|
    //real synth Func goes here
    ~playSine.(note,i);
  //  ~playPhase.(note,i);
    ~playBass.(note,i);
    ((~allvals %(~o.a.size**2))==0).if({
      //~playPulse.(note,i);

    });
  };
});
