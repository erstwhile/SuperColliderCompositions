{| name, func, lags, numChannels = 2 |
	SynthDef(name, {| in_bus = 0, out_bus=0, gate = 1, wet = 1|
		var in, out, env, lfo;
		in = In.ar(in_bus, numChannels);
		env = Linen.kr(gate, 2, 1, 2, 2); // fade in the effect
		out = SynthDef.wrap(func, lags, [in, env]);
		XOut.ar(out_bus, wet * env, out);
	}, [0, 0, 0.1] ).send(Server.internal);
}
