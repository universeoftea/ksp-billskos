function rm100 {
	resetshipstate().
	setrunmode(100).
	printshipstatus().
	runpath("lib/node_exec.ks").
	resetshipstate().
	setrunmode(0).
}
function rm101 {
	setrunmode(101).
	printshipstatus().
	runpath("lib/node_circ.ks","ap").
	rm100().
}
function rm102 {
	setrunmode(102).
	printshipstatus().
	runpath("lib/node_circ.ks","pe").
	rm100().
}
function rm200 {
	setrunmode(200).
	printshipstatus().
	copypath("0:/lib/mun.ks","lib/").
	runpath("lib/mun.ks").
	rm100().
}
	
	
until false {
	printshipstatus().
	wait 1.
	
	if AG10 and not shipcfg["runmode"] = 100 {
		AG10 OFF.
		rm100().
	} else if AG9 and not shipcfg["runmode"] = 101 {
		AG9 OFF.
		rm101().
	} else if AG8 and not shipcfg["runmode"] = 102 {
		AG8 OFF.
		rm102().
	} else if AG1 and not shipcfg["runmode"] = 200 {
		AG1 OFF.
		rm200().
	}
}
