\l utils.q

.chess.KINGMOVES: (
	(0 0 1 1 1 -1 -1 -1);
	(-1 1 -1 0 1 -1 0 1))

/ 8 options, if not friend and on board
/ TODO castling
.chess.king:{[board;x]
	candidates: .chess.relativeMoves[x;.chess.KINGMOVES];
	.chess.avoidFriends[board;x;candidates]
	}
