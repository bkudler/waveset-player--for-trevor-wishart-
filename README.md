# waveset-player--for-trevor-wishart-


This creates an interface in SuperCollider for working with all of the waveset transformations described by Trevor Wishart, as recounted by Curtis Road in *Microsound*, plus a few weird ones I found along the way.

You will have to have [the waveset quark](https://github.com/supercollider-quarks/Wavesets) installed.

More info on [installing quarks](https://doc.sccode.org/Guides/UsingQuarks.html)


you'll need to add in some files in certain places.

In `waveSetPlayer-sample.scd` where it says 
```
  put the path to the waveset-player file here and load it in. This will store an event in the currentEnvironment called "wavesetPlayer"
  
  ().load
 
```

you will need to the absolute path to `waveset-player.scd`

in `waveset-player.scd` where it says

```
(
~currSet =  "";
~leaveOneSet = "";
~leaveTwoSet = "";
~transferSetOne = "";
~transferSetTwo = "";
);
```

you will have to pick a mono audio file for each variable. Put the aboslute path in between the quotation marks. Each file is used for a different waveset transformation.
