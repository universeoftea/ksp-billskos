// dock_align.ks
// Written by kanojo
// GPLv3
// Aligns the docking port of current vessel with docking port of target
// Assumes that target is a docking port and that control is 
// from docking port intended for use (or at least aligned with that docking port)

// TODO: Check if currently controlled from a docking port, if so, use that docking port
// TODO: If no docking port as control, check if any docking port tagged as dock_main, if so, use that
// TODO: What if big-size/small-size docking ports are available?

set targ to TARGET.
// Just uses the first available docking port (std size).
set dock to SHIP:PARTSDUBBED("Clamp-O-Tron Docking Port")[0].

// Set rotation
lock rot to dock:PORTFACING:INVERSE * SHIP:FACING.
lock steer to LOOKDIRUP(-targ:PORTFACING:VECTOR,targ:PORTFACING:UPVECTOR) * rot.

lock STEERING to steer.
wait 600.
