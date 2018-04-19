// ship_monitor.ks
// Written by kanojo
// GPLv3
// Prints out basic information about the ship
// Also prints a log about scripts running in the background

//lock ap to ROUND(SHIP:APOAPSIS).
//lock pe to ROUND(SHIP:PERIAPSIS).
//lock apeta to ROUND(ETA:APOAPSIS).
//lock peeta to ROUND(ETA:PERIAPSIS).
lock shipname to SHIP:NAME.
lock shipstatus to SHIP:STATUS.
lock shipmass to ROUND(SHIP:MASS*1000).
lock shipthrust to ROUND(SHIP:AVAILABLETHRUST).
lock parentbody to SHIP:BODY:NAME.

CLEARSCREEN.

set loglist to list("===============","This is the monitor program for ships","Any log items appear here","Ship information is shown above","==============="," ","Initializing log buffer","Initializing monitor","Trying to detect runmode","=============").

if EXISTS("shipcfg.json") {
	set shipcfg to READJSON("shipcfg.json").
	logadd("Detected runmode " + shipcfg["runmode"]).
} else {
	logadd("No runmode set, starting computer in runmode 0").
	set shipcfg to LEXICON().
	shipcfg:ADD("runmode",0).
	WRITEJSON(shipcfg,"shipcfg.json").
}

function logadd {
	parameter logtext.
	loglist:ADD(logtext).
	loglist:REMOVE(0).
}

function printlog {
	print loglist[9].
	print loglist[8].
	print loglist[7].
	print loglist[6].
	print loglist[5].
	print loglist[4].
	print loglist[3].
	print loglist[2].
	print loglist[1].
	print loglist[0].
}

// Prints out a basic status screen with logs
function printshipstatus {
	clearscreen.
	printlog().
	print("============================================").
	print(" ").
	print "Spaceship: " + shipname.
	print "Runmode: " + shipcfg["runmode"].
	//Print out status of ship in one line
	print "Status:" + shipstatus at (1,14).
	print "At: " + parentbody at (30,14).

//	print "Ap: " + ap + "m" at (1,16).
//	print "ETA: " + apeta + "s" at (30,16).
//	print "Pe: " + pe + "m" at (1,17).
//	print "ETA: " + peeta + "s" at (30,17).
	print "Mass: " + shipmass + "kg" at (1,18).
	print "Thrust: " + shipthrust at (30,18).
}

function setrunmode {
	parameter nextmode.
	logadd("Switching runmode from " + shipcfg["runmode"] + " to " + nextmode).
	set shipcfg["runmode"] to nextmode.
	WRITEJSON(shipcfg,"shipcfg.json").
}
