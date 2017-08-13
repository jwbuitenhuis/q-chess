\d .chess

/ white: positive, black: negative
/ king 	 1
/ queen  2
/ bishop 3
/ knight 4
/ rook 	 5
/ pawn   6

valuation: 0 1 10 5 5 7 1

scoreSide: {[board;color]
	pieces: abs board where color = signum board;
	(1 in pieces) * sum valuation pieces
	}

score: {[board;color]
	(first sides) % sum sides: scoreSide[board] each (color;neg color)
	}

valuation2: 0 900 10 5 5 7 1

score2: {[board;color]
	color * sum valuation2 abs board where color = signum board
	}
