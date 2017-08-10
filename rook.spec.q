\l rook.q
show `rook

rook[0 6 0 5 0 -6 0 0,(56#6);3]~2 4 5
rook[6 0 -1 -5 6 -6 0 0 0,(55#6);0]~1 2 8

rook[64#1;0]~0#0

/ empty board with just one rook in the corner
rook[(1#5),(63#0);0]~1 2 3 4 5 6 7 8 16 24 32 40 48 56

/ rook between two rows of pawns (hypothetical)
rook[(8#6),(1#5),(7#0),(8#6),(40#0);8]~9 10 11 12 13 14 15

/ rook with only one place to go
rook[(1#5),0,(62#1#6);0]~1#1

/ / rook with two places to go
rook[0,(1#5),0,(61#1#6);1]~0 2

/ rook can go forward by one
rook[(1#5),(7#1#6),0,(54#1#6);0]~1#8

/ rook can go forward by one or two
rook[(1#5),(7#1#6),0,(7#1#6),0,(47#1#6);0]~8 16
