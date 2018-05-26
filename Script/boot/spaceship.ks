WAIT UNTIL SHIP:UNPACKED.
PRINT "This is the support computer.".
PRINT "Checking status of vessel.".

IF SHIP:NAME:CONTAINS("Ran ") {
	if SHIP:STATUS = "PRELAUNCH" {
		copypath("0:/spaceship/ran.ks","").
		run ran.
	} else {
		runpath(ran).
	}
}
ELSE IF SHIP:NAME:CONTAINS("Chen ") {
	if SHIP:STATUS = "PRELAUNCH" {
		copypath("0:/spaceship/chen.ks","").
		runpath("chen.ks").
	} else {
		runpath(chen).
	}
}
ELSE IF SHIP:NAME:CONTAINS("Koakuma") {
	if SHIP:STATUS = "PRELAUNCH" {
		copypath("0:/spaceship/koakuma.ks","").
		runpath("koakuma.ks").
	} else {
		runpath(koakuma).
	}
}
ELSE IF SHIP:NAME:CONTAINS("Wriggle I") {
	copypath("0:/spaceship/wriggle.ks","").
	run wriggle.
} else if ship:name:contains("Prismriver") {
	copypath("0:/spaceship/prism.ks","").
	runpath("prism.ks").
} ELSE {
	PRINT "Vessel is unknown to this bootscript.".
}
