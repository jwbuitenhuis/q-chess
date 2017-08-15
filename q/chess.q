\l rook.q
\l queen.q
\l king.q
\l pawn.q
\l bishop.q
\l knight.q
\l score.q

/ white: 1, black: -1
/                1    2     3      4      5    6
dispatch: `empty`king`queen`bishop`knight`rook`pawn

performMove: {[board;x;move]
	board[move]: board[x];
	board[x]:0;
	board
	}

getPieceMoves: {[board;x]
	pieceFn: .chess[dispatch[abs board x]];
	pieceFn[board;x]
	}

getScore: {[board;depth;color;alpha;move]
	board: performMove[board] . move;

	if[0 = depth;:.chess.score[board;color]];

	moves: legalMoves[board;neg color];
	results:();
	i:0;
	localMax:0;

	while[(localMax<1-alpha) and i < count moves;
		result: .z.s[board;depth-1;neg color;localMax;moves[i]];
		localMax:max(localMax;result);
		results:results,enlist result;
		i+:1
	];

	1-max 0,results
	}

legalMoves:{[board;color]
	pieces: where color = signum board;
	raze pieces,'' getPieceMoves[board] each pieces
	}

getMoves: {[board;depth;color]
	moves: legalMoves[board;color];
	scores: getScore[board;depth;color;0] peach moves;
	flip `move`score!(moves;scores)
	}
