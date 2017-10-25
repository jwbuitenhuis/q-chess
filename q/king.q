\d .chess
\l utils.q

KINGMOVES: (
	(0  0  1 1 1 -1 -1 -1);
	(-1 1 -1 0 1 -1  0  1))

/ 8 options, if not friend and on board
king:{[board;x]
	candidates: relativeMoves[x;KINGMOVES];
	avoidFriends[board;x;candidates],castling[board;x]
	}

initialKing:59 3
initialRook:(56 63;0 7)

/ TODO:
/ can't castle if king in check or path checked
/ history of moves
canCastle:{[board;x;vector]
	canReach: (count vector) = count reachable[board;x;vector];
	white: 0 < signum board x;
	kingInit: 1=abs board initialKing[white];
	longVector:3=count vector;
	rookPosition: initialRook[white][longVector];
	rookInit: 5=abs board[rookPosition];
	canReach and kingInit and rookInit
	}

castling: {[board;x]
	vectors: (x + 1 2 3;x - 1 2);
	v:vectors where canCastle[board;x] each vectors;
	v[;1]
	}
