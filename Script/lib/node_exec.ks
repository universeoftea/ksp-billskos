//node_exec.ks by Kanojo
//Executes the next upcoming node
//Licenced under GPLv3

logadd("Preparing to execute maneuver node").
set execnode to nextnode.
set dv0 to execnode:deltav:mag.
lock max_acc to ship:maxthrust/ship:mass.
set targBurnTime to dv0/max_acc.
lock nodeEta to execnode:eta.
lock nodeDeltaV to execnode:deltav:mag.

logadd("Estimated burn time: " + round(targBurnTime)).
logadd("Time to node is: " + round(nodeEta)).
lock steering to execnode:deltav.

until nodeEta < targBurnTime / 2 {
	printshipstatus().
	wait 0.5.
}
logadd("Starting burn").
if nodeDeltaV > 10 {
	lock THROTTLE to 1.
	
	until nodeDeltaV < 10 {
		printshipstatus().
	}
}

//Try to only do 2m/ss of acceleration for the last 15m/s (or max if acc is less than that)
lock THROTTLE TO min(1,2/max_acc).
wait until nodeDeltaV < 0.55555.

//Same, but 0.1m/ss for the last bit
lock THROTTLE TO min(1,0.1/max_acc).
wait until nodeDeltaV < 0.1.
lock THROTTLE TO 0.
unlock STEERING.
remove execnode.
logadd("Finished executing node, removing it").