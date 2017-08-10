\l rook.q
\l bishop.q

/ queen = rook + bishop
.chess.queen:{[board;x]
	asc .chess.rook[board;x],.chess.bishop[board;x]
	}
