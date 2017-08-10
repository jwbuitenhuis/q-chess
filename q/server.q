\l chess.q
\p 5042

respond: {[board]
	/ show "board";
	/ show board;
	board: "j"$board;
	/ show 8 cut board;
	moves: getMoves[board;2;1;0];
	moves
	}

httpHeaders: (
	"HTTP/1.1 200 OK";
	"Access-Control-Allow-Origin: *";
	"Content-Type: application/json";
	"")

.z.pp:{
	request: " " vs x 0;
	show request 0;
	show request 1;
	"\r\n" sv httpHeaders,enlist .j.j respond .j.k request 1
	}


b: (5;0;5;1;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;-1;0;0;0;0;0;0;0)
getMoves[b;2;1;0]