WAIT UNTIL SHIP:UNPACKED.
IF SHIP:NAME:CONTAINS("Reimu IV") AND SHIP:STATUS = "PRELAUNCH" {
	copypath("0:/boosters/reimu_iv.ks","").
	copypath("0:/boosters/reimu_iv_landing.ks","").
	run reimu_iv.
} ELSE IF SHIP:NAME = "Reimu IV Booster" AND SHIP:STATUS = "SUB_ORBITAL" {
	run reimu_iv_landing.
} ELSE IF SHIP:NAME = "Reimu IV Booster" AND SHIP:STATUS = "FLYING" {
	run reimu_iv_landing.
} ELSE IF SHIP:NAME:CONTAINS("Reimu V") AND SHIP:STATUS = "PRELAUNCH" {
	copypath("0:/boosters/reimu_v.ks","").
	runpath("reimu_v.ks").
} ELSE IF SHIP:NAME("Reimu V Booster") AND SHIP:STATUS = "ORBITING" {
	runpath("reimu_v_landing.ks").
} ELSE IF SHIP:NAME("Reimu VH Booster") AND SHIP:STATUS = "ORBITING" {
	runpath("reimu_v_landing.ks").
} ELSE {
	PRINT "Unknown shiptype/launcher".
	PRINT "Will not boot any script".
}
