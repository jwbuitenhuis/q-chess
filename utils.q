/ given a path of moves, take up until the
/ first friend or including the first enemy
/ abs -1 +  1 => enemies => 0
/ abs -1 +  0 => neutral => 1
/ abs -1 + -1 => friends => 2 
.chess.reachable:{[board;x;moves]
	neutrality: sum signum (board moves; board x);
	enemies: 1 + where 0 = neutrality;
	friends: where 2 = abs neutrality;
	cutoff: min raze (enemies;friends;count moves);
	cutoff # moves
	}

/ moves; (rows;cols)
/ coords: applies these on the current cell
/ onboard: filter the ones that fit on the board
/ calculate board positions from the coordinates
.chess.relativeMoves:{[x;moves]
	coords: moves + (x div 8; x mod 8);
	onboard: where min raze (0<=;8>) @\:/: coords;
	sum coords[;onboard] * 8 1
	}

/ find the moves that are not occupied by friends
.chess.avoidFriends:{[board;x;moves]
	asc moves where not 2 = abs sum signum (board moves; board x)
	}
