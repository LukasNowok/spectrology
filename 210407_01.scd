{
	var chain = LocalBuf(1024);
	var trig = Impulse.kr(7);
	var env = EnvGen.kr(Env([0,1,1,0], [0, 0.1, 0]), trig);
	chain = FFT(chain, WhiteNoise.ar);
	chain = PV_RandComb(chain, Line.kr(0.6, 1, 20), trig);
	chain = PV_BrickWall(chain, 0.05);
	IFFT(chain) * env + SinOsc.ar(1000, 0, 0.2) ;
}