(
~wavesetWaves = (
	waves: (
		saw: Signal.sineFill(512, Array.fill(512, {arg i; i = i + 1; (1/i) - 1} )),
		wuTang:  Signal.sineFill(512, Array.fill(20, {arg i; i = i + 1; (2/i)} ), [1,2]),
		squigSaw:  Signal.sineFill(512, Array.fill(20, {arg i; i = i + 1; (1/i ) } ), Array.fill(20, {arg i; i - 2})),
		weirdSin: Signal.sineFill(512, [1,2]),
		weirdSin2: Signal.sineFill(512, Array.fill(5, {arg i; (i - 1) * -1}), Array.fill(2, {arg i; i })),
		//the stock market is taking a plunge
		badStocks: Signal.sineFill(512, Array.fill(512, {arg i; i = i + 1; (i*0.5) + rrand(i, i + 2)/i})),
		sin: Signal.sineFill(512, [1]),
		highSin: Signal.sineFill(512, [20]),

		weirdSqr: Signal.sineFill(512, Array.fill(512, {
			arg i;
			if( (i%2 !== 0), {
				1/i;
			},{
				0;
			});
		})),

		//okay time for the regular square
		sqr: Signal.sineFill(512, Array.fill(512, {
			arg i;
			i = i + 1;
			if( (i%2 !== 0), {
				1/i;
			},{
				0;
			});
		})),


		sizz: Signal.sineFill(512, Array.fill(512,{arg i;
			var div;
			i = i + 1;
			if( (i < (512/2)), {
				(i/2)/i;
			}, {
				i;
			});
		}), Array.fill(20, {arg i; i = i+1; rrand(-1,i)}))*0.8,


		iCallItM: Signal.sineFill(512, Array.fill(512,{arg i;
			var div;
			i = i + 1;
			div = (i*rrand(0.01, 0.2));
			if( (i < (512/2)), {
				i/div;
			}, {
				i;
			});
		}),Array.fill(50, {arg i; i = i+1; rrand(1,i)})),



		skwagSaw: Signal.sineFill(512, Array.fill(512, {arg i;
			i = i + 1;
			if( (i%32 !== 0), {
				if( (i > (512*(0.75))), {
					(1/(i*0.85));
				},{
					if( (i%2) == 0, {
						(1/i)*(-1);
					},{
						(1/i);
					});
				});
			},{
				if( (i > (512*(0.75))), {
					(0.25)
				},{
					0;
				});
			});
		})),


		switchSqr: Signal.sineFill(512, Array.fill(512, {arg i;
			i = i + 1;
			if( (i%4 !== 0), {
				512 - i;
			},{
				0;
			});
		})),

		//HNW!
		hNW: Signal.sineFill(512, Array.fill(512, {1.0.rand2})),

		sizzDown: Signal.sineFill(512, Array.fill(512, {arg i;
			i = i + 1;
			if( (i%32 !== 0), {
				if( (i > (512*(0.75))), {
					(1/(i*0.85));
				},{
					(1/i);
				});
			},{
				if( (i > (512*(0.75))), {
					(0.25)
				},{
					0;
				});
			});
		})),

		crazyu: Signal.sineFill(512, Array.fill(512, {
			arg i;
			i = i + 1;
			if( (i%2 !== 0), {
				1/i;
			},{
				0;
			});
		}),[pi, 0, -pi]),

		tri: Signal.sineFill(512, Array.fill(512, {
			arg i;
			i = i + 1;
			if( (i%2 !== 0), {
				(1/i.squared)*(-1);
			},{
				0;
			});
		}),[pi/2]),

		weirdTri: Signal.fill(512, {arg i;
			(512%i)*0.01;
		}),

		clawNOISE: FloatArray.fill(512, {arg i;
			var mod = poisson(i);
			(512%mod)*(-1);
		}).normalize(-1,1),
	),


	showKeys: {arg self, amount;
		if(amount.isNil){
			"You need to enter in an amount of waves you will instead get all of the waves".warn;
			amount = self.waves.keys.size;
		};
		if(amount > self.waves.keys.size){
			"You have entered in amount greater than the number of waves. The amount is truncated to the number of waves".warn;
			amount = self.waves.keys.size;
		};
		self.waves.keys.asList.copyRange(0, amount - 1).do({ arg wave;
			wave.postln;
		});
	},

	waveAmount: {arg self;
		self.waves.keys.size.postln;
	},

	showRandomKeys: {arg self;
		var start = rrand(0, self.keys.size - 2);
		var finish = rrand(start, self.keys.size - 1);
		self.waves.keys.asList.copyRange(start, finish).do({ arg wave;
			wave.postln;
		});
	};



)
)