// kerbin_deorbit.ks
// Written by kanojo
// Released under the GPLv3 licence
// This script waits until the proper time to deorbit and land at KSC
// Assuming landing with parachutes and no steering capabilities

// Parameters, change these as you please
set LandObtAlt to 100000.
if ship:name = "Reimu VH Booster" {
	set deorbLng to 60. //-15
	set deorbPe to 50000.
	set timewarpLNG to 45.
	set reentryspd to 1500.
} else {
	set deorbLng to 95. //-5
	set deorbPe to 45000.
	set timewarpLNG to 85.
	set reentryspd to 1900. //+100
}

GEAR OFF.

SAS OFF.
LOCK shipPos TO SHIP:GEOPOSITION.

LOCK STEERING TO RETROGRADE.
//Timewarp
if shipPos:LNG < timewarpLNG or shipPos:LNG > deorbLng + 2
	set warpmode to "RAILS".
	set warp to 50.
	wait until shipPos:LNG > timewarpLNG and shipPos:LNG < deorbLng.
	set warp to 0.

WAIT UNTIL shipPos:LNG > deorbLng AND shipPos:LNG < deorbLng + 2.

LOCK THROTTLE TO 0.5.
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

lock STEERING to SRFRETROGRADE.

wait until SHIP:ALTITUDE < 30000.
if SHIP:AIRSPEED > 1800 {
	LOCK THROTTLE TO 1.
	wait until SHIP:AIRSPEED < reentryspd.
	LOCK THROTTLE TO 0.
}

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
