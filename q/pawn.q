/ opposite color
.chess.enemy:{not sum signum (x;y)}

.chess.PAWNMOVES: 8 16 9 7

/ in its initial position, a pawn can go forward by one or two
/ in subsequent positions, it can go forward by one
/ it may strike diagonally either way
/ TODO: en-passant, switch to queen
.chess.pawn: {[board;x]
	white: 0 < board x;
	isInitialRow: $[white;1;6] = x div 8;

	/ 1. one forward (8) if:
	/ - target is empty and on the board
	/ 2. two forward (16) if:
	/ - target is empty, on the board and pawn hasn't been moved
	/ 3,4. strike left (9) /right (7)
	/ - target is occupied by an enemy
	/ moves: x + PAWNMOVES * signum board x;
	moves: $[white;+;-] [x; .chess.PAWNMOVES];

	moves where (
		0 = board moves 0;
		isInitialRow and 0 = sum board moves[0 1];
		.chess.enemy[board x; board moves 2];
		.chess.enemy[board x; board moves 3])
	}
