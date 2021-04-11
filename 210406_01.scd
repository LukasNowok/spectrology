{
	SinOsc.ar(Array.geom(8, 60, 2)
	* Demand.ar(Impulse.ar(8), 0, Dseq(Array.geom(9, 1, 1.25), inf))
	* XLine.ar(1, 0.7, 20)).sum * 5.reciprocal
}