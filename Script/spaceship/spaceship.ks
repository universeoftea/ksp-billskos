// chen.ks Control script for CHEN ATV
function resetshipstate {
	SAS OFF.
	RCS OFF.
	BRAKES OFF.
	SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.
	UNLOCK THROTTLE.
	UNLOCK STEERING.
}

function launch {
	createdir("1:/lib").
	copypath("0:/lib/ship_monitor.ks","lib/").
	copypath("0:/lib/node_circ.ks","lib/").
	copypath("0:/lib/node_exec.ks","lib/").
	copypath("0:/lib/rm_switch.ks","lib/").
	runoncepath("lib/ship_monitor.ks").

	if SHIP:NAME:CONTAINS("(Marisa)") {
		copypath("0:/boosters/marisa.ks","").
		runpath(marisa).
		deletepath("marisa.ks").
	} else {
		PRINT "Ship is on internal power.".
		PRINT "Letting the booster do its job.".
		WAIT until SHIP:STATUS = "ORBITING".
	}

	wait 30.
	resetshipstate().
	
	if SHIP:NAME:CONTAINS(" (Reimu V)") {
		set newname to SHIP:NAME:REPLACE(" (Reimu V)", "").
	} else if SHIP:NAME:CONTAINS(" (Reimu VH)") {
		set newname to SHIP:NAME:REPLACE(" (Reimu VH)", "").
	} else if SHIP:NAME:CONTAINS(" (Marisa)") {
		set newname to SHIP:NAME:REPLACE(" (Marisa)", "").
	}
	set SHIP:NAME to newname.
	
	STAGE.
	WAIT 3.
	panels on.
	
	if SHIP:NAME:CONTAINS = "dest:Mun" {
		runpath("lib/rm_switch.ks",200).
		runpath("lib/rm_switch.ks",0).
	} else {
		runpath("lib/rm_switch.ks",0).
	}

}

if SHIP:STATUS = "PRELAUNCH" {
	launch().
} else {
	runoncepath("lib/ship_monitor.ks").
	resetshipstate().
	runpath("lib/rm_switch.ks",0).
}
