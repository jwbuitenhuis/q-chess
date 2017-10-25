\l rook.q
\l bishop.q
\d .chess

/ queen = rook + bishop
queen:{[board;x]
	asc .chess.rook[board;x],.chess.bishop[board;x]
	}
