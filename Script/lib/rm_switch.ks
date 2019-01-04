parameter switchtorunmode.

function rm101 {
	resetshipstate().
	setrunmode(101).
	printshipstatus().
	runpath("lib/node_exec.ks").
	resetshipstate().
	setrunmode(0).
}
function rm110 {
	setrunmode(110).
	printshipstatus().
	runpath("lib/node_circ.ks","ap").
	rm101().
}
function rm111 {
	setrunmode(111).
	printshipstatus().
	runpath("lib/node_circ.ks","pe").
	rm101().
}
function rm200 {
	setrunmode(200).
	printshipstatus().
	copypath("0:/lib/mun.ks","lib/").
	runoncepath("lib/mun.ks").
	rm201().
	rm202().
}
	
function rm0 {	
	until false {
		printshipstatus().
		wait 1.
		
		if AG10 or shipcfg["runmode"] = 101 {
			AG10 OFF.
			rm101().
		} else if AG9 or shipcfg["runmode"] = 110 {
			AG9 OFF.
			rm110().
		} else if AG8 or shipcfg["runmode"] = 111 {
			AG8 OFF.
			rm111().
		}
	}
}

if switchtorunmode = 200 { 
	rm200().
} else {
	rm0().
}
