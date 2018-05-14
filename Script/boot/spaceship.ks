WAIT UNTIL SHIP:UNPACKED.
PRINT "This is the support computer.".
PRINT "Checking status of vessel.".

IF SHIP:NAME:CONTAINS("Ran ") {
	copypath("0:/spaceship/ran.ks","").
	run ran.
}
ELSE IF SHIP:NAME:CONTAINS("Chen ") {
	copypath("0:/spaceship/chen_3.ks","").
	runpath("chen_3.ks").
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
