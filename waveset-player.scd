
(
~waveSetPlayer = (

	\currSet : nil,

	\leaveOneSet : nil,

	\leaveTwoSet : nil,

	\transferSetOne : nil,

	\transferSetTwo : nil,

	\switchSet : false,

	\switchToSet : {arg self; self.currSet},

	\subBuf : nil,

	\startModFreq : {0.5},

	\startAmt : {0.2},

	\mainOut: {0},

	\out : {5},`

	\waves : (),

	\init : {arg self, subBufNum, waves, files;
		var buf = Buffer.alloc(s, 512,bufnum:subBufNum);

		SynthDef(\eq, {

			var limiter = Limiter.ar(In.ar(self.out,2), 0.85);

			Out.ar(self.mainOut, limiter);
		}).add;

		Wavesets.prepareSynthDefs;

		SynthDef(\wstSTM, { | out = 0, buf = 0, start = 0, length = 441, playRate = 1, sustain = 1, amp = 0.2, pan, startModFreq =0.5, startAmt = 0.2 |
			var startMod = LFPar.kr(startModFreq, 0.45, mul:start*startAmt,add:start);
			var phasor = Phasor.ar(0, BufRateScale.ir(buf) * playRate, 0, length) + startMod;
			var env = EnvGen.ar(Env([amp, amp, 0], [sustain, 0]), doneAction: 2);
			var snd = BufRd.ar(1, buf, phasor) * env;
			OffsetOut.ar(out, Pan2.ar(snd, pan));
		}, \ir.dup(8)).add;

		SynthDef(\wstSTM1gl, { | out = 0, buf = 0, start = 0, length = 441, playRate = 1, sustain = 1, amp = 0.2, pan, startModFreq = 0.5, startAmt = 0.2, playRate2 = 1 |
			var playRateEnv = Line.ar(playRate, playRate2, sustain);
			var startMod = LFPar.kr(startModFreq, 0.45, mul:start*startAmt,add:start);
			var phasor = Phasor.ar(0, BufRateScale.ir(buf) * playRateEnv, 0, length) + startMod;
			var env = EnvGen.ar(Env([amp, amp, 0], [sustain, 0]), doneAction: 2);
			var snd = BufRd.ar(1, buf, phasor) * env;
			OffsetOut.ar(out, Pan2.ar(snd, pan));
		}, \ir.dup(8)).add;

		self.subBuf = buf;
		self.waves = waves;

		self.currSet = Wavesets.from(files.currSet);
		self.leaveOneSet = Wavesets.from(files.leaveOneSet);
		self.leaveTwoSet = Wavesets.from(files.leaveTwoSet);
		self.transferSetOne = Wavesets.from(files.transferSetOne);
		self.transferSetTwo = Wavesets.from(files.transferSetTwo);

		self;
	},

	\modulateStart : {arg self; self.inst = \wstSTM},

	\modulateSpeed : {arg self; self.inst = \wvst1gl},

	\speed2 : {arg self; self.baseSpeed()*1.1},

	\moduleSpeedPlusStart : {arg self; self.inst = \wstSTM1gl},

	\newWaves : { arg self, wave;
		self.subBuf.sendCollection(wave);
	},

	\randomWave : {arg self;
		self.subBuf.sendCollection(self.waves.waves.choose);
	},

	\distance : {0.0},

	\speedChangeModulo : {arg self; self.currSet.xings.size*2},

	\plusAmount : {0.0},

	\speedMod : {0},

	\waveSetAmount : {1},

	\multiplier : {1},

	\shouldDeletePause : {false},

	\deletePauseSet : {false},

	\shouldDelete : {false},

	\deleteLevel : {1},

	\deleteAmt : {1},

	\deleteNormAmt : {0},

	\deleteNormLevel : {1},

	\deleteReceiver : {1},

	\deleteDeviation : {2},

	\shouldRandomDelete : {false},

	\randomDeleteAmount : { arg self;
		var numb = gauss(self.deleteReceiver,self.deleteDeviation).asInteger;
		if(numb.isNegative,{
			numb = numb * -1;
		}, {
			numb;
		});
		if(numb === 0,{
			self.randomDeleteAmount();
		},{
			numb;
		});
	},

	\repeats : {1},

	\baseSpeed : {1},

	\shouldAverage : {false},

	\averageModulo : {arg self; self.currSet.xings.size*2},

	\shouldSwap : {false},

	\shouldShuffle : {false},

	\shuffAmount : {0},

	\shouldSub : {false},

	\subAmt : {1},

	\subLevel : {1},

	\subNormAmt : {0},

	\subNormLevel : {0},

	\shouldReverse : {false},

	\reverseAmt : {1},

	\reverseLevel : {1},

	\reverseNormAmt : {0},

	\reverseNormLevel : {0},

	\pan : {0},

	\shouldPan : {false},

	\panAmt : {1},

	\panLevel : {1},

	\panNormAmt : {0},

	\panNormLevel : {0},

	\waveSubMod : {arg self; self.currSet.xings.size*2},

	\lastAmpAmt : 1,

	\lastAmpAdd : 0,

	\ampAmt: 1,

	\ampAdd : 0,

	\setAmpAmt: {arg self, amp;
		self.lastAmpAmt = amp;
		self.ampAmt = amp;
	},

	\setAmpAdd: {arg self, amp;
		self.lastAmpAdd = amp;
		self.ampAdd = amp;
	},

	\inst :  Wavesets.defaultInst,

	\resetInst : {arg self; self.inst = Wavesets.defaultInst},

	\currBuf : {arg self; self.currSet.buffer.bufnum},

	\useCurrBuf : {false},

	\breakPointSet : {1},

	\breakPoint : {arg self; self.breakPointSet()},

	\decBreak : {false},

	\breakAmount : {0},

	\shouldHarmonize : {false},

	\harmLevel : {0.1},

	\harmonizeAmt : {1},

	\harmonizeLevel : {1},

	\harmonizeNormAmt : {0},

	\harmonizeNormLevel : {0},

	\shouldTransferOne : {false},

	\transferOneAmt : {1},

	\transferOneLevel : {1},

	\transferOneNormAmt : {0},

	\transferOneNormLevel : {0},

	\shouldTransferTwo : {false},

	\transferTwoAmt : {1},

	\transferTwoLevel : {1},

	\transferTwoNormAmt : {0},

	\transferTwoNormLevel : {0},

	\shouldInterleaveOne : {false},

	\interleaveOneAmt : {1},

	\interleaveOneLevel : {1},

	\interleaveOneNormAmt : {0},

	\interleaveOneNormLevel : {0},

	\shouldInterleaveTwo : {false},

	\interleaveTwoAmt : {1},

	\interleaveTwoLevel : {1},

	\interleaveTwoNormAmt : {0},

	\interleaveTwoNormLevel : {0},

	\shouldNormalize : {false},

	\normalizeAmount : {arg self; self.currSet.xings.size*2},

	\normalizeThresh : {10},

	\speedSwapModulo :  {arg self; self.currSet.xings.size*2},

	\speedSwapAmt : {1},

	\shouldShrink : {false},

	\shrinkAmt : {1.75},

    \go : {|self, length = 2|
		Routine({
			length.do({arg j;
				var amount;
				if(self.switchSet, {
					self.currSet = self.switchToSet;
				});
				amount = self.currSet.xings.size -  (self.waveSetAmount());
				amount.do({arg i;
					var ev, speed, start, length, startFrame, endFrame, amp,harmEvents,
					numWs, sustain, repeats, sum, origRate, wsDur, frame, type, plunk;

					if( self.shouldInterleaveTwo() && (self.interleaveTwoNormAmt > 0)){
						i = i - self.interleaveTwoAmt;
					};

					if(self.shouldShuffle(), {
						var origI = i;
						i = i + self.shuffAmount.rand2;
						if( (i < 0) or: (i >= amount)){
							if( i < 0 ){
								i = origI + self.shuffAmount;
							};

							if( i >= amount ){
								i = origI - self.shuffAmount;
							};
						};

						if( (i < 0) or: (i >= amount)){
							i = origI;
						}
					});

					speed = self.baseSpeed();

					if( (i%self.speedChangeModulo) === 0, {
						speed = speed + ((i%self.speedMod()) * self.plusAmount());
					},{
						speed = speed - ((i%self.speedMod()) * self.plusAmount());
					});

					if( (i%self.speedSwapModulo) === 0){
						speed = speed*self.speedSwapAmt;
					};

					repeats = self.repeats();
					numWs = self.waveSetAmount();

					//////WELCOME TO THE MAINNNN EVENTTTTTTT
					ev = self.currSet.eventFor(i, numWs, repeats, speed);

					startFrame = self.currSet.xings.clipAt(i);
					endFrame = self.currSet.xings.clipAt(i + numWs);
					ev.length = (endFrame - startFrame);

					if( ((i%self.averageModulo) === 0) && self.shouldAverage(), {
						ev.length = self.currSet.avgLength;
						ev.wsAmp = self.currSet.avgAmp;
					});


					if(self.shouldTransferOne()){
						if(self.transferOneAmt > 0){
							var transferStart;

							if(numWs > (self.transferSetOne.xings.size - 1)){
								numWs = (self.transferSetOne.xings.size - 1) - self.waveSetAmount();
							};

							transferStart = i%(self.transferSetOne.xings.size - 1);

							ev = self.transferSetOne.eventFor(transferStart, numWs, repeats, speed);
							ev.buf = self.currBuf();

							self.transferOneAmt = self.transferOneAmt - 1;

							if(self.transferOneAmt === 0){
								self.transferOneNormAmt = self.transferOneNormLevel + 1;
							};

						};

						if(self.transferOneNormAmt > 0){
							self.transferOneNormAmt = self.transferOneNormAmt - 1;
							if(self.transferOneNormLevel === 0){
								self.transferOneAmt = self.transferOneLevel;
							};
						};

					};

					if(self.shouldTransferTwo()){
						if(self.transferTwoAmt > 0){
							var transferStart, tempLength, tempAmp;
							tempLength = ev.length;
							tempAmp = ev.wsAmp;
							if(numWs > (self.transferSetTwo.xings.size - 1)){
								numWs = (self.transferSetTwo.xings.size - 1) - self.waveSetAmount();
							};

							transferStart = i%(self.transferSetTwo.xings.size - 1);

							ev = self.transferSetTwo.eventFor(transferStart, numWs, repeats, speed);
							ev.length = tempLength;
							ev.wsAmp = tempAmp;

							self.transferTwoAmt = self.transferTwoAmt - 1;
							if(self.transferTwoAmt === 0){
								self.transferTwoNormAmt = self.transferTwoNormLevel + 1;
							};

						};

						if(self.transferTwoNormAmt > 0){
							self.transferTwoNormAmt = self.transferTwoNormAmt - 1;
							if(self.transferTwoNormAmt === 0){
								self.transferTwoAmt = self.transferTwoLevel;
							};
						};

					};

					if(self.shouldInterleaveOne()){
						if(self.interleaveOneAmt > 0){
							var leaveStart;

							if(numWs > (self.leaveOneSet.xings.size - 1)){
								numWs = (self.leaveOneSet.xings.size - 1) - self.waveSetAmount();
							};

							leaveStart = i%(self.leaveOneSet.xings.size - 1);

							ev = self.leaveOneSet.eventFor(leaveStart, numWs, repeats, speed);

							self.interleaveOneAmt = self.interleaveOneAmt - 1;

							if(self.interleaveOneAmt === 0){
								self.interleaveOneNormAmt = self.interleaveOneNormLevel + 1;
							};

						};

						if(self.interleaveOneNormAmt > 0){
							self.interleaveOneNormAmt = self.interleaveOneNormAmt - 1;
							if(self.interleaveOneNormAmt === 0){
								self.interleaveOneAmt = self.interleaveOneLevel;
							};
						};

					};


					if(self.shouldInterleaveTwo()){
						if(self.interleaveTwoAmt > 0){
							var leaveStart;

							if(numWs > (self.leaveTwoSet.xings.size - 1)){
								numWs = (self.leaveTwoSet.xings.size - 1) - self.waveSetAmount();
							};

							leaveStart = i%(self.leaveTwoSet.xings.size - 1);

							ev = self.leaveTwoSet.eventFor(leaveStart, numWs, repeats, speed);

							self.interleaveTwoAmt = self.interleaveTwoAmt - 1;

							if(self.interleaveTwoAmt === 0){
								self.interleaveTwoNormAmt = self.interleaveTwoNormLevel + 1;
							};

						};

						if(self.interleaveTwoNormAmt > 0){
							self.interleaveTwoNormAmt = self.interleaveTwoNormAmt - 1;
							if(self.interleaveTwoNormAmt === 0){
								self.interleaveTwoAmt = self.interleaveTwoLevel;
							};
						};

					};


					ev.length = ev.length*self.multiplier();

					if( (i%2 == 0 && self.shouldSwap()), {
						ev.length = (endFrame - startFrame)/self.multiplier();
					});

					sustain = ev.length / self.currSet.sampleRate;
					ev.sustain = sustain / speed * repeats;

					if(self.shouldSub()){
						if(self.subAmt > 0){
							if(i >= amount, {i = amount - self.waveSetAmount()});
							origRate = ev[\playRate];

							start = ev.start;
							length = ev.length;
							wsDur = ev.sustain;

							ev[\playRate] = origRate*(512/length);
							ev.putPairs([\buf, self.subBuf]);
							ev[\start] = 0;
							ev[\length] = 512;
							ev[\sustain] = wsDur * repeats / origRate.abs;

							self.subAmt = self.subAmt - 1;

							if(self.subAmt === 0){
								self.subNormAmt = self.subNormLevel + 1;
							};

						};

						if(self.subNormAmt > 0){
							self.subNormAmt = self.subNormAmt - 1;
							if(self.subNormAmt === 0){
								self.subAmt = self.subLevel;
							};
						};

						if( ((i%self.waveSubMod) === 0 && (i > 1)), {
							self.randomWave();
						});

					};

					if( ((i%self.normalizeAmount()) == 0) && self.shouldNormalize() ){
						if(ev.wsAmp > (self.currSet.avgAmp*self.normalizeThresh()) ){
							ev.amp = self.currSet.avgAmp;
							ev.amp = ev.amp + self.ampAdd();
						}
					};


					amp = if(ev.amp.notNil, {ev.amp},{(self.ampAmt()*ev.wsAmp) + self.ampAdd()});

					ev.putPairs([
						\amp, amp,
						\out, self.out(),
						\pan, self.pan(),
						\instrument, self.inst(),
						\startModFreq, self.startModFreq(),
						\startAmt : self.startAmt(),
						\playRate2 : self.speed2(),
					]);

					if(self.useCurrBuf){ev.putPairs([\buf, self.currBuf])};

					if(self.shouldReverse()){
						if(self.reverseAmt  > 0){
							ev.playRate = ev.playRate * (-1);

							self.reverseAmt = self.reverseAmt - 1;

							if(self.reverseAmt === 0){
								self.reverseNormAmt = self.reverseNormLevel + 1;
							};

						};

						if(self.reverseNormAmt > 0){
							self.reverseNormAmt = self.reverseNormAmt - 1;
							if(self.reverseNormAmt === 0){
								self.reverseAmt = self.reverseLevel;
							};
						};

					};

					if(self.shouldPan()){
						if(self.panAmt > 0){
							ev.pan = ev.pan*(-1);

							self.panAmt = self.panAmt - 1;

							if(self.panAmt === 0){
								self.panNormAmt = self.panNormLevel + 1;
							};

						};

						if(self.panNormAmt > 0){
							self.panNormAmt = self.panNormAmt - 1;
							ev.pan = ev.pan*(1);
							if(self.panNormAmt === 0){
								self.panAmt = self.panLevel;
							};
						};

					};

					if(self.shouldHarmonize()){
						if(self.harmonizeAmt > 0){

							var temp = ev.copy;
							harmEvents = List(4);
							(2 to: 4).do({arg i;
								temp = temp.copy;
								temp.playRate = (temp.playRate * i);
								temp.amp = temp.amp / (i*self.harmLevel);
								harmEvents.add(temp);
							});

							self.harmonizeAmt = self.harmonizeAmt - 1;

							if(self.harmonizeAmt === 0){
								self.harmonizeNormAmt = self.harmonizeNormLevel + 1;
							};

						};

						if(self.harmonizeNormAmt > 0){
							self.harmonizeNormAmt = self.harmonizeNormAmt - 1;
							if(self.harmonizeNormAmt === 0){
								self.harmonizeAmt = self.harmonizeLevel;
							};
						};

					};

					if(self.shouldDelete()){
						if(self.deleteAmt > 0){

							ev.putPairs([\amp, 0]);
							self.deletePauseSet = true;

							self.deleteAmt = self.deleteAmt - 1;

							if(self.deleteAmt === 0){
								self.deleteNormAmt = self.deleteNormLevel + 1;
							};

						};
						if(self.deleteNormAmt > 0){
							self.deleteNormAmt = self.deleteNormAmt - 1;
							if(self.deleteNormAmt === 0){
								self.deleteAmt = self.deleteLevel;
							};
						};

					};

					if( self.shouldRandomDelete() && (i%self.randomDeleteAmount() === 0) ){
						self.deletePauseSet = true;
						ev.putPairs([\amp, 0]);
					};

					if(  (ev.wsAmp < (self.currSet.avgAmp*self.shrinkAmt)) && self.shouldShrink() ){
						ev.putPairs([\amp, 0]);
					};
						ev.play;
						if(harmEvents.notNil, {
							harmEvents.do({arg harm;
								harm.play;
							});
						});

						if(i !== (self.currSet.xings.size - (self.waveSetAmount() + 1)), {
							(ev.sustain + self.distance()).wait;
						},{
							self.distance().wait;
						});
					if((self.shouldDeletePause() && self.deletePauseSet()), {
						self.deletePauseSet = false;
						if(i !== (self.currSet.xings.size - (self.waveSetAmount() + 1)), {
							(ev.sustain + self.distance()).wait;
						},{
							self.distance().wait;
						});
					});
					if( ( self.decBreak() and: (self.breakPoint() != 0) and: (self.ampAmt > 0.1) ) ,{
						self.breakPoint = self.breakPoint - 1;
						self.ampAmt = self.ampAmt - (self.lastAmpAmt/self.breakPointSet);
						self.ampAdd = self.ampAdd - (self.lastAmpAdd/self.breakPointSet);

						if(self.ampAmt < 0.001, {self.ampAmt = 0});
						if(self.ampAdd < 0.001, {self.ampAdd = 0});

						if(self.breakPoint < 0, {self.breakPoint = self.breakPointSet});
					});
					if( (self.breakPoint() === 0) or: (self.ampAmt < 0.1) , {
						self.breakAmount.wait;
						self.breakPoint = self.breakPointSet;
						self.ampAmt = self.lastAmpAmt();
						self.ampAdd = self.lastAmpAdd();
					});

					harmEvents = nil;

				});

			});
		});
    }
)
);

