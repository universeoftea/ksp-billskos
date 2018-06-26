//Launch script for Reimu V launcher


function resetshipstate {
	SAS OFF.
	RCS OFF.
	BRAKES OFF.
	set THROTTLE to 0.
	set SHIP:CONTROL:PILOTMAINTHROTTLE to 0.
	unlock STEERING.
	UNLOCK THROTTLE.
}

function launch {
	//TODO: I would like these libraries at the start of the script
	//TODO: Check if libraries already exists, otherwise copy them
	createdir("1:/lib").
	copypath("0:/lib/ship_monitor.ks","lib/").
	copypath("0:/lib/node_circ.ks","lib/").
	copypath("0:/lib/node_exec.ks","lib/").
	runoncepath("lib/ship_monitor.ks").

	//Clear terminal of any garbage
	CLEARSCREEN.
	printshipstatus().
	
	//Initiate countdown
	logadd("Vehicle on internal power...").
	logadd("Reimu is now in control of countdown.").
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

	logadd("Initiating gravity turn.").
	lock gturn to 90-arcsin(min(1,SHIP:ALTITUDE/35000)).
	
	UNTIL SHIP:APOAPSIS > 90000 {
		printshipstatus().
		wait 0.3.
	}
	lock THROTTLE to 0.5.
	UNTIL SHIP:APOAPSIS > 100000 {
		printshipstatus().
		wait 0.3.
	}
	resetshipstate().
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
	
	wait 5.
	stage.
	
	wait 1.
	if ship:name:contains("Reimu VH") {
		set ship:name to "Reimu VH Booster".
	} else {
		set ship:name to "Reimu V Booster".
	}

	//TODO: Could we make a library load/unload function for this?
	logadd("Cleaning up unused files").
	printshipstatus().
	deletepath("lib/node_circ.ks").
	deletepath("lib/node_exec.ks").
	
	logadd("Copying files needed for landing").
	printshipstatus().
	copypath("0:/boosters/reimu_v_landing.ks","").
	logadd("Landing script will start on reload").
	logadd("Have a nice flight").
	printshipstatus().
}

launch().
