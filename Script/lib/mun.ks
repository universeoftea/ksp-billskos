// Create and execute a node doing a transfer to the mun

set deltaV to 838. //From LKO 100km to LMO 10km
set targAng to 111.

// Akward way of converting longitude to an absolute value
if SHIP:GEOPOSITION:lng < 0 {
	lock shipLNG to -SHIP:GEOPOSITION:lng.
} else {
	lock shipLNG to SHIP:GEOPOSITION:lng.
}
if BODY("Mun"):GEOPOSITION:lng < 0 {
	lock munLNG to -BODY("Mun"):GEOPOSITION:lng.
} else {
	lock munLNG to BODY("Mun"):GEOPOSITION:lng.
}
lock relAng to munLNG - shipLNG.

//Wait until 150 < relAng < 200
if  relAng < 150 {
	logadd("We are too close to prepare for burn, waiting one orbit").
	wait until relAng > 150.
}

logadd("Current burnang is: " + round(relAng)).
logadd("Wating for ang to become < 200").
wait until relAng < 200.
logadd("Current burnang is: " + round(relAng)).

// get time to ang in s
set timetoang to ((relAng - targAng) * constant:pi / 180 ) / sqrt( ( ship:body:mass * constant:g / ship:orbit:semimajoraxis ^ 3)).
logadd("Time to burn at " + targAng + " degrees is: " + timetoang).

set H1Node to NODE(TIME:SECONDS+timetoang,0,0,deltaV).
add H1Node.

// TODO: Wait for SOI change, timewarp?
// runpath("0:/lib/node_circ.ks","pe").
// runpath("0:/lib/node_exec.ks").
