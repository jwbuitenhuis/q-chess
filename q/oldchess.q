/black
/white

/moves[0] / each white


/ reachable: {[x;board;moves]
/ 	hi: moves where moves > x;
/ 	lo: moves where moves < x;

/ 	/ if there's a boundary
/ 	/ return up until that point
/ 	/ else return all moves
/ 	$[count where board lo; lo where lo > max lo where board lo; lo],
/ 	$[count where board hi; hi where hi < min hi where board hi; hi]
/ 	}


/ given a list of ordered possible moves, which of these can
/ be reached, which means not blocked by a piece of my color
/ reachable2:{[x;board;moves]
/ 	if[not count moves;:moves];
/ 	/ identify the index of the piece in the possible moves
/ 	current: first where moves = x;
/ 	candidates: current # moves;
/ 	taken: where board candidates;
/ 	$[count taken;(1 + max taken) _ candidates;candidates]
/ 	}

/ reachable[0;00b; 1#0]~0#0
/ reachable[0;10b;1 0]~1#1
/ reachable[0;01b; 0 1]~0#0
/ reachable[0;011b; 0 1 2]~0#0
/ reachable[3;011b; 1 2 3]~0#0
/ reachable[0; 1010b; 0 1 2 3]~0#0
/ reachable[0; 1010b; 3 2 1 0]~enlist 1
/ reachable[0; 1111b; 0 1 2 3]~0#0
/ reachable[3; 1100b; 1 2 3]~enlist 2
/ reachable[2; 1100b; 3 2 1]~enlist 3
/ reachable[5;01000001b; 1 2 3 4 5 6 7]~2 3 4


/ left-up
	/ length: 1 + min (row; column);
	/ columns: (min (row;column)) - til length;
	/ rows: (max (row;column)) - til length;
	/ show (rows * 8) + columns;

/ right-up
	/ show length: 1 + min (row; 7 - column);
	/ show columns: (min (row;column)) + til length;
	/ show rows: (max (row;column)) - til length;
	/ show (rows * 8) + columns;

/ right-down
	/ show length: 1 + min (7 - row; 7 - column);
	/ show columns: (min (row;column)) + til length;
	/ show rows: (max (row;column)) + til length;
	/ show (rows * 8) + columns;

/ left-down
	/ show length: 1 + min (7 - row; column);
	/ show columns: (min (row;column)) - til length;
	/ show rows: (max (row;column)) + til length;
	/ show (rows * 8) + columns;



	/ offset: 6 10 15 17;
	/ moves: (x - offset), x + offset;
	/ show moves where (0 <= moves) and 64 > moves;



/ / given a position x and a vector of moves
/ / find the legal moves
/ innerReachable:{[x;friends;enemies;moves]
/ 	show x;
/ 	show friends;
/ 	show enemies;
/ 	show moves;
/ 	if[not count moves;:moves];
/ 	current: first where moves = x;
/ 	candidates: current # moves;
/ 	friendBoundary: 1 + max where friends candidates;
/ 	enemyBoundary: max where enemies candidates;
/ 	boundary: max (friendBoundary;enemyBoundary);
/ 	$[0 <= boundary;boundary _ candidates;candidates]
/ 	}

/ / project friends and enemies based on piece under investigation
/ reachable:{[board;x]
/ 	boards: (board > 0;board < 0);
/ 	innerReachable[x] . $[0 < board x; ::; reverse] boards
/ 	}


/ getMoves: {[color;depth;board;x]
/ 	moves: dispatch[abs board x][board;x];
/ 	boards: move[board;x] each moves;
/ 	scores: getBestMove[neg color;depth-1] each boards;

/ 	/ build a list with scored moves:
/ 	/ x => target: score
/ 	flip((count moves)#x;moves;scores)
/ 	}

/ getBestMove: {[color;depth;board]
/ 	if[0 = depth;:score[color;board]];

/ 	pieces: where color = signum board;

/ 	show moves: raze getMoves[color;depth;board] each pieces;
/ 	/ show min moves[;2];
/ 	/ show max moves[;2];
/ 	$[color>0;max;min] moves[;2]
/ 	}


/ getMoves: {[board;x]
/ 	/ get the generator for the piece type
/ 	/ get a list of moves
/ 	/ for each move, generate a new board
/ 	move[board;x] each dispatch[abs board x][board;x]
/ 	}

/ gen: {[color;board]
/ 	pieces: where color = signum board;
/ 	raze moves[board] each pieces
/ 	/ result: pieces!moves[board] each pieces;
/ 	/ (where not value count each result) _ result
/ 	}

/ do a white move and a black move
/ generate: {[boards]
/ 	boards: raze gen[1] peach boards;
/ 	show count boards;
/ 	boards: raze gen[-1] peach boards;
/ 	show count boards;
/ 	show scored: group scoreBoard[-1] each boards;
/ 	best: first desc key scored;
/ 	winners: scored best;
/ 	boards winners
/ 	}


/ \t boards: generate/[2;enlist board]
/ show "after"
/ show count boards


/ given a board, generate all possible next boards
/ for each of these, switch to the other side and do the same
/ the goal is to score the options in the current board and execute the best one.

/ given a board, identify all possible moves
/ brute-force permutations of moves, find moves that result in
/ the objective of taking opponents' pieces.
/ other objective could be having pieces guarded
/ score every move based on the percentage of possibilities for gain

/ instead of generating boards, generate arrays of moves?
/ can we memoize parts of the generation?
/ set the depth, and do a depth-first search
/ a generation should yield a score
/ the score measures the possibilities
/ get the moves and countermoves - so when scoring there's a balance
/ can we see the moves instead of the boards? much more compact
/ piece p at position x moved to position y
/ score a move by running a statistic on its implication
/ get the average score of all boards it produces
/ only search the best boards - my moves

/ why is it slow? the permutations are too many.
/ we're storing all the boards
/ so we have to preselect which ones to pursue
/ make a stupid scoring function - saldo of pieces
/ make the traversal efficient
/ focus on the best scoring options
/ score board between 0 - 1 based on:
/ - number pieces, valued. king is a multiplication factor
/ - score is relative to opposite party score, divide 1 over both
/ - initial score should be 0.5
/ - pieces covered by other pieces are more valuable
/ - find the move with the highest minimum, and follow that down

/ for a given board, generate all possible moves
/ 	for each move, generate all possible counter moves
/		for each counter move, score the board
/       return the minimum of these scores
/   search deeper into the top moves

/ we can't hope to find the ultimate best strategy because there's
/ too many possibilities, but when spend a limited time searching
/ for strong course of action

/ recurse until max depth.

/ which moves are interesting?
/ - covered by friends
/ - not covered by enemies
/ - 
/ number of possible strikes and counterstrikes

/ maintain an equilibrium and trade pieces until the
/ game becomes solvable
/ 1. decide if game is solvable (10 sec < (prd moves per piece) / moves per sec)
/ king: <=9, queen: <28, bishop <14, knight: <=8, rook:<=15, pawn:<=6  
/ 2. else, only do moves that maintain equilibrium
/ mirror enemy moves?

/ optimisation:
/ - cache all til's - meh
/ - take out sorting - stick it in the unit tests - meh
/ - pawns should be the expensive part
/ - memoise

/ how do we multiply productivity?

/.z.ws:{neg[.z.w] -8!respond[-9!x]}
/ .z.ph:{
/ 	"\r\n" sv ("HTTP/1.1 200 OK"; "Access-Control-Allow-Origin: *"; 
/ 	"Content-Type: application/json"; ""; (.j.j "hello world"))
/ 	}
/ .z.pp:{[x] 
	/ show x;

	/ .h.hp["hello"]
/	"HTTP/1.1 200 OK\nContent-Type: text/html\n\n", "hello" /string value 1_x 0
	/ }
/	.h.hp["200 OK";`txt;"hello world"]};

.z.ph:{
	show x 0;
	show x 1;
	"HTTP/1.1 200 OK\nContent-Type: text/html\n\n", string value 1_x 0
	}
/ .dotz.ph.ORIG: .z.ph
/ .z.ph:{
/ 	/ show -9!x;
/ 	/ show x;
/ 	show ".z.ph called";
/ 	show x[0];
/ 	show "-----------";
/ 	show x[1];
/ 	.dotz.ph.ORIG[x]
/ 	/ .dotz.ph[x]
/ 	}



/ minimax: {[depth;color;alpha;board]
/ 	if[0 = depth;:score[board]];

/ 	color: neg color;
/ 	moves: getMoves[board;color];
/ 	/ TODO - account for black
/ 	if[0 = count moves;:0f];

/ 	/ we've refuted this part of the tree
/ 	i: 0;
/ 	myScore: 1;
/ 	show "minimax";
/ 	show alpha;
/ 	while[(i < count moves) and myScore < alpha;
/ 		myMove: moves[i];
/ 		myBoard: .[move[board];myMove];
/ 		show myScore: .z.s[depth-1;color;alpha;myBoard];
/ 		show "alpha";
/ 		show alpha: min(myScore;alpha);
/ 		i:1+i;
/ 	];

/ 	myScore
/ 	/ - alpha beta pruning
/ 	/ - consider the attack options - separate run for attack?
/ 	/ - seek equilibrium: score by least deviation from 0.5
/ 	/ 1 - max scores
/ 	}

/ pieces: 5 4 3 1 2 3 4 5
/ / board: raze (pieces;8#6;32#0;8#-6;neg pieces)
/ board: (1,5,(8#0),-1,-6,(52#0))

/ should return two numbers: source => destination
/ counterMove: {[board;depth;color]
/ 	moves: getMoves[board;depth;color];
/ 	moves
	/ / / scores: getScores[depth;color;board;moves];
	/ / boards: .[move[board]] each moves;
	/ / scores: minimax[depth-1;color;0] each boards;
	/ moves!scores
/	best: max scores;
/	moves where scores = best
	/ }

/ bestMove:{[scoredMoves]
/ 	moves: key scoredMoves;
/ 	scores: value scoredMoves;
/ 	best: max scores;
/ 	first moves where scores = best
/ 	}

/ counterMove:{[board;color]
/ 	root[board;3;color]
	/ move: bestMove[result];
	/ board: .[move[board]] first moves;
	/ show "move:";
	/ show first moves;
	/ show 8 cut board;
	/ first moves
	/ }

/ show 8 cut board
/ result: counterMove[board;3;1]
/ move: bestMove[result];
/ show "count"
/ show cnt;