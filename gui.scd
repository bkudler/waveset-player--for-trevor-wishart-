s.options.memSize = 128 * (1024*16);
s.options.sampleRate = 48000;

Platform.systemExtensionDir;
// -> /Library/Application Support/SuperCollider/Extensions

~currDir = Document.current.dir;
~files = (
	\currSet : ~currDir ++ "/files/" ++ "waveset-gendy1-short.wav",
	\leaveOneSet : ~currDir ++ "/files/" ++ "sticky-bells-1.aif",
	\leaveTwoSet : ~currDir ++ "/files/" ++ "sticky-noise.aif",
	\transferSetOne : ~currDir ++ "/files/" ++ "clear-sound.aif",
	\transferSetTwo : ~currDir ++ "/files/" ++ "sqr-long.aif",
);

~moves = WavesetTransformerPlayer(20,~files);


~moves.takeSnapshot();
~moves.showSnapshot();

// (Document.current.dir ++ "/moves.scd").load;

// ~moves.changeCurrSet(Wavesets.from("/Users/bkudler/SuperColliderstuffz/wavesets/waveset-player--for-trevor-wishart-/files/don't-ever.aif"));

// ~moves.changeCurrSet(Wavesets.from("/Users/bkudler/SuperColliderstuffz/wavesets/waveset-player--for-trevor-wishart-/files/clear-sound.aif"));

//perform a piece of music for 8.0 minutes and 17.0 seconds of busy style with frantic sections.


~moves.crankThatSoulja();
~moves.waveset.shouldDeletePause = {true};
~moves.waveset.shouldDeletePause = {false};
~moves.waveset.shouldDelete = false;
~moves.deleteSets(5,20,true);
~moves.shrinkSets(0.5);

~moves.drone();
// breakAmountBottom, breakAmountTop, breakBottom, breakTop, swapTime;
~moves.customPhrase(0.01,0.2,9,40,0.01);
~moves.contBreak = {false};
~moves.waveset.decBreak = false;
~moves.ensound(2,2);


~moves.waveset.shouldInterleaveTwo
~moves.go(500).play;
Synth(\eq,addAction:\addToTail);

~moves.waveset.baseSpeed = {3};
~moves.waveset.multiplier = {3};
~moves.waveset.waveSetAmount = {20}


~moves.customPan(110,500,1);
~moves.norm();

~moves.rev();

~moves.randomWave();
~moves.norm();
~moves.plotSub();
~moves.ensound(1,3);


~moves.waveset.waves.showKeys();
~moves.subAndBlop();
~moves.subZipper();
~moves.transferBlang()
~moves.changeSubWave('badStocks');

~moves.subAndBlop();
~moves.waveset.baseSpeed = 17.5;
~moves.customPan(240,720,0);




~waveSetPlayer.speedChangeModulo = 5;
~waveSetPlayer.speedMod = 30;
~waveSetPlayer.plusAmount = 0.02;
~waveSetPlayer.speedChangeModulo = ~moves.waveset.currSet.xings.size;

~waveSetPlayer.speedSwapModulo = 3;
//higher numbers is faster. lower slower
~waveSetPlayer.speedSwapAmt = 3;
~waveSetPlayer.speedSwapModulo = ~moves.waveset.currSet.xings.size;

~moves.waveset.shouldSwap = true

~moves.ensound(1,2);
~moves.waveset.multiplier = {7.25};
~moves.norm();
~moves.rev();
~moves.crankThatSoulja();
~moves.ensound(1,2);



~waveSetPlayer.shouldTransferOne = true;
~waveSetPlayer.transferOneLevel = 20;
~waveSetPlayer.transferOneNormLevel = 20;
~waveSetPlayer.shouldTransferOne = false;

~waveSetPlayer.shouldTransferTwo = true;
~waveSetPlayer.transferTwoLevel = 2;
~waveSetPlayer.transferTwoNormLevel = 20;
~waveSetPlayer.shouldTransferTwo = false;





~moves.waveset.modulateSpeed();
~moves.waveset.speed2 = ~moves.waveset.baseSpeed*0.9;
~moves.waveset.resetInst();

~moves.waveset.waveSetAmount = {5};
~moves.waveset.waveSetAmount = {rrand(1,70)};
~moves.waveset.waveSetAmount = {gauss(30,0.2).asInteger};
~moves.waveset.waveSetAmount;

~moves.waveset.shouldHarmonize = true;
~moves.waveset.harmLevel = {gauss(0.8,0.0019)};
~moves.waveset.harmLevel = 0.3;
~moves.waveset.harmonizeLevel = 2;
~moves.waveset.harmonizeNormLevel = 0;
~moves.waveset.shouldHarmonize = false;

~moves.waveset.breakPointSet = 800;
~moves.waveset.breakPointSet;
~moves.waveset.decBreak = true;
~moves.waveset.decBreak = false;
~moves.silence;
~moves.ensound(1, 1);
~moves.ensound(1, 4);
~moves.waveset.breakAmount = {rrand(rrand(0.005,0.007), rrand(0.03,0.02))};
~moves.waveset.breakAmount = {rrand(0.0001, 0.02)};
~moves.waveset.breakAmount = {rrand(2.5,3.25)};
~moves.waveset.breakAmount = 0.0001;
~moves.waveset.breakAmount;
~moves.breakBottom = 1;
~moves.breakTop = 90;
~moves.contBreak = {true};
~moves.contBreak = {false};
~moves.breakSwap(0.1);




~moves.contMultiplierDirectBreak = {false};
~moves.contMultiplierDirectBreak = {true};
~moves.multiplierRandomDirect(0.01, nil, 0.7,  4, 1);

~moves.contMultiplierRandomBreak = {false};
~moves.contMultiplierRandomBreak = {true};
~moves.multiplierRandom(0.05, nil, 3, 4);

~moves.contSpeedDirectBreak = {false};
~moves.contSpeedDirectBreak = {true};
~moves.speedRandomDirect(3, nil, 3, 15, 1);

~moves.contSpeedRandomBreak = {false};
~moves.contSpeedRandomBreak = {true};
~moves.speedRandom(1, nil, 2, 3);

~moves.shouldPlaySeries = {false};
~moves.shouldPlaySeries = {true};
~moves.playSeries(8, 0.5);
~moves.shouldScrambleSeries = {true};
~moves.shouldScrambleSeries = {false};

~moves.shouldPlayMode = {false};
~moves.shouldPlayMode = {true};
~moves.playMode(10, 3);
~moves.shouldSwitchMode = {false};
~moves.shouldSwitchMode = {true};


