\l utils.q

.chess.KINGMOVES: (
	(0 0 1 1 1 -1 -1 -1);
	(-1 1 -1 0 1 -1 0 1))

/ Castling may only be done if the king has never moved,
/ the rook involved has never moved, the squares between
/ the king and the rook involved are unoccupied, the king
/ is not in check, and the king does not cross over or end
/ on a square in which it would be in check. 

/ 8 options, if not friend and on board
/ TODO castling
.chess.king:{[board;x]
	candidates: .chess.relativeMoves[x;.chess.KINGMOVES];
	.chess.avoidFriends[board;x;candidates]
	}
