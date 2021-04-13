{
	var trig = Impulse.ar(XLine.ar(1, 1000, 20));
	Saw.ar(TRand.ar(50, XLine.ar(50,5000,20), trig)) * EnvGen.ar(Env.perc(0,0.1), trig);
}