/ white: positive, black: negative
/ king 	 1
/ queen  2
/ bishop 3
/ knight 4
/ rook 	 5
/ pawn   6

valuation: 0 1 10 5 5 7 1

scoreSide: {[color;board]
	pieces: abs board where color = signum board;
	kingFactor: 1 in pieces;
	kingFactor * sum valuation pieces
	}

score: {[board]
	friend: scoreSide[1;board];
	enemy: scoreSide[-1;board];
	friend % (friend + enemy)
	}