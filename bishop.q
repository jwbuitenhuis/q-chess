\l utils.q

.chess.leg: {[row;col;minrow;mincol;op1;op2]
	series: 1 + til min (minrow; mincol);
	op2[col;series] + op1[row;series] * 8
	}

/ cached vectors
.chess.bishopVectors:{[x]
	row: x div 8;
	col: x mod 8;
	f: .chess.leg[row;col];

	/ 4 diagonal vectors, all legs of 'x'
	params: (
		(row;col;-;-);
		(row;7 - col;-;+);
		(7 - row;7 - col;+;+);
		(7 - row;col;+;-)
	);

	.'[f;params]
	} each til 64

.chess.bishop:{[board;x]
	vectors: .chess.bishopVectors[x];
	raze .chess.reachable[board;x] each vectors
	}
