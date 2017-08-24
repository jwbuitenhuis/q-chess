\l utils.q
\d .chess
/ a rook may move anywhere in it's current column and row
/ it may not pass a piece of its own color
/ it may strike the first enemy it encounters in any direction
/ TODO - castling
extremes: {(y where x < y; reverse y where x > y)}

/ cached list of rook movements
vectors:{
	row: (8 * x div 8) + til 8;
	col: (x mod 8) + 8 * til 8;
	v where 0 < count each v: raze extremes[x] each (row;col)
	} each til 64

rook:{[board;x]
	asc raze reachable[board;x] each vectors[x]
	}
