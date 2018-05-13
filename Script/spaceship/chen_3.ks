function resetshipstate {
	SAS OFF.
	RCS OFF.
	BRAKES OFF.
	SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.
	UNLOCK THROTTLE.
	UNLOCK STEERING.
	SET THROTTLE TO 0.
}

function launch {
	createdir("1:/lib").
	copypath("0:/lib/ship_monitor.ks","lib/").
	copypath("0:/lib/node_circ.ks","lib/").
	copypath("0:/lib/node_exec.ks","lib/").
	runoncepath("lib/ship_monitor.ks").

	PRINT "Ship is on internal power.".
	PRINT "Letting the booster do its job.".
	
	WAIT UNTIL SHIP:ALTITUDE > 70000.
	WAIT UNTIL SHIP:STATUS = "ORBITING".
	wait 20.
	resetshipstate().
	SET SHIP:NAME TO "Chen III".
	
	STAGE.
	WAIT 3.
	panels on.

	copypath("0:/lib/mun.ks","lib/").
	runpath("lib/mun.ks").
	runpath("lib/node_exec.ks").

}

IF SHIP:STATUS = "PRELAUNCH" {
	launch().
} ELSE {
	PRINT "Ship is participating in unknown activities.".
}
