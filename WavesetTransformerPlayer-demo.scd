s.options.memSize = 128 * (1024*16);
s.options.sampleRate = 48000;

//package into quark
//use this file and WavesetTransformer-demo as help files


~currDir = Document.current.dir;
~files = (
	\currSet : ~currDir ++ "/files/" ++ "waveset-gendy1-short.wav",
	\leaveOneSet : ~currDir ++ "/files/" ++ "sticky-bells-1.aif",
	\leaveTwoSet : ~currDir ++ "/files/" ++ "sticky-noise.aif",
	\transferSetOne : ~currDir ++ "/files/" ++ "clear-sound.aif",
	\transferSetTwo : ~currDir ++ "/files/" ++ "sqr-long.aif",
);

~moves = WavesetTransformerPlayer(20,~files);


(
//send a random wave from the waves you injected into waveSetPlayer to the subBuf so you have waveforms to substitute in later... just trust me.
~moves.randomWave();
//plot it;
~moves.plotSub()
)


~moves.changeSubWave('sqr');

//start playing the wavesets from your current waveset signal back
Synth(\eq,addAction:\addToTail);
~moves.go(1).play;
//I added in a basic limiter for convenience, everything is routed through it, you can change how it works in the other file or you can change the out of the waveset SynthDefs and then do whatever you want.
~waveSetPlayer.out = 5;

~moves.changeCurrSet(Wavesets.from("/Users/bkudler/SuperColliderstuffz/wavesets/waveset-player--for-trevor-wishart-/files/don't-ever.aif"));
~moves.waveset.switchSet = false;
~moves.returnCurrSet();

~moves.changeCurrSet(Wavesets.from("/Users/bkudler/dys-garb.aif"));

~moves.changeLeaveOneSet(Wavesets.from(~files.leaveTwoSet));
~moves.returnLeaveOneSet();

~moves.changeLeaveTwoSet(Wavesets.from(~files.leaveOneSet));
~moves.returnLeaveTwoSet();

~moves.changeTransferSetOne(Wavesets.from(~files.transferSetOne));
~moves.returnTransferSetOne();

~moves.changeTransferSetTwo((Wavesets.from(~files.leaveOneSet));
~moves.returnTransferSetTwo();

//change the instrument being used to play the individual wavesets, this will modulate the starting point as each waveset is being played
~moves.waveset.modulateStart();
//frequency of modulation
~moves.waveset.startModFreq = 0.2;
//the range of modulation, 1 is modulation from current starting point to current start + current start to current start - current start. 0.5 is is modulation from current start to currentStart + current start * 0.5 to currentStart - current start * 0.5 etc...
~moves.waveset.startAmt = 1.5;

//change the instrument being used to play the individual wavesets, this will modulate the speed of the waveset as each is being played
~moves.waveset.modulateSpeed();
~moves.waveset.speed2 = 10.5;

//both speed and start modulation
~moves.waveset.moduleSpeedPlusStart();

//back to regular instrument
~moves.waveset.resetInst();

~moves.waveset.baseSpeed = 3;
~moves.waveset.baseSpeed.value();

//change the amount of wavesets played for every waveset, so play 5 wavesets in the space of 1 waveset.
~moves.waveset.waveSetAmount = {200};
~moves.waveset.waveSetAmount = {1};

~moves.waveset.multiplier = {3};
~moves.waveset.multiplier = {1};


~moves.waveset.shouldAverage = true;
~moves.waveset.averageModulo = 5;
//back to normal
~moves.waveset.shouldAverage = false;

~moves.waveset.shouldSwap = true;
~moves.waveset.multiplier = {3.0};
~moves.waveset.shouldSwap = false;
~moves.waveset.multiplier = {1};

//set volume (multiply, add);
~moves.ensound(1,2);
//no sound
~moves.silence()

//everything back to normal
~moves.norm();

~moves.waveset.speedSwapModulo = 5;
~moves.waveset.speedSwapAmt = 3;
~moves.waveset.shouldShuffle = true;
~moves.waveset.shuffAmount = 60;
~moves.waveset.modulateStart();
~moves.waveset.waveSetAmount = {30};


~moves.norm();


//PRESETS
//THE FOLLOWING ARE DIFFERENT COMBINATIONS OF TRNASFORMATIONS I HAVE FOUND COOL:
~moves.climb();

//multiplier, plusAmount, harmLevel
~moves.humm();
~moves.humm(0.3, 0.5, 0.8);
~moves.humm(2, 0.1, 0.9);

~moves.rev();

~moves.blow();

//multiplier
~moves.slurp();
~moves.slurp(1);
~moves.slurp(4);
~moves.slurp(0.8);

~moves.vasilate();

//baseSpeed. multiplier
~moves.sayWow();
~moves.sayWow(10,3);
~moves.sayWow(7,0.8);
~moves.sayWow(rrand(2,9),0.2);
~moves.sayWow(rrand(3,8), 2.25);
~moves.sayWow(rrand(3,8), 0.5);

//multiplier, waveSetAmount
~moves.biter();
~moves.biter(3,20);
~moves.biter(10,20);
~moves.biter(10,10);
~moves.biter(12,7);


//multiplier, waveSetAmount
~moves.biterSub()
~moves.biterSub(3,20);
~moves.biterSub(10,20);
~moves.biterSub(10,10);

~moves.crankThatSoulja();

~moves.wrinkle();

~moves.sputter();

~moves.drone();

~moves.cook();

~moves.funWithNorm();

~moves.freak();

~moves.bleepAbout();

~moves.subZipper();

~moves.subAndBlop();

~moves.transferBlang();

~moves.norm();


//convenience wrapper for doing modulo speed change stuff. instead of having to assign the modulo, modamt, and plusAmt separetly can do it all at once
~moves.moduloSpeedChange(3,5,0.01);
~moves.moduloSpeedChange(2,20,0.01);
~moves.moduloSpeedChange(2,40,0.01);
~moves.moduloSpeedChange(10,20,0.05);

//convenience wrapper for speedSwapping, same as above, but with speed swapping
~moves.speedSwap(3, 0.5);
~moves.speedSwap(2, 4.5);
~moves.speedSwap(10, 13);

//convenience for shuffling wavesets, just have to give an amount
~moves.shuffleSets(10);
~moves.shuffleSets(60);
~moves.norm();

//conveninece for deleting setts, just have to give delete amount, norm amount, and if you want to pause for each delete amount.
~moves.deleteSets(3,3,false);
~moves.deleteSets(3,3,true);
~moves.deleteSets(30,3,true);

//the following are all convenience methods for what the name of the method would apply

~moves.randomDeleteSets(4,3,true);
~moves.randomDeleteSets(2,1,false);

~moves.subSets(3,3);
~moves.subSets(20,30);
~moves.subSets(20,0);
~moves.subSets(3,0);
~moves.norm();

~moves.reverseSets(5,5);
~moves.reverseSets(5,0);
~moves.reverseSets(10,10);

~moves.harmonizeSets(0.8,3,3);
~moves.harmonizeSets(0.2,3,0);
~moves.harmonizeSets(0.2,3,2);

~moves.transferSetsOne(3,3);
~moves.transferSetsOne(3,0);

~moves.transferSetsTwo(3,3);
~moves.transferSetsTwo(3,0);

~moves.interleaveSetsOne(3,3);
~moves.interleaveSetsOne(1,1);

~moves.interleaveSetsTwo(3,3);
~moves.interleaveSetsTwo(3,1);
~moves.interleaveSetsTwo(1,1);

~moves.normalizeSets(3,0.5);
~moves.normalizeSets(2,0.1);
~moves.normalizeSets(8,0.9);

~moves.shrinkSets(2);
~moves.shrinkSets(0.5);
~moves.norm();


~moves.customPan(2,2,-1);
~moves.customPan(90,90,-1);
~moves.customPan(500,90,1);
~moves.customPan(90,3,1);
~moves.customPan(90,3,0);

//THIS ALLOWS FOR SETTING A CRUDE AMPLITUDE ENVELOPE ON THE TRAIN OF WAVESETS WITH PHRASING
//minimum waittime before starting train again, maximum waittime before starting train again, minimum of amount wavesets to play, max amount of wavesets to play, amount of time before changing amountof wavesets
~moves.customPhrase(0.001,0.4,90,220,0.1);
~moves.contBreak = false;
~moves.customPhrase(0.001, 0.8, 100, 900, 0.1);
~moves.contBreak = false;
~moves.customPhrase(0.005,1, 50,550, 4);

~moves.waveset.decBreak = false;
~moves.ensound(1,5);


//plays a specific and idiomatic series that I amde starting on a certain playback speed
~moves.playSeries(2,0.01);
~moves.playSeries(5,0.1);
~moves.playSeries(5,1);
~moves.shouldScrambleSeries = true;
~moves.shouldScrambleSeries = false;
~moves.shouldPlaySeries = false;

//play a random one of the following scales/modes: major, minor, aeolian, and dorian. Doesn't really work, but can be cool depending on the sound file you are working with.
~moves.playMode(2,0.01);
~moves.playMode(5,0.1);
~moves.playMode(0.8,1);
~moves.shouldSwitchMode = false;
~moves.shouldPlayMode = false;


//randomly change the speed leaning towards higher or lower, 1 as the last argument is lean towards going higher, 0 is lean towards going lower.
~moves.speedRandomDirect(0.01,3,2,5,1);
~moves.speedRandomDirect(0.1,0.8,2,5,1);
~moves.speedRandomDirect(1,5,2,10,0);
~moves.speedRandomDirect(0.1,3,2,5,1);
~moves.speedRandomDirect(0.1,3,2,5,0);
~moves.norm();
//same as above but with no choice in leaning to go up or down
~moves.speedRandom(0.1,3,2,5);
~moves.speedRandom(1,5,2,10);
~moves.speedRandom(0.1,0.8,2,5);


//same as speedRandomDirect but with mulitiplier
~moves.multiplierRandomDirect(0.01,3,2,5,1);
~moves.multiplierRandomDirect(0.1,0.8,2,5,1);
~moves.multiplierRandomDirect(1,5,2,10,0);
~moves.multiplierRandomDirect(0.1,3,2,5,1);
~moves.multiplierRandomDirect(0.1,3,2,5,0);


//same as above but with no choice in leaning to go up or down
~moves.multiplierRandom(0.1,3,2,5);
~moves.multiplierRandom(1,5,2,10);
~moves.multiplierRandom(0.1,0.8,2,5);
~moves.norm();

//hey just try it.
~moves.startFlop();

~moves.norm();
//these are phrase based, meaning they will make different amplitude based patterns or phrases
~moves.getRhythm();
~moves.slowStrong();

//okay, so say you got some nice situation and everything is sounding good, you want to know what everything is so that you can use it for later or even add it in is as your own preset.... well...
~moves.takeSnapshot();
//this will save everything in a dictionary on your WavesetTransformerPlayer called snapshot... okay that's too complicated, just give me the info
~moves.showSnapshot();
//you can't have more than one snapshot at once, sadly, but you can also just do...
~tempSnapShot = Event.newFrom(~moves.snapShot);
//then when you are ready to pretty print it just do
~moves.snapShot = ~tempSnapShot;
~moves.showSnapshot();


