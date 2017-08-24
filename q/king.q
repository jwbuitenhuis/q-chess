\d .chess
\l utils.q

KINGMOVES: (
	(0  0  1 1 1 -1 -1 -1);
	(-1 1 -1 0 1 -1  0  1))

/ Castling may only be done if the king has never moved,
/ the rook involved has never moved, the squares between
/ the king and the rook involved are unoccupied, the king
/ is not in check, and the king does not cross over or end
/ on a square in which it would be in check. 

/ is king on original position?
/ are castling squares empty?
/ is rook on original position?
/ get enemy moves. any of targets in destination?
/ check history of moves here or when performing move?
/ 8 options, if not friend and on board
/ TODO castling
king:{[board;x]
	candidates: relativeMoves[x;.chess.KINGMOVES];
	avoidFriends[board;x;candidates]
	}

castling: {[board;x]
	
	}
