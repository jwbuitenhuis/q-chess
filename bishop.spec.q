\l bishop.q
show `bishop

/ only bishop in corner
(asc .chess.bishop[(1#4),(63#0);0])~9 18 27 36 45 54 63

/ blocked in corner
(asc .chess.bishop[(1#4),(8#0),(1#6),(54#0);0])~0#0

/ bishop blocked one step from corner
(asc .chess.bishop[(9#0),(1#4),(8#0),(1#6),(45#0);9])~0 2 16
