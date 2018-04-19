

IF SHIP:STATUS = "PRELAUNCH" {
	copypath("0:/boosters/cirno.ks","").
	run cirno.
}
ELSE {
	print "Satellite appears to already be in space.".
}
