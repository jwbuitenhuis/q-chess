\l score.q
\d .chess

score[1,2,3,4,6#0]~1f

/ no king - no value
score[2,2,3,4,6#0]~0n

/ king + all black pawns
score[-1,64#-6]~0f
