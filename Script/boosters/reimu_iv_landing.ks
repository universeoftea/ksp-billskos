PRINT "This is the landing program for Reiumi IV.".
WAIT UNTIL SHIP:ALTITUDE < 70000.

//Turn off unneeded engines

LOCK THROTTLE TO 0.

//Turn on RCS, do turnaround manouver, turn off RCS
PRINT "Pointing retrograde".
RCS ON.
LOCK STEERING TO SRFRETROGRADE.
//Wait for stabilization in retrograde before turning off RCS again
PRINT "Holding until 55000 m altitude".
WAIT UNTIL SHIP:ALTITUDE < 55000.
RCS OFF.

//Once altitude is sufficently low, perform break burn to not burn up
//The altitude here is a wild guess and probably needs to be refined
WAIT UNTIL SHIP:ALTITUDE < 30000.
PRINT "Slowing down to 1500m/s".
LOCK THROTTLE TO 1.
//Again, totally guessing what airspeed is ok, so have a look at this later
WAIT UNTIL SHIP:AIRSPEED < 1500.
LOCK THROTTLE TO 0.

//Once altitude is ~10000 slow down to parachute velocity
WAIT UNTIL SHIP:ALTITUDE < 7000.
PRINT "Slowing down to 250m/s".
LOCK THROTTLE TO 1.
WAIT UNTIL SHIP:AIRSPEED < 250.

//Open parachutes
PRINT "Parachutes".
CHUTESSAFE ON.
LOCK THROTTLE TO 0.

//Make soft landing
PRINT "Wait until 40 m radar altitude".
WAIT UNTIL ALT:RADAR < 40.
PRINT "Do a soft landing...".

//This formula for setting throttle is not going to softland...
//......
//Actually, works great with all engines activated, especially in water
//but can we get more dv if we only use the center engine?
LOCK THROTTLE TO SHIP:AIRSPEED/30.
WAIT UNTIL SHIP:STATUS = "LANDED" OR SHIP:STATUS = "SPLASHED".

LOCK THROTTLE TO 0.
PRINT "Touchdown!".
SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.
