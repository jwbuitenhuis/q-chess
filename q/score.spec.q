\l score.q

score[1;1,2,3,4,6#0]~20

/ no king - no value
score[1;2,2,3,4,6#0]~0

/ king + all black pawns
score[-1;-1,64#-6]~64
