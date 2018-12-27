
//Launch script for Marisa Modular booster system

function launchbooster {

	//Clear terminal of any garbage
	CLEARSCREEN.
	printshipstatus().
	
	//Initiate countdown
	logadd("Vehicle on internal power...").
	logadd("Marisa is now in control of countdown.").
	set gturn to 90.
	LOCK STEERING TO HEADING(90,gturn).
	LOCK THROTTLE TO 1.0.
	FROM {local countdown is 10.} UNTIL countdown = 0 STEP {SET countdown to countdown - 1.} DO {
		logadd("..." + countdown).
		printshipstatus().
		WAIT 1.
	}
	
	STAGE.
	logadd("Liftoff!").
	UNTIL SHIP:ALTITUDE > 1000 {
		printshipstatus().
		wait 0.5.
	}

	WHEN STAGE:SOLIDFUEL < 1 THEN {
		logadd("Staging").
		stage.
		WHEN STAGE:LIQUIDFUEL < 1 THEN {
			logadd("Staging").
			stage.
			wait 1.
			stage.
		}
	}

	logadd("Initiating gravity turn.").
	lock gturn to 90-arcsin(min(1,SHIP:ALTITUDE/35000)).
	
	UNTIL SHIP:APOAPSIS > 100000 {
		printshipstatus().
		wait 0.3.
	}
	LOCK THROTTLE TO 0.
	LOCK STEERING TO SHIP:PROGRADE.
	
	logadd("Coasting to Apoapsis.").
	set warpmode to "PHYSICS".
	set warp to 2.
	UNTIL SHIP:ALTITUDE > 70000 {
		printshipstatus().
		wait 0.5.
	}
	set warp to 0.
	WAIT 3.
	
	runpath("lib/node_circ.ks","ap").
	runpath("lib/node_exec.ks").
	resetshipstate().
	stage.
	printshipstatus().
}

launchbooster().
