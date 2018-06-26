//Launch script for Reimu IIX launcher

// New and interesting edits from Reimu V (except for changes to hardware)
// - resetshipstate() should now lock the throttle to pilot input while script is still active
// - smooth gravity turn all the way to 35000m asl
// - landing is now integrated as a function in this script
// - Parachutes should now always trigger at the right speed


function resetshipstate {
	SAS OFF.
	RCS OFF.
	BRAKES OFF.
	set SHIP:CONTROL:PILOTMAINTHROTTLE to 0.
	lock THROTTLE to SHIP:CONTROL:PILOTMAINTHROTTLE.
	unlock STEERING.
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
	clearscreen.
	printshipstatus().
	
	//Initiate countdown
	logadd("Vehicle on internal power...").
	logadd("Reimu is now in control of countdown.").
	set gturn to 90.
	lock STEERING to HEADING(90,gturn).
	lock THROTTLE to 1.0.
	FROM {local countdown is 10.} until countdown = 0 STEP {SET countdown to countdown - 1.} DO {
		logadd("..." + countdown).
		printshipstatus().
		WAIT 1.
	}
	
	STAGE.
	logadd("Liftoff!").
	until SHIP:ALTITUDE > 1000 {
		printshipstatus().
		wait 0.5.
	}
	
	logadd("Initiating gravity turn.").
	lock gturn to 90-arcsin(min(1,SHIP:ALTITUDE/35000)).
	
	until SHIP:ALTITUDE > 35000 {
		logadd("Pitching to: " + gturn).
		printshipstatus().
		wait 0.3.
	}

//	lock gturn to 0.
//	logadd("Pitching to: " + gturn).
	
	until SHIP:APOAPSIS > 90000 {
		printshipstatus().
		wait 0.3.
	}
	lock THROTTLE to 0.5.
	until SHIP:APOAPSIS > 100000 {
		printshipstatus().
		wait 0.3.
	}
	resetshipstate().
	lock STEERING to SHIP:PROGRADE.
	
	logadd("Coasting to Apoapsis.").
	set warpmode to "PHYSICS".
	set warp to 2.
	until SHIP:ALTITUDE > 70000 {
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
	set ship:name to "RIIX Booster".

	//TODO: Could we make a library load/unload function for this?
	logadd("Cleaning up unused files").
	deletepath("lib/node_circ.ks").
	deletepath("lib/node_exec.ks").
	
	logadd("Landing script will start on reload").
	logadd("Have a nice flight").
	resetshipstate().
	printshipstatus().
}

function landing {
	
	// Parameters, change these as you please
	set LandObtAlt to 100000.
	set deorbLNG to -160.
	set deorbPe to 0.
	set timewarpLNG to deorbLNG-15.
	set reentryspd to 1000.
	set warpspd to 3.
	
	GEAR OFF.
	
	SAS OFF.
	lock shipPos to SHIP:GEOPOSITION.
	
	lock STEERING to RETROGRADE.
	//Timewarp
	if shipPos:LNG < timewarpLNG or shipPos:LNG > deorbLNG + 2
		set warpmode to "RAILS".
		set warp to warpspd.
		wait until shipPos:LNG > timewarpLNG and shipPos:LNG < deorbLNG.
		set warp to 0.
	
	wait until shipPos:LNG > deorbLNG and shipPos:LNG < deorbLNG + 2.
	
	lock THROTTLE to 0.5.
	WAIT UNTIL SHIP:PERIAPSIS < deorbPe.
	lock THROTTLE to 0.
	
	//Timewarp
	wait 5.
	set warpmode to "RAILS".
	set warp to warpspd.
	wait until ship:altitude < 75000.
	set warp to 0.
	set warpmode to "PHYSICS".
	set warp to 2.
	
	lock STEERING to SRFRETROGRADE.
	
	wait until SHIP:ALTITUDE < 30000.
	if SHIP:AIRSPEED > reentryspd {
		lock THROTTLE to 1.
		wait until SHIP:AIRSPEED < reentryspd.
		lock THROTTLE to 0.
	}
	
	when SHIP:AIRSPEED < 420 then {
		CHUTESSAFE ON.
		WAIT 1.
		CHUTESAFE OFF.
	}
	when SHIP:AIRSPEED < 260 then {
		CHUTESSAFE ON.
	}
	
	//More timewarp stuff
	wait until ALT:RADAR < 1000.
	set warp to 0.
	wait 2.
	
	GEAR ON.
	lock STEERING to UP.
	
	logadd("Wait until 80 m radar altitude").
	WAIT UNTIL ALT:RADAR < 80.
	logadd("Do a soft landing...").
	
	lock THROTTLE to SHIP:AIRSPEED/40.
	wait until SHIP:STATUS = "LANDED" or SHIP:STATUS = "SPLASHED".
	
	lock THROTTLE to 0.
	logadd("Touchdown!").
	
	wait 10.
	resetshipstatus().
}

if SHIP:STATUS = "PRELAUNCH" {
	launch().
} else if SHIP:STATUS = "ORBITING" {
	landing().
} else {
	print("I have no idea what to do.").
}
