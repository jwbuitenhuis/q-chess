/ opposite color cancels out to 0
\l utils.q
\d .chess

PAWN: (1 2 1 1;0 0 1 -1)
PAWNMOVES: (neg PAWN;PAWN) 

/ in its initial position, a pawn can go forward by one or two
/ in subsequent positions, it can go forward by one
/ it may strike diagonally either way
/ TODO: switch to queen
pawn: {[board;x]
	piece: board x;
	white: 0 < piece;
	isInitialRow: $[white;1;6] = x div 8;

	/ 1. one forward if:
	/ - target is empty and on the board
	/ 2. two forward if:
	/ - target is empty, on the board and pawn hasn't been moved
	/ 3,4. strike left / right
	/ - target is occupied by an enemy
	/ at least 3 or 4 is on the board
	moves: relativeMoves[x;PAWNMOVES white];
	target: board moves;

	moves where (
		0 = target 0;
		/ short circuit is faster than and (eager)
		$[isInitialRow;0=sum target 0 1;0b];
		/ non-dry but faster than factoring into a lambda
		$[white;0>target 2;0<target 2];
	 	$[3 < count moves;$[white;0>target 3;0<target 3];0b])
	}
