//Launch script for Cirno launcher

//The Cirno booster does not have an internal CPU, this script therefore needs to be run from the spaceprobe itself.
//For the gravity turn to work the first stage of the booster needs a TWR of ~1.5
//Second stage should have TWR ~2, but more is probably fine.

// Set some launch parameters
SET inclination TO 90.


//Clear terminal of any garbage
CLEARSCREEN.
PRINT "Preparing for launch of Cirno booster".

//Initiate countdown
PRINT "Vehicle on internal power...".
SET gravity_turn TO HEADING(inclination,90).
LOCK STEERING TO gravity_turn.
FROM {local countdown is 10.} UNTIL countdown = 0 STEP {SET countdown to countdown - 1.} DO {
	PRINT "..." + countdown.
	WAIT 1.
}

STAGE.
PRINT "Liftoff!".

WAIT UNTIL SHIP:AIRSPEED > 50.

//WHEN MAXTHRUST = 0 THEN {
//	print "Staging".
//	STAGE.
//	WAIT 1.
//	STAGE.
//}

PRINT "Initiating gravity turn.".
LOCAL gturn IS 90.
//Trying with a split gturn
//One until 10000 and one until 30000
//Previous was 1 degree per 1.5 sec until 25000
UNTIL SHIP:ALTITUDE > 10000 {
	SET gturn TO gturn-1.
	PRINT "Pitching to: " + gturn.
	SET gravity_turn TO HEADING(inclination,gturn).
	WAIT 1.5.
}
UNTIL SHIP:ALTITUDE > 30000 {
	SET gturn TO gturn-1.
	PRINT "Pitching to: " + gturn.
	SET gravity_turn TO HEADING(inclination,gturn).
	WAIT 1.
}
UNTIL gturn = 0 OR SHIP:ALTITUDE > 55000 {
	SET gturn TO gturn-1.
	PRINT "Pitching to: " + gturn.
	SET gravity_turn TO HEADING(inclination,gturn).
	WAIT 0.5.
}
SET gturn TO 0.
WAIT UNTIL SHIP:ALTITUDE > 70000.

SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.

PRINT "Booster is done, releasing payload.".
STAGE.
