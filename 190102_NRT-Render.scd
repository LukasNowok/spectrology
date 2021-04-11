(
var scoreList;
var serverOptions;
var oscPath;
var inputFilePath = ;
var outputFilePath = inputFilePath++".wav";
var outputImagePath = (outputFilePath ++ "_spectrogram.png").shellQuote;
var assetImagePath = (inputFilePath.dirname ++ "/docs/assets/images").shellQuote;
var assetAudioPath = (inputFilePath.dirname ++ "/docs/assets/audio").shellQuote;
var synthFunction= File.readAllString(inputFilePath).interpret;

synthFunction.asSynthDef(name: \NRTSynth).writeDefFile;

scoreList = [
	[0, [\s_new, \NRTSynth, 1000]],
	[20, [\c_set, 0, 0]]
];
serverOptions = ServerOptions.new.numOutputBusChannels_(1).memSize_(8192*64);

oscPath = PathName.tmp +/+ UniqueID.next ++ ".osc";

Score.recordNRT(
	scoreList,
	oscPath,
	outputFilePath,
	headerFormat: "WAV",
	sampleFormat: 'int32',
	options: serverOptions,
	action:{
		// generate spectrogram image
		("sox" + outputFilePath.shellQuote + "-n spectrogram -x 1024 -y 1024 -z 60 -m -r -s -w hamming -o" + outputImagePath).unixCmd
		{
			|res, pid|
			// move the generated image file to /docs/assets/images
			("mv" + outputImagePath + assetImagePath).unixCmd;
			// move the generated audio file to /docs/assets/audio
			("mv" + outputFilePath + assetAudioPath).unixCmd;
			// generate a markdown post
			[\done, res, pid].postln
		}
});
)