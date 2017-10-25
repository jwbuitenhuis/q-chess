\l utils.q
\d .chess

KNIGHTMOVES: (
	(1 1 -1 -1 2 2 -2 -2);
	(2 -2 2 -2 1 -1 1 -1))

/ 8 options
/ legal if on the board, and no friend on that position
knight:{[board;x]
	candidates: .chess.relativeMoves[x;.chess.KNIGHTMOVES];
	.chess.avoidFriends[board;x;candidates]
	}

