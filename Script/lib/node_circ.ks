// node_circ.ks
// Written by kanojo
// Licenced under GPLv3
// Creates circularization node at ap/pe
// Please make sure this script is triggered while in space, as drag will make bad things happen
// Also, if Ap is in the next sphere of influence, bad things might ensue

parameter circpos.
//parameter shipisp.
//parameter shipfuelmass.

if circpos = "ap" {
	set targAlt to ALT:APOAPSIS.
	lock circEta to ETA:APOAPSIS.
} else if circpos = "pe" {
	set targAlt to ALT:PERIAPSIS.
	lock circEta to ETA:PERIAPSIS.
} else {
	logadd("No circularization position given, assuming Ap").
	set targAlt to ALT:APOAPSIS.
	set circEta to ETA:APOAPSIS.
}

set targSemiMajor to targAlt + SHIP:BODY:RADIUS.
set targSpeed to SQRT(constant:G * SHIP:BODY:MASS / targSemiMajor).
set currentSpeed to SQRT(constant:G * SHIP:BODY:MASS * (2 / targSemiMajor - 1 / SHIP:ORBIT:SEMIMAJORAXIS)). // reusing targSemiMajor since the target altitude here is the same (don't want to do the same calculaciot twice)
set deltaV to targSpeed - currentSpeed.
set absdeltav to ABS( deltaV ).

//set fuelmassreq to SHIP:MASS * 1000 * constant:e ^ ( absdeltav / (shipisp*9.82) ) - SHIP:MASS * 1000.
//set fuelvolreq to fuelmassreq / fuelmassvol.
//set targBurnTime to fuelvolreq / fuelflow.

set CircNode to NODE(TIME:SECONDS+circEta,0,0,deltaV).
add CircNode.

logadd("Circularization Altitude: " + targAlt).
logadd("Semi Major Axis of target orbit: " + targSemiMajor).
logadd("Speed in target orbit: " + targSpeed).
logadd("Speed at Circularization: " + currentSpeed).
logadd("Delta-V required: " + deltaV).
//logadd("Estimated burn time: " + targBurnTime).
