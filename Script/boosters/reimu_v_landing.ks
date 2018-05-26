// kerbin_deorbit.ks
// Written by kanojo
// Released under the GPLv3 licence
// This script waits until the proper time to deorbit and land at KSC
// Assuming landing with parachutes and no steering capabilities

// Parameters, change these as you please
set LandObtAlt to 100000.
if ship:name = "Reimu VH Booster" {
	set deorbLng to 115.25. //+0.05
	set deorbPe to 40000.
} else {
	set deorbLng to 127. //+0.8
	set deorbPe to 40000.
}

GEAR OFF.

SAS OFF.
LOCK shipPos TO SHIP:GEOPOSITION.

LOCK STEERING TO RETROGRADE.
//Timewarp
if shipPos:LNG < 100 or shipPos:LNG > deorbLng + 2
	set warpmode to "RAILS".
	set warp to 50.
	wait until shipPos:LNG > 100 and shipPos:LNG < deorbLng.
	set warp to 0.

WAIT UNTIL shipPos:LNG > deorbLng AND shipPos:LNG < deorbLng + 2.

LOCK THROTTLE TO 1.
WAIT UNTIL SHIP:PERIAPSIS < deorbPe.
LOCK THROTTLE TO 0.

//Timewarp
wait 5.
set warpmode to "RAILS".
set warp to 50.
wait until ship:altitude < 75000.
set warp to 0.
set warpmode to "PHYSICS".
set warp to 2.

WAIT UNTIL SHIP:AIRSPEED < 420.
CHUTESSAFE ON.
WAIT UNTIL SHIP:AIRSPEED < 260.
CHUTESSAFE ON.

//More timewarp stuff
wait until ALT:RADAR < 200.
set warp to 0.
wait 2.

GEAR ON.
lock STEERING to UP.

PRINT "Wait until 60 m radar altitude".
WAIT UNTIL ALT:RADAR < 60.
PRINT "Do a soft landing...".

//This formula for setting throttle is not going to softland...
//......
//Actually, works great with all engines activated, especially in water
//but can we get more dv if we only use the center engine?
LOCK THROTTLE TO SHIP:AIRSPEED/40.
WAIT UNTIL SHIP:STATUS = "LANDED" OR SHIP:STATUS = "SPLASHED".

LOCK THROTTLE TO 0.
PRINT "Touchdown!".
SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.

wait 10.
