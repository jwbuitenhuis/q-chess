\l score.q
\d .chess

show `score
score[1 2 3 4,6#0;1]~1f

/ no king - no value
score[2 2 3 4,6#0;1]~0n

/ king + all black pawns
score[-1,64#-6;1]~0f
