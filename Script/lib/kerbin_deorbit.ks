// kerbin_deorbit.ks
// Written by kanojo
// Released under the GPLv3 licence
// This script waits until the proper time to deorbit and land at KSC
// Assuming landing with parachutes and no steering capabilities

// Parameters, change these as you please
set LandObtAlt to 100000.
set deorbLng to -176.
set deorbPe to 0.


LOCK shipPos TO SHIP:GEOPOSITION.

LOCK STEERING TO RETROGRADE.
WAIT UNTIL shipPos:LNG > deorbLng AND shipPos:LNG < deorbLng + 2.

LOCK THROTTLE TO 1.
WAIT UNTIL SHIP:PERIAPSIS < deorbPe.
LOCK THROTTLE TO 0.

LOCK STEERING TO HEADING(0,0).
WAIT UNTIL SHIP:ALTITUDE < 75000.
STAGE.
LOCK STEERING TO RETROGRADE.
WAIT UNTIL SHIP:ALTITUDE < 55000.

UNLOCK STEERING.
WAIT UNTIL ALT:RADAR < 5000.
CHUTESSAFE ON.

WAIT UNTIL SHIP:STATUS = "LANDED" OR SHIP:STATUS = "SPLASHED".

