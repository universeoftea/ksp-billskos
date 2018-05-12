// Create and execute a node doing a transfer to the mun

set deltaV to 838. //From LKO 100km to LMO 10km
set targang to 111.

// Akward way of converting longitude to an absolute value
if SHIP:GEOPOSITION:lng < 0 {
	lock shippos to -SHIP:GEOPOSITION:lng.
} else {
	lock shippos to SHIP:GEOPOSITION:lng.
}
if BODY("Mun"):GEOPOSITION:lng < 0 {
	lock munpos to -BODY("Mun"):GEOPOSITION:lng.
} else {
	lock munpos to BODY("Mun"):GEOPOSITION:lng.
}
lock currentang to munpos - shippos.

logadd("Current burnang is: " + round(currentang)).
logadd("Wating for ang to become < 200").
wait until currentang < 200.
logadd("Current burnang is: " + round(currentang)).

// get time to ang in s
set timetoang to ((currentang - targang) * constant:pi / 180 ) / sqrt( ( ship:body:mass * constant:g / ship:orbit:semimajoraxis ^ 3)).
logadd("Time to burn at " + targang + " degrees is: " + timetoang).

set H1Node to NODE(TIME:SECONDS+timetoang,0,0,deltaV).
add H1Node.

// TODO: Wait for SOI change, timewarp?
// runpath("0:/lib/node_circ.ks","pe").
// runpath("0:/lib/node_exec.ks").
