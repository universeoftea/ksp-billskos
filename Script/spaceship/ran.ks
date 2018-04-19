function resetshipstate {
	unlock STEERING.
	SAS OFF.
	RCS OFF.
	BRAKES OFF.
	UNLOCK THROTTLE.
	SET THROTTLE TO 0.
	SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.
}
function launch {
	createdir("1:/lib").
	copypath("0:/lib/ship_monitor.ks","1:/lib/").
	runoncepath("lib/ship_monitor.ks").
	copypath("0:/lib/node_circ.ks","1:/lib/").
	copypath("0:/lib/node_exec.ks","1:/lib/").
	copypath("0:/lib/dock_align.ks","1:/lib/").
	copypath("0:/lib/rm_switch.ks","1:/lib/").

	PRINT "Ship is on internal power.".
	PRINT "Letting the booster do its job.".
	WAIT UNTIL SHIP:STATUS <> "PRELAUNCH".
	
	WAIT UNTIL SHIP:ALTITUDE > 30000.
	PRINT "Jettisoning escape tower".
	BRAKES ON.
	WAIT 1.
	BRAKES OFF.
	
	WAIT UNTIL SHIP:STATUS = "ORBITING".
	WAIT 10.
	PRINT "Ran III computer is now taking control.".
	resetshipstate().
	
	SET SHIP:NAME TO "Ran V".
	STAGE.
	panels on.
	
	runpath("lib/rm_switch.ks").
}

IF SHIP:STATUS = "PRELAUNCH" {
	launch().
} ELSE {
	runoncepath("lib/ship_monitor.ks").
	setrunmode(0).
	runpath("lib/rm_switch.ks").
}
