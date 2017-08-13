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

formatMove: {[board;depth;color;move;alpha]
	board: performMove[board;move[0];move[1]];
	// result:`move`color`alpha!(move;color;alpha);

	if[0 = depth;:.chess.score[board;color]];
	// if[0 = depth;result[`score]:.chess.score[board;color];:result];

	results: getCounterMoves[board;depth-1;neg color;1-alpha];
	/ scores: results[;`score]; 
	score: 1-max 0,results;
	score
	/ result[`moves]:results;
	/ result[`score]:score;
	/ result
	}

/ a move is scored by looking at the 
getCounterMoves: {[board;depth;color;alpha]
	pieces: where color = signum board;
	moves: raze pieces,'' getPieceMoves[board] each pieces;
	results:();
	i:0;
	localMax:0;
	pruned:0b;
	// it should stop when the move is refuted.
	// that means a worse (higher) score has been found than alpha
	while[(not pruned) and i < count moves;
		result: formatMove[board;depth;color;moves[i];localMax];
		/ result[`localMax]:localMax;
		/ pruned:result[`pruned]:localMax>=alpha;
		pruned:localMax>=alpha;
		/ localMax:max(localMax;result[`score]);
		localMax:max(localMax;result);
		results:results,enlist result;
		i+:1
	];
	results
	}

getMoves: {[board;depth;color]
	pieces: where color = signum board;
	moves: raze pieces,'' getPieceMoves[board] each pieces;
	f:formatMove[board;depth;color;;0];
	result: {[f;x] `move`score!(x;f[x])}[f] each moves;
	/ scores: {[board;depth;color;move]
	/ 	show "master move: ",.Q.s move;
	/ 	formatMove[board;depth;color;move;0]
	/ 	}[board;depth;color] each moves;
	/ moves!scores
	result
	}
