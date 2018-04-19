function resetshipstate {
	SAS OFF.
	RCS OFF.
	BRAKES OFF.
	SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.
	UNLOCK THROTTLE.
	SET THROTTLE TO 0.
}
function pilotmode {
	SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.
	UNLOCK THROTTLE.
	SET THROTTLE TO 0.
	UNLOCK STEERING.
	SET runmode TO 0.
}

function launch {
	createdir("1:/lib").
	copypath("0:/lib/node_circap.ks","1:/lib/").
	copypath("0:/lib/dock_align.ks","1:/lib/").

	PRINT "Ship is on internal power.".
	PRINT "Letting the booster do its job.".
	
	WAIT UNTIL SHIP:ALTITUDE > 70000.
	WAIT 5.
	resetshipstate().
	SET SHIP:NAME TO "Chen I".
	
	STAGE.
	WAIT 3.
	panels on.

	runpath("lib/node_circap.ks").
	resetshipstate().
	
	pilotmode().
	PRINT "We are now in orbit!".
	
	SET runmode TO 0.
}

IF SHIP:STATUS = "PRELAUNCH" {
	launch().
} ELSE {
	PRINT "Ship is participating in unknown activities.".
}
