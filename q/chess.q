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
	board[move - direction]:0;
	board[move + direction]:rook;
	board
	}

performMove: {[board;x;move]
	board[move]: board[x];
	board[x]:0;

	$[(1 > abs x - move) and 1=abs board x;castle[board;move];board]
	}

getPieceMoves: {[board;x]
	// how get rid of .chess here?
	.[.chess[dispatch[abs board x]];(board;x)]
	}

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
	show moves: legalMoves[board;color];
	scores: getScore[board;depth;color;0] peach moves;
	flip `move`score!(moves;scores)
	}

/ b: 5 4 3 1 2 3 4 5 6 6 6 6 6 6 6 6 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -6 -6 -6 -6 -6 -6 -6 -6 -5 -4 -3 -1 -2 -3 -4 -5
/ b: 5 0 3 1 2 3 4 5 0 6 0 0 6 6 0 6 0 0 0 6 0 0 0 0 -3 6 6 -6 0 0 6 0 0 0 0 0 -6 0 0 4 0 0 0 0 0 -6 0 0 -6 -6 -6 0 0 0 -6 -6 -5 0 0 -1 -2 -3 -4 -5
/ \t result: getMoves[b;4;1]
/ show result