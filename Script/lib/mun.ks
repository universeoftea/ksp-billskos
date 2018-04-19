
// Calculate a hoffmann transfer from circular orbit (r1) to circular orbit (r2)

set targang to 111.

lock shippos to SHIP:GEOPOSITION:lng.
lock munpos to BODY("Mun"):GEOPOSITION:lng.

lock currentang to munpos - shippos.

print("Current burnang is: " + round(currentang)).
print("Wating for ang to become < 200").
wait until currentang > 120.
print("Current burnang is: " + round(currentang)).

// get time to ang in s
set timetoang to ((currentang - targang) * constant:pi / 180 ) / sqrt( ( ship:body:mass * constant:g / ship:orbit:semimajoraxis ^ 3)).
print("Time to burn at " + targang + " degrees is: " + timetoang).

set deltaV to 838. //From LKO 100km to LMO 10km
set H1Node to NODE(TIME:SECONDS+timetoang,0,0,deltaV).
add H1Node.
