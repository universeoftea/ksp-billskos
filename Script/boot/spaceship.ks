WAIT UNTIL SHIP:UNPACKED.
PRINT "This is the support computer.".
PRINT "Checking status of vessel.".
if SHIP:STATUS = "PRELAUNCH" {
	copypath("0:/spaceship/spaceship.ks","").
	runpath("spaceship.ks").
} else {
	runpath("spaceship.ks").
}
