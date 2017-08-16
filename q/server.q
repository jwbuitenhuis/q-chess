\l chess.q
\p 5042

counter: {[board]
	show board;
	t0: `long$.z.T;
	moves: getMoves[board;3;1];
	show "taken: ", string `long$.z.T - t0;
	moves
	}

api:`counter`legalMoves!(counter;legalMoves[;-1])

httpHeaders: (
	"HTTP/1.1 200 OK";
	"Access-Control-Allow-Origin: *";
	"Content-Type: application/json";
	"")

.z.pp:{
	request: " " vs x 0;
	board: "j"$.j.k request 1;
	response: api[`$request 0][board];
	"\r\n" sv httpHeaders,enlist .j.j response
	}

/ b: (5;0;5;1;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;-1;0;0;0;0;0;0;0)
/ result: getMoves[b;3;1]
/[5,0,3,1,2,3,4,5,0,6,0,0,6,6,0,6,0,0,0,6,0,0,0,0,-3,6,6,-6,0,0,6,0,0,0,0,0,-6,0,0,4,0,0,0,0,0,-6,0,0,-6,-6,-6,0,0,0,-6,-6,-5,0,0,-1,-2,-3,-4,-5]