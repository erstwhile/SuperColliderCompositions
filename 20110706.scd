	~s2.set(\of,1);
	~s2.set(\m,1);
	~s4.set(\of,1);
	~s4.set(\m,1);
	~s2.set(\p,3);
	~s4.set(\p,3);
	~s2.set(\amp,4/4);
	~s4.set(\amp,4/4);
	~s2.set(\fm,4);	
	~s2.set(\fa,3/3);	
	~s4.set(\fm,4);	
	~s4.set(\fa,3/3);	
	
	~s2.setn(\n,[2,4,8,16,3,6,9]*15/16);
	~s4.setn(\n,[1,2,3,4]*15/16);
	~s4.set(\gate,1);
	~s2.set(\gate,1);
	~s2.set(\freq,128*2);
	~s4.set(\freq,128*2);

~ss4.set(\amp,0);
~ss2.set(\amp,0);

	~s8 =Synth("simple-phase8");
	~s8.set(\freq,256*2);
	~s8.setn(\n,1/128*[16,18,20,24,30,32,36]*15/16);
	~s8.set(\of,1);
	~s8.set(\p,8);
	~s8.set(\aa,0);
	~s8.set(\am,2);
	~s8.set(\amp,0.15);
	~s8.set(\gate,0);


	~s9 =Synth("simple-phase8");
	~s9.set(\freq,256*3);
	~s9.setn(\n,1/128*[12,20,24,27,45/2,32,18]*15/16);
	~s9.set(\of,1);
	~s9.set(\p,8);
	~s9.set(\aa,0);
	~s9.set(\am,2);
	~s9.set(\amp,0.75);
	~s9.set(\gate,1);

	