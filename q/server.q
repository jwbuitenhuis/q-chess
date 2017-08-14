\l chess.q
\p 5042

respond: {[board]
	board: "j"$board;
	t0: `long$.z.T;
	moves: getMoves[board;3;1];
	show "taken: ", string `long$.z.T - t0;
	moves
	}

httpHeaders: (
	"HTTP/1.1 200 OK";
	"Access-Control-Allow-Origin: *";
	"Content-Type: application/json";
	"")

.z.pp:{
	request: " " vs x 0;
	/ show request 0;
	/ show request 1;
	"\r\n" sv httpHeaders,enlist .j.j respond .j.k request 1
	}

/ b:5 4 3 1 2 3 4 5 0 6 0 0 6 6 6  0 0 0 6 0 0 0 0 -2 0 0 0 0 0 0 0 0 0 0 6 -4 0 0 0 0 0 0 0 0 -4 0 0 -6 -6 -6 0 -6 -6 -6 -6 -5 0 -3 -1 0 -3 0 -5
/ show count b
/ show 8 cut b
/ / b: (5;0;5;1;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;-1;0;0;0;0;0;0;0)
/ pieces: where 1 = signum b;
/ show desc moves: raze pieces,'' getPieceMoves[b] each pieces;

/result: getMoves[b;3;1]
/show `score xdesc result