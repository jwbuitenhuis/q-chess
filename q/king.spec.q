\l king.q
\d .chess
show `king

king[1,(63#0);0]~1 8 9
king[(63#0),1;63]~54 55 62
king[1,5,61,-1;0]~8 9

/ castling
board:5,0,0,1,0,0,0,5,(56#0)
(asc king[board;3])~1 2 4 5 10 11 12

/ rook has moved
board:5,0,0,1,0,0,5,0,(56#0)
(asc king[board;3])~1 2 4 10 11 12

/ king has moved
board:5,0,0,0,1,0,0,5,(56#0)
(asc king[board;4])~3 5 11 12 13

/ black castling both ways
board:(56#0),-5,0,0,-1,0,0,0,-5
(asc king[board;59])~50 51 52 57 58 60 61

/ short black rook has moved
board:(56#0),0,-5,0,-1,0,0,0,-5
(asc king[board;59])~50 51 52 58 60 61

/ long black rook has moved
board:(56#0),-5,0,0,-1,0,0,-5,0
(asc king[board;59])~50 51 52 57 58 60

/ obstacle for long black
board:(56#0),-5,0,0,-1,0,3,0,-5
(asc king[board;59])~50 51 52 57 58 60
