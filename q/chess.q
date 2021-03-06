\l rook.q
\l queen.q
\l king.q
\l pawn.q
\l bishop.q
\l knight.q
\l score.q

\d .chess
/ white: 1, black: -1
/                1    2     3      4      5    6
dispatch: `empty`king`queen`bishop`knight`rook`pawn

/ short castle moves positive
castle:{[board;move]
	direction: $[move in 1 57;1;-1];
	rook: board[move - direction];
	@[board;(move+direction;move-direction);:;(rook;0)]
	}

performMove: {[board;x;move]
	board: @[board;(move;x);:;(board x;0)];
	$[(1 > abs x - move) and 1=abs board x;castle[board;move];board]
	}

/ use .chess dispatch to help profiler
getPieceMoves: {[board;x] .[.chess dispatch[abs board x];(board;x)]}

getScore: {[board;depth;color;alpha;move]
	board: performMove[board] . move;
	if[0 = depth;:score[board;color]];

	moves: legalMoves[board;neg color];
	results:();
	i:localMax:0;

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