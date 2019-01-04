function rm201 {
	setrunmode(201).
	// Create and execute a node doing a transfer to the mun
	
	set deltaV to 837. //From LKO 100km to LMO 10km 138m/s? -0.6 m/s
	set targAng to 111.
	function setgeo {
		// Akward way of converting longitude to an absolute value
		if SHIP:GEOPOSITION:lng < 0 {
			set shipLNG to 360+SHIP:GEOPOSITION:lng.
		} else {
			set shipLNG to SHIP:GEOPOSITION:lng.
		}
		if BODY("Mun"):GEOPOSITION:lng < 0 {
			set munLNG to 360+BODY("Mun"):GEOPOSITION:lng.
		} else {
			set munLNG to BODY("Mun"):GEOPOSITION:lng.
		}
		if munLNG-shipLNG < 0 {
			set relang to 360 - shipLNG + munLNG.
		} else {
			set relAng to munLNG - shipLNG.
		}
	}
	setgeo().
	logadd("Relative angle is: " + round(relAng)).
	printshipstatus().
	
	until relAng > 130 {
		wait 1.
		setgeo().
		logadd("Relative angle is: " + round(relAng)).
		printshipstatus().
	}	
	
	// get time to ang in s
	set timetoang to ((relAng - targAng) * constant:pi / 180 ) / sqrt( ( ship:body:mass * constant:g / ship:orbit:semimajoraxis ^ 3)).
	logadd("Time to burn at " + targAng + " degrees is: " + timetoang).
	
	set H1Node to NODE(TIME:SECONDS+timetoang,0,0,deltaV).
	add H1Node.

	rm101().
}

function rm202 {
	setrunmode(202).
	RCS ON.
	LOCK STEERING TO SHIP:PROGRADE.
	wait 5.
	if SHIP:ORBIT:NEXTPATCH:PERIAPSIS < 10000 { 
		//Make periapsis higher
		set SHIP:CONTROL:FORE to -0.2.
		wait until SHIP:ORBIT:NEXTPATCH:PERIAPSIS > 10000.
		set SHIP:CONTROL:FORE to 0.
	} else if SHIP:ORBIT:NEXTPATCH:PERIAPSIS > 15000 {
		//Make periapsis lower
		set SHIP:CONTROL:FORE to 0.2.
		wait until SHIP:ORBIT:NEXTPATCH:PERIAPSIS < 10000.
		set SHIP:CONTROL:FORE to 0.
	}
	RCS OFF.

	rm210().
}

function rm210 {
	setrunmode(210).
	set newalarm to addAlarm("SOIChange",TIME:SECONDS + SHIP:ORBIT:NEXTPATCHETA,SHIP:NAME + " CPU:SOI","Alarm created by flight computer on " + SHIP:NAME).
	set warpmode to "RAILS".
	set warp to 8.
	wait until SHIP:ALTITUDE > 300000.
	set warp to 8.
	wait until SHIP:ORBIT:BODY:NAME = "Mun".

	rm111().
}	
