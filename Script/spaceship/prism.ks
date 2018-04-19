function libimport {
	parameter libname.
	if not exists("lib") {
		createdir("lib").
	}
	if not exists("lib/" + libname + ".ks") {
		copypath("0:/lib/" + libname + ".ks","lib/").
	}
	runoncepath("lib/" + libname + ".ks").
}
function funcimport {
	parameter funcname.
	if not exists("lib") {
		createdir("lib").
	}
	if not exists("lib/" + funcname + ".ks") {
		copypath("0:/lib/" + funcname + ".ks","lib/").
	}
}
	
libimport("ship_monitor").
funcimport("node_exec").
funcimport("node_circ").
funcimport("rm_switch").

function resetshipstate {
	unlock STEERING.
	SAS OFF.
	RCS OFF.
	BRAKES OFF.
	LOCK THROTTLE TO 0.
	UNLOCK THROTTLE.
	SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.
}

runpath("lib/rm_switch.ks").
