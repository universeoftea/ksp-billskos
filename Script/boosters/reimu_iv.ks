//Launch script for Reimu IV launcher

//Clear terminal of any garbage
CLEARSCREEN.

//Initiate countdown
PRINT "Vehicle on internal power...".
PRINT "Reimu is now in control of countdown.".
SET gravity_turn TO HEADING(90,90).
LOCK STEERING TO gravity_turn.
LOCK THROTTLE TO 1.0.
FROM {local countdown is 10.} UNTIL countdown = 0 STEP {SET countdown to countdown - 1.} DO {
	PRINT "..." + countdown.
	WAIT 1.
}

STAGE.
PRINT "Liftoff!".

WAIT UNTIL SHIP:AIRSPEED > 100.
PRINT "Initiating gravity turn.".
LOCAL gturn IS 90.
//Trying with a split gturn
//One until 10000 and one until 30000
//Previous was 1 degree per 1.5 sec until 25000
UNTIL SHIP:ALTITUDE > 10000 {
	SET gturn TO gturn-1.
	PRINT "Pitching to: " + gturn.
	SET gravity_turn TO HEADING(90,gturn).
	WAIT 1.5.
}
UNTIL SHIP:ALTITUDE > 30000 {
	SET gturn TO gturn-1.
	PRINT "Pitching to: " + gturn.
	SET gravity_turn TO HEADING(90,gturn).
	WAIT 1.
}
UNTIL gturn = 0 OR SHIP:ALTITUDE > 55000 OR SHIP:APOAPSIS = 100000 {
	SET gturn TO gturn-1.
	PRINT "Pitching to: " + gturn.
	SET gravity_turn TO HEADING(90,gturn).
	WAIT 0.5.
}

WAIT UNTIL SHIP:APOAPSIS > 100000.
LOCK STEERING TO SHIP:PROGRADE.
LOCK THROTTLE TO 0.
SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.

PRINT "Coasting to Apoapsis.".
WAIT UNTIL SHIP:ALTITUDE > 70000.  
PRINT "Boosted to injection orbit, Bye!".
STAGE.
WAIT 1.
SET SHIP:NAME TO "Reimu IV Booster".
WAIT 1.
RUN reimu_iv_landing.
