\l rook.q
\l queen.q
\l king.q
\l pawn.q
\l bishop.q
\l knight.q
\l score.q

/ white: positive, black: negative
/ king 	 1
/ queen  2
/ bishop 3
/ knight 4
/ rook 	 5
/ pawn   6
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

cnt: 0
formatMove: {[board;depth;color;move;alpha]
	`cnt set cnt+1;
	/ show cnt;
	board: performMove[board;move[0];move[1]];
	result:`from`to`color`board!(move[0];move[1];color;`board);

	if[0 = depth;result[`score]:.chess.score[board];:result];

	moves: getMoves[board;depth-1;neg color;alpha];
	result[`moves]:moves;
	scores: {x[`score]} each moves;
	result[`score]: min 1,scores;
	result
	}

getMoves: {[board;depth;color;scoreToBeat]
	pieces: where color = signum board;
	moves: raze pieces,'' getPieceMoves[board] each pieces;
	result:();
	i:0;
	alpha: scoreToBeat;
	localMin:1;
	while[(localMin > alpha) and i < count moves;
		move: formatMove[board;depth;color;moves[i];scoreToBeat];		
		localMin:scoreToBeat:min(localMin;move[`score]);
		move[`scoreToBeat]:scoreToBeat;
		result:result,enlist move;
		i+:1
	];
	result
	}
