(
(Document.current.dir ++ "/wavesetWaves.scd").load;
(Document.current.dir ++ "/waveset-player.scd").load;
);


(
~moves = (
	waveset: nil,
	currFunc:nil,
	holderCurrSet: nil,
	holderLeaveOneSet: nil,
	holderLeaveTwoSet: nil,
	holderTransferSetOne: nil,
	holderTransferSetTwo: nil,
	breakBottom: 9,
	breakTop: 20,
	snapShot: (),
	init: {arg self, subBufNum, files;
		self.waveset = ~waveSetPlayer.init(subBufNum, ~wavesetWaves, files);
		self.waveset.randomWave();
		self.waveset.subBuf.plot();
	},
	go: {arg self, amt;
		self.ensound(1,0.25);
		self.waveset.go(amt)
	},
	ensound: {arg self, amt, add;
		self.waveset.setAmpAmt(amt);
		self.waveset.setAmpAdd(add);
	},
	plotSub: {arg self;
		self.waveset.subBuf.plot();
	},
	randomWave:{arg self;
		self.waveset.randomWave();
	},
	silence: {arg self;
		self.ensound(0,0);
	},
	norm:{ arg self;
		self.currFunc = "norm";
		self.waveset.shouldAverage = false;
		self.waveset.waveSetAmount = {1};
		self.waveset.resetInst();
		self.waveset.repeats = {1};
		self.waveset.baseSpeed = {1};
		self.waveset.distance = {0};
		self.waveset.speedChangeModulo = self.waveset.currSet.xings.size*2;
		self.waveset.speedMod = {0};
		self.waveset.plusAmount = {0};
		self.waveset.multiplier = {1};
		self.waveset.shouldAverage = {false};
		self.waveset.shouldSwap = {false};
		self.waveset.shouldShuffle = {false};
		self.waveset.shouldDelete = {false};
		self.waveset.shouldDeletePause = {false};
		self.waveset.shouldRandomDelete = {false};
		self.waveset.shouldSub = {false};
		self.waveset.shouldReverse = {false};
		self.waveset.pan = {0};
		self.waveset.shouldPan = {false};
		self.waveset.decBreak = {false};
		self.waveset.shouldHarmonize = {false};
		self.waveset.shouldTransferOne = {false};
		self.waveset.shouldTransferTwo = {false};
		self.waveset.shouldInterleaveOne = {false};
		self.waveset.shouldInterleaveTwo = {false};
		self.waveset.shouldNormalize = {false};
		self.waveset.speedSwapModulo = {self.waveset.currSet.xings.size*2};
		self.waveset.waveSubMod = {self.waveset.currSet.xings.size*2};
		self.waveset.shouldShrink = {false};
	},
	climb: { arg self;
		self.norm();
		self.waveset.decBreak = {false};
		self.waveset.shouldInterleaveTwo = {true};
		self.waveset.interleaveTwoLevel = {2};
		self.waveset.interleaveTwoNormLevel = {2};
		self.waveset.shouldPan = {true};
		self.waveset.panNormLevel = {60};
		self.waveset.panLevel = {60};
		self.waveset.pan = {1};
		self.waveset.shouldSwap = {true};
		self.waveset.multiplier = {7.25};
		self.waveset.shouldRandomDelete = {true};
		self.waveset.deleteReceiver = {13};
		self.waveset.deleteDeviation = {4};
	},
	humm: {arg self, multiplier = 0.8, plusAmount = 0.09, harmLevel = 0.15;
		self.norm();
		self.currFunc = "humm";
		self.waveset.multiplier = {multiplier};
		self.waveset.baseSpeed = {7};
		self.waveset.plusAmount = {plusAmount};
		self.waveset.waveSetAmount = {100};
		self.waveset.shouldHarmonize = {true};
		self.waveset.harmLevel = {harmLevel};
		self.waveset.distance = {0};
	},
	rev:{arg self;
		self.norm();
		self.currFunc = "rev";
		self.waveset.shouldHarmonize = {true};
		self.waveset.harmLevel = {0.9};
		self.waveset.plusAmount = {0.0};
		self.waveset.baseSpeed = {0.3};
		self.waveset.multiplier = {4};
		self.waveset.waveSetAmount = {4};
		self.waveset.distance = {0};
	},
	blow:{arg self;
		self.norm();
		self.currFunc = "blow";
		self.waveset.multiplier = {1.25};
		self.waveset.baseSpeed = {8};
		self.waveset.waveSetAmount = {3};
		self.waveset.shouldHarmonize = {false};
		self.waveset.distance = {0.0};
		self.waveset.plusAmount = {0.05}
	},
	slurp:  {arg self, multiplier = 1;
		self.norm();
		self.currFunc = "slurp";
		self.waveset.multiplier = {multiplier};
		self.waveset.baseSpeed = {8};
		self.waveset.waveSetAmount = {10};
		self.waveset.shouldHarmonize = {true};
		self.waveset.harmLevel = {0.1};
		self.waveset.distance = {0};
		self.waveset.plusAmount = {0.2}
	},
	vasilate: {arg self;
		self.norm();
		self.currFunc = "vasilate";
		self.waveset.multiplier = {0.4};
		self.waveset.baseSpeed = {5};
		self.waveset.waveSetAmount = {70};
		self.waveset.shouldHarmonize = {true};
		self.waveset.harmLevel = {0.1};
		self.waveset.distance = {0};
		self.waveset.plusAmount = {0.0}
	},
	sayWow:{arg self, baseSpeed = 3, multiplier = 0.5;
		self.norm();
		self.currFunc = "sayWow";
		self.waveset.multiplier = {multiplier};
		self.waveset.baseSpeed = {baseSpeed};
		self.waveset.waveSetAmount = {50};
		self.waveset.shouldHarmonize = {false};
		self.waveset.distance = {0};
	},
	biter:{arg self, multiplier = 8, waveSetAmount = 10;
		self.norm();
		self.currFunc = "biter";
		self.waveset.multiplier = {multiplier};
		self.waveset.baseSpeed = {0.3};
		self.waveset.waveSetAmount = {waveSetAmount};
		self.waveset.shouldHarmonize = {true};
		self.waveset.harmLevel = {0.15};
		self.waveset.distance = {0.0};
	},
	biterSub: {arg self, multiplier = 8, waveSetAmount = 10;
		self.norm();
		self.currFunc = "biterSub";
		self.waveset.multiplier = {multiplier};
		self.waveset.baseSpeed = {0.3};
		self.waveset.waveSetAmount = {waveSetAmount};
		self.waveset.shouldHarmonize = {true};
		self.waveset.harmLevel = {0.15};
		self.waveset.distance = {0.0};
		self.waveset.subAmount = {0};
		self.waveset.shouldSub = {true};
	},
	biteSul:{arg self;
		self.currFunc = "biteSul";
		self.biter.value(12, 7);
	},
	crankThatSoulja:{arg self;
		self.norm();
		self.currFunc = "crankThatSoulja";
		self.waveset.shouldSwap = {false};
		self.waveset.shouldReverse = {false};
		self.waveset.distance = {0.025};
		self.waveset.multiplier = {2.20};
		self.waveset.baseSpeed = {2.20};
		self.waveset.plusAmount = {0.02};
		self.waveset.waveSetAmount = {17};
		self.waveset.shouldHarmonize = {false};
		self.waveset.deleteAmount = {self.waveset.currSet.xings.size};
	},
	wrinkle:{arg self;
		self.norm();
		self.crankThatSoulja.value();
		self.currFunc = "wrinkel-crank";
		self.waveset.baseSpeed = {rrand(0.4,4.8)};
		self.waveset.plusAmount = {0.1};
	},
	sputter: {arg self;
		self.norm();
		self.crankThatSoulja.value();
		self.currFunc = "sputter-crank";
		self.waveset.plusAmount = {0.02};
		self.waveset.baseSpeed = {rrand(3.2,5.8)};
	},
	circus: {arg self, bottom = 0.02, top = 0.4;
		self.norm();
		self.crankThatSoulja.value();
		self.currFunc = "circus-crank";
		self.waveset.distance = {rrand(bottom,top)};
		self.waveset.baseSpeed = {0.754};
	},
	snake: {arg self, distance = 0.025, pause = true;
		self.norm();
		self.currFunc = "snake";
		self.waveset.baseSpeed = {1};
		self.waveset.distance = {distance};
		self.waveset.multiplier = {2.25};
		self.waveset.shouldSwap = {true};
		self.waveset.shouldReverse = {true};
		self.waveset.waveSetAmount = {220};
		self.waveset.deleteAmount = {4};
		self.waveset.deletePause = {pause}
	},
	drone:  {arg self;
		self.norm();
		self.currFunc = "drone";
		self.waveset.baseSpeed = {10};
		self.waveset.shouldHarmonize = {false};
		self.waveset.distance = {0};
		self.waveset.multiplier = {40};
		self.waveset.shouldSwap = {true};
		self.waveset.shouldReverse = {false};
		self.waveset.waveSetAmount = {5};
		self.waveset.deleteAmount = {3};
		self.waveset.plusAmount = {0.2};
		self.waveset.deletePause = {false}
	},
	cook:{arg self, multiplier = 8;
		self.norm();
		self.currFunc = "cook";
		self.waveset.baseSpeed = {0.435};
		self.waveset.shouldHarmonize = {false};
		self.waveset.distance = {0.0003};
		self.waveset.multiplier = {multiplier};
		self.waveset.shouldSwap = {true};
		self.waveset.shouldReverse = {true};
		self.waveset.waveSetAmount = {3};
		self.waveset.deleteAmount = {a.currSet.xings.size};
		self.waveset.plusAmount = {0.005};
		self.waveset.deletePause = {false};
	},
	funWithNorm:{arg self;
		self.norm();
		self.waveset.waveSetAmount = {20};
		self.waveset.distance = {0.0015};
		self.waveset.baseSpeed = 0.8;
	},
	freak:{arg self;
		self.norm();
		self.currFunc = "freak";
		self.waveset.waveSetAmount = {30};
 		self.waveset.baseSpeed = 4;
		self.waveset.multiplier = 2.21;
		self.waveset.shouldSwap = true;
		self.waveset.shouldHarmonize = {false};
		self.waveset.deleteAmount = {a.currSet.xings.size};
		self.waveset.deletePause = {false};
		self.waveset.shouldReverse = {false};
		self.waveset.plusAmount = {0.02};
		self.waveset.modulateSpeed;
		self.waveset.speed2 = self.waveset.baseSpeed*3;
	},
	bleepAbout:{arg self;
		self.norm();
		self.currFunc = "bleepAbout";
		self.waveset.shouldSub = {true};
		self.waveset.waveSubMod = 80;
	},
	subZipper:{arg self;
		self.norm();
		self.currFunc = "subZipper";
		self.waveset.shouldSub = {true};
		self.waveset.subLevel = {8};
		self.waveset.subNormLevel = {5};
		self.waveset.baseSpeed = 1.5;
		self.waveset.multiplier = 5;
		self.waveset.waveSetAmount = {10}
	},
	subAndBlop:{arg self;
		self.norm();
		self.currFunc = "subAndBlop";
		self.waveset.shouldSub = {true};
		self.waveset.subLevel = {12};
		self.waveset.subNormLevel = {12};
		self.waveset.baseSpeed = 2.1;
		self.waveset.multiplier = 5.35;
		self.waveset.waveSetAmount = {10};
		self.waveset.shouldSub = {true};
		self.waveset.waveSubMod = 40;
		self.waveset.shouldSwap = true;
	},
	transferBlang:{arg self;
		self.norm();
		self.currFunc = "transferBlang";
		self.waveset.shouldTransferTwo = true;
		self.waveset.transferTwoLevel = 2;
		self.waveset.transferTwoNormLevel = 2;
		self.waveset.speedSwapModulo = 3;
		self.waveset.speedSwapAmt = 0.7;
		self.waveset.decBreak = true;
		self.waveset.baseSpeed = 0.8;
		self.waveset.multiplier = 3;
		self.waveset.breakAmount = {rrand(0.001, 0.03)};
		self.breakBottom = 20;
		self.breakTop = 80;
		self.contBreak = {true};
		self.breakSwap(0.1);
	},
	moduloSpeedChange:{arg self, modulo, modAmt, plusAmt;
		self.waveset.speedChangeModulo = {modulo};
		self.waveset.speedMod = {modAmt};
		self.waveset.plusAmount = {plusAmt};
	},
	speedSwap:{arg self, modulo, amt;
		self.waveset.speedSwapModulo = {modulo} ;
		self.waveset.speedSwapAmt = {amt};
	},
	shuffleSets:{arg self, amt;
		self.waveset.shouldShuffle = {true};
		self.waveset.shuffAmount = {amt};
	},
	deleteSets:{arg self, del, norm, pause;
		self.waveset.shouldDelete = {true};
		self.waveset.deleteLevel = {del};
		self.waveset.deleteNormLevel = {norm};
		self.waveset.shouldDeletePause = {pause};
	},
	randomDeleteSets:{arg self, rec, dev, pause;
		self.waveset.shouldRandomDelete = {true};
		self.waveset.deleteReceiver = {rec};
		self.waveset.deleteDeviation = {dev};
		self.waveset.shouldDeletePause = {pause};
	},
	subSets:{arg self, sub, norm;
		self.waveset.shouldSub = {true};
		self.waveset.subLevel = {sub};
		self.waveset.subNormLevel = {norm};
	},
	reverseSets:{arg self, rev, norm;
		self.waveset.shouldReverse = true;
		self.waveset.reverseLevel = {rev};
		self.waveset.reverseNormLevel = {norm};
	},
	harmonizeSets:{arg self, harmLevel, harmAmt, normAmt;
		self.waveset.shouldHarmonize = true;
		self.waveset.harmLevel = {harmLevel};
		self.waveset.harmonizeLevel = {harmAmt};
		self.waveset.harmonizeNormLevel = {normAmt};
	},
	transferSetsOne:{arg self, transfer, norm;
		self.waveset.shouldTransferOne = true;
		self.waveset.transferOneLevel = {transfer};
		self.waveset.transferOneNormLevel = {norm};
	},
	transferSetsTwo:{arg self, transfer, norm;
		self.waveset.shouldTransferTwo = true;
		self.waveset.transferTwoLevel = {transfer};
		self.waveset.transferTwoNormLevel = {norm};
	},
	interleaveSetsOne:{arg self, inter, norm;
		self.waveset.shouldInterleaveOne = true;
		self.waveset.interleaveOneLevel = {inter};
		self.waveset.interleaveOneNormLevel = {norm};
	},
	interleaveSetsTwo:{arg self, inter, norm;
		self.waveset.shouldInterleaveTwo = true;
		self.waveset.interleaveTwoLevel = {inter};
		self.waveset.interleaveTwoNormLevel = {norm};
	},
	normalizeSets:{arg self, alize, thresh;
		self.waveset.shouldNormalize = true;
		self.waveset.normalizeAmount = {alize};
		self.waveset.normalizeThresh = {thresh};
	},
	shrinkSets:{arg self, amt;
		self.waveset.shouldShrink = {true};
		self.waveset.shrinkAmt = {amt};
	},
	customPan:{arg self, norm, pan, dir;
		self.waveset.pan = dir;
		self.waveset.shouldPan = true;
		self.waveset.panLevel = pan;
		self.waveset.panNormLevel = norm;
	},
	customPhrase:{arg self, breakAmountBottom, breakAmountTop, breakBottom, breakTop, swapTime;
		self.waveset.decBreak = {true};
		self.contBreak = {true};
		self.waveset.breakAmount = {rrand(breakAmountBottom, breakAmountTop)};
		self.breakBottom = {breakBottom};
		self.breakTop = {breakTop};
		self.breakSwap(swapTime);
	},
	contBreak: {false},
	breakSwap:{arg self, waitAmount = 2;
		Routine({
			while({self.contBreak},{
				self.waveset.breakPointSet = {rrand(self.breakBottom, self.breakTop)};
				waitAmount.wait;
			});
			self.waveset.breakPointSet = self.breakBottom;
		}).play;
	},
	shouldScrambleSeries:{false},
	shouldPlaySeries:{false},
	playSeries:{arg self, base = 1, waitAmount = 0.5;
		var notes = [
			base,
			base + 0.5825,
			base +  0.5825 - 0.2499,
			base + 0.5825 - 0.2499 - (0.083/2),
			base + 0.5825 - 0.2499,
			base + 0.5825 - 0.2499 + 0.415,
			base - 0.2499 + 0.415
		];
		Routine({
			while({self.shouldPlaySeries},{
				notes.do({arg note;
					self.waveset.baseSpeed = note;
					waitAmount.wait;
				});
				if(self.shouldScrambleSeries(), {
					notes = notes.scramble;
				});
			});
			self.waveset.baseSpeed = base;
		}).play;
	},
	shouldPlayMode:{false},
	shouldSwitchMode:{false},
	playMode:{arg self, base = 1, waitAmount = 0.5;
		var major = [
			base,
			base + 0.083,
			base + 0.083*2,
			base + (0.083*2) + (0.083/2),
			base + (0.083*3),
			base + (0.083*4),
			base + (0.083*5),
		];
		var aeo = [
			base,
			base + 0.083,
			base + 0.083 + (0.083/2),
			base + (0.083*2),
			base + (0.083*3),
			base + (0.083*3) + (0.083/2),
			base + (0.083*5),
			base + (0.083*6),
		];
		var dor = [
			base,
			base + 0.083,
			base + (0.083*2),
			base + (0.083*2) + (0.083/2),
			base + (0.083*4),
			base + (0.083*5),
			base + (0.083*6),
			base + (0.083*6) + (0.083/2),
		];
		var minor = [
			base,
			base + 0.083,
			base + (0.083*2) + (0.083/2),
			base + (0.083*3),
			base + (0.083*4),
			base + (0.083*5),
			base + (0.083*6) + (0.083/2),
			base + (0.083*7),
		];
		var notes = [dor, aeo, minor, major];
		var useNotes = notes.choose;
		Routine({
			while({self.shouldPlayMode},{
				if(self.shouldSwitchMode, {useNotes = notes.choose});
				useNotes = [useNotes.reverse, useNotes.scramble, useNotes].choose;
				useNotes.do({arg note;
					self.waveset.baseSpeed = note;
					waitAmount.wait;
				});
			});
			self.waveset.baseSpeed = base;
		}).play;
	},
	contSpeedDirectBreak: {false},
	speedRandomDirect:{arg self, waitAmount = 0.5, speedStart, minSpeed, maxSpeed, direction = 0;
		Routine({
			var origSpeed = speedStart ?? self.waveset.baseSpeed;
			var speedMultiple;
			var i = 1;
			var defBottom = if(direction === 0, {0.7},{1.1});
			var defTop = if(direction === 0, {0.85},{1.25});
			maxSpeed = maxSpeed ?? self.waveset.baseSpeed*2;
			minSpeed = minSpeed ?? self.waveset.baseSpeed*0.25;
			while({self.contSpeedDirectBreak},{
				if(
					(
						(self.waveset.baseSpeed > (maxSpeed)) or:
						(self.waveset.baseSpeed < (minSpeed));
					), {
						self.waveset.baseSpeed = origSpeed;
					}
				);
			case
				{ ( (i%5) === 0 ) } {speedMultiple = rrand(1.05, 1.5);}
				{ ( (i%3) === 0 ) } {speedMultiple = rrand(0.6, 0.9);}
				{ ( (i%7) === 0 ) } {speedMultiple = rrand(1.15, 1.6);}
				{ ( (i%12) === 0 ) } {speedMultiple = rrand(0.5, 0.75);}
				{ ( (i%2) === 0 ) } {speedMultiple = rrand(0.85, 1.15);}
				{ true } {speedMultiple = rrand(defBottom,defTop)};
				self.waveset.baseSpeed = self.waveset.baseSpeed*speedMultiple;
				i = i + 1;
				waitAmount.wait;
			});
			self.waveset.baseSpeed = origSpeed;
		}).play;
	},
	contSpeedRandomBreak: {false},
	speedRandom:{arg self, waitAmount = 0.5, speedStart, minSpeed, maxSpeed;
		Routine({
			var origSpeed = speedStart ?? self.waveset.baseSpeed;
			var speedMultiple;
			var i = 1;
			maxSpeed = maxSpeed ?? self.waveset.baseSpeed*2;
			minSpeed = minSpeed ?? self.waveset.baseSpeed*0.25;
			while({self.contSpeedRandomBreak},{
				if(
					(
						(self.waveset.baseSpeed > (maxSpeed)) or:
						(self.waveset.baseSpeed < (minSpeed));
					), {
						self.waveset.baseSpeed = origSpeed;
					}
				);
			case
				{ ( (i%5) === 0 ) } {speedMultiple = rrand(1.05, 1.4);}
				{ ( (i%3) === 0 ) } {speedMultiple = rrand(0.6, 0.9);}
				{ ( (i%7) === 0 ) } {speedMultiple = rrand(1.15, 1.28);}
				{ ( (i%12) === 0 ) } {speedMultiple = rrand(0.5, 0.85);}
				{ ( (i%2) === 0 ) } {speedMultiple = rrand(1.1, 1.19);}
				{ true } {speedMultiple = rrand(0.9, 0.99)};
				self.waveset.baseSpeed = self.waveset.baseSpeed*speedMultiple;
				i = i + 1;
				waitAmount.wait;
			});
			self.waveset.baseSpeed = origSpeed;
		}).play;
	},
	contMultiplierDirectBreak: {false},
	multiplierRandomDirect:{arg self, waitAmount = 0.5, multiplierStart, minMultiplier, maxMultiplier, direction = 0;
		Routine({
			var origMultiplier = multiplierStart ?? self.waveset.multiplier;
			var multiplierMultiple;
			var i = 1;
			var defBottom = if(direction === 0, {0.7},{1.1});
			var defTop = if(direction === 0, {0.85},{1.25});
			maxMultiplier = maxMultiplier ?? self.waveset.multiplier*2;
			minMultiplier = minMultiplier ?? self.waveset.multiplier*0.25;
			while({self.contMultiplierDirectBreak},{
				if(
					(
						(self.waveset.multiplier > (maxMultiplier)) or:
						(self.waveset.multiplier < (minMultiplier));
					), {
						self.waveset.multiplier = origMultiplier;
					}
				);
				case
				{ ( (i%3) === 0 ) } { multiplierMultiple = rrand(0.7, 0.9);}
				{ ( (i%5) === 0 ) } { multiplierMultiple = rrand(1.05, 1.3);}
				{ ( (i%12) === 0 ) } { multiplierMultiple = rrand(0.4, 0.9);}
				{ ( (i%7) === 0 ) } { multiplierMultiple = rrand(1.15, 1.6);}
				{ ( (i%2) === 0 ) } {multiplierMultiple = rrand(0.85, 1.1);}
				{ true } {multiplierMultiple = rrand(defBottom,defTop)};
				self.waveset.multiplier = self.waveset.multiplier*multiplierMultiple;
				i = i + 1;
				waitAmount.wait;
			});
			self.waveset.multiplier = origMultiplier;
		}).play;
	},
	contMultiplierRandomBreak:{false},
	multiplierRandom: {arg self, waitAmount = 0.5, multiplierStart, minMultiplier, maxMultiplier;
		Routine({
			var origMultiplier = multiplierStart ?? self.waveset.multiplier;
			var multiplierMultiple;
			var i = 1;
			maxMultiplier = maxMultiplier ?? self.waveset.multiplier*2;
			minMultiplier = minMultiplier ?? self.waveset.multiplier*0.25;
			while({self.contMultiplierRandomBreak},{
				if(
					(
						(self.waveset.multiplier > (maxMultiplier)) or:
						(self.waveset.multiplier < (minMultiplier));
					), {
						self.waveset.multiplier = origMultiplier;
					}
				);
				case
				{ ( (i%3) === 0 ) } { multiplierMultiple = rrand(0.7, 0.9);}
				{ ( (i%5) === 0 ) } { multiplierMultiple = rrand(1.05, 1.3);}
				{ ( (i%12) === 0 ) } { multiplierMultiple = rrand(0.6, 0.8);}
				{ ( (i%7) === 0 ) } { multiplierMultiple = rrand(1.15, 1.3);}
				{ ( (i%2) === 0 ) } {multiplierMultiple = rrand(1.1, 1.35);}
				{ true } {multiplierMultiple = rrand(0.9,0.99)};
				self.waveset.multiplier = self.waveset.multiplier*multiplierMultiple;
				i = i + 1;
				waitAmount.wait;
			});
			self.waveset.multiplier = origMultiplier;
		}).play;
	},
	startFlop:{arg self;
		self.sayWow(7,2);
		self.ensound(2,2);
		self.waveset.breakAmount = {rrand(0.001, 0.05)};
		self.waveset.decBreak = true;
		self.contBreak = {true};
		self.breakBottom = 8;
		self.breakTop = 30;
		self.breakSwap(0.02);
	},
	getRhythm:{arg self;
		var breakAmtBottom, breakAmtTop;
		breakAmtBottom = rrand(0.0009,0.002);
		breakAmtTop = rrand(0.01,0.09);
		self.waveset.decBreak = true;
		self.contBreak = {true};
		self.breakBottom = 3;
		self.breakTop = 20;
		self.breakSwap(rrand(0.01,0.1));
		self.waveset.breakAmount = {rrand(breakAmtBottom, breakAmtTop)};
	},
	slowStrong:{arg self;
		var breakBottom, breakTop;
		var breakAmtBottom, breakAmtTop;
		breakAmtBottom =  rrand(0.1,1.5);
		breakAmtTop = rrand(1.65, 3.8);
		breakBottom = rrand(200,800);
		breakTop = rrand(900,1800);
		self.waveset.decBreak = true;
		self.contBreak = {true};
		self.breakBottom = breakBottom;
		self.breakTop = breakTop;
		self.breakSwap(rrand(0.01,0.8));
		self.waveset.breakAmount = {rrand(breakAmtBottom, breakAmtTop)};
	},
	changeSubWave:{arg self, waveStr;
		var wave = self.waveset.waves.waves[waveStr];
		self.waveset.subBuf.sendCollection(wave);
	},
	changeCurrSet:{arg self, waveset;
		self.holderCurrSet = self.waveset.currSet;
		self.waveset.switchSet = true;
		self.waveset.switchToSet = waveset;
	},
	changeLeaveOneSet:{arg self, waveset;
		self.holderLeaveOneSet = self.waveset.leaveOneSet;
		self.waveset.leaveOneSet = waveset;
	},
	changeLeaveTwoSet:{arg self, waveset;
		self.holderLeaveTwoSet = self.waveset.leaveTwoSet;
		self.waveset.leaveTwoSet = waveset;
	},
	changeTransferSetOne:{arg self, waveset;
		self.holderTransferSetOne = self.waveset.transferSetOne;
		self.waveset.transferSetOne = waveset;
	},
	changeTransferSetTwo:{arg self, waveset;
		self.holderTransferSetTwo = self.waveset.transferSetTwo;
		self.waveset.transferSetTwo = waveset;
	},
	returnCurrSet:{arg self;
		self.waveset.currSet = self.holderCurrSet;
	},
	returnLeaveOneSet:{arg self;
		self.waveset.leaveOneSet = self.holderLeaveOneSet;
	},
	returnLeaveTwoSet:{arg self;
		self.waveset.leaveTwoSet = self.holderLeaveTwoSet;
	},
	returnTransferSetOne:{arg self;
		self.waveset.transferSetOne = self.holderTransferSetOne;
	},
	returnTransferSetTwo:{arg self;
		self.waveset.transferSetTwo = self.holderTransferSetTwo;
	},
	takeSnapshot:{arg self;
		self.snapShot.currFunc = self.currFunc;
		self.snapShot.shouldAverage = self.waveset.shouldAverage;
		self.snapShot.inst = self.waveset.inst;
		self.snapShot.waveSetAmount = self.waveset.waveSetAmount;
		self.snapShot.repeats = self.waveset.repeats;
		self.snapShot.baseSpeed = self.waveset.baseSpeed;
		self.snapShot.distance = self.waveset.distance;
		self.snapShot.speedChangeModulo = self.waveset.speedChangeModulo;
		self.snapShot.speedMod = self.waveset.speedMod;
		self.snapShot.plusAmount = self.waveset.plusAmount;
		self.snapShot.multiplier = self.waveset.multiplier;
		self.snapShot.shouldAverage = self.waveset.shouldAverage;
		self.snapShot.shouldSwap = self.waveset.shouldSwap;
		self.snapShot.shouldShuffle = self.waveset.shouldShuffle;
		self.snapShot.shuffAmount = self.waveset.shuffAmount;
		self.snapShot.shouldDelete = self.waveset.shouldDelete;
		self.snapShot.deleteLevel = self.waveset.deleteLevel;
		self.snapShot.deleteNormLevel = self.waveset.deleteNormLevel;
		self.snapShot.shouldDeletePause = self.waveset.shouldDeletePause;
		self.snapShot.shouldRandomDelete = self.waveset.shouldRandomDelete;
		self.snapShot.deleteReceiver = self.waveset.deleteReceiver;
		self.snapShot.deleteDeviation = self.waveset.deleteDeviation;
		self.snapShot.shouldSub = self.waveset.shouldSub;
		self.snapShot.subLevel = self.waveset.subLevel;
		self.snapShot.subNormLevel = self.waveset.subNormLevel;
		self.snapShot.shouldReverse = self.waveset.shouldReverse;
		self.snapShot.reverseLevel = self.waveset.reverseLevel;
		self.snapShot.reverseNormLevel = self.waveset.reverseNormLevel;
		self.snapShot.pan = self.waveset.pan;
		self.snapShot.shouldPan = self.waveset.shouldPan;
		self.snapShot.panLevel = self.waveset.panLevel;
		self.snapShot.panNormLevel = self.waveset.panNormLevel;
		self.snapShot.decBreak = self.waveset.decBreak;
		self.snapShot.contBreak = self.contBreak;
		self.snapShot.breakBottom = self.breakBottom;
		self.snapShot.breakTop = self.breakTop;
		self.snapShot.shouldHarmonize = self.waveset.shouldHarmonize;
		self.snapShot.harmLevel = self.waveset.harmLevel;
		self.snapShot.harmonizeLevel = self.waveset.harmonizeLevel;
		self.snapShot.harmonizeNormLevel = self.waveset.harmonizeNormLevel;
		self.snapShot.shouldTransferOne = self.waveset.shouldTransferOne;
		self.snapShot.transferOneLevel = self.waveset.transferOneLevel;
		self.snapShot.transferOneNormLevel = self.waveset.transferOneNormLevel;
		self.snapShot.shouldTransferTwo = self.waveset.shouldTransferTwo;
		self.snapShot.transferTwoLevel = self.waveset.transferTwoLevel;
		self.snapShot.transferTwoNormLevel = self.waveset.transferTwoNormLevel;
		self.snapShot.shouldInterleaveOne = self.waveset.shouldInterleaveOne;
		self.snapShot.interleaveOneLevel = self.waveset.interleaveOneLevel;
		self.snapShot.interleaveOneNormLevel = self.waveset.interleaveOneNormLevel;
		self.snapShot.shouldInterleaveTwo = self.waveset.shouldInterleaveTwo;
		self.snapShot.interleaveTwoLevel = self.waveset.interleaveTwoLevel;
		self.snapShot.interleaveTwoNormLevel = self.waveset.interleaveTwoNormLevel;
		self.snapShot.shouldNormalize = self.waveset.shouldNormalize;
		self.snapShot.normalizeAmount = self.waveset.normalizeAmount;
		self.snapShot.normalizeThresh = self.waveset.normalizeThresh;
		self.snapShot.speedSwapModulo = self.waveset.speedSwapModulo;
		self.snapShot.speedSwapAmt = self.waveset.speedSwapAmt;
		self.snapShot.waveSubMod = self.waveset.waveSubMod;
		self.snapShot.shouldShrink = self.waveset.shouldShrink;
		self.snapShot.shrinkAmt = self.waveset.shrinkAmt;
	},
	showSnapshot:{arg self;
		self.snapShot.keys.asList.copyRange(0, self.snapShot.keys.size - 1).do({arg prop;
			[prop.asString + " : " +  self.snapShot[prop.asSymbol].asString].postln;
		});
	}
)
);



~currDir = Document.current.dir;
~files = (
	\currSet : ~currDir ++ "/files/" ++ "waveset-gendy1-short.wav",
	\leaveOneSet : ~currDir ++ "/files/" ++ "sticky-bells-1.aif",
	\leaveTwoSet : ~currDir ++ "/files/" ++ "sticky-noise.aif",
	\transferSetOne : ~currDir ++ "/files/" ++ "clear-sound.aif",
	\transferSetTwo : ~currDir ++ "/files/" ++ "sqr-long.aif",
);

~moves.init(20, ~files);
Synth(\eq,addAction:\addToTail);

