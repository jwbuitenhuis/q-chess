\l chess.q

test: {[description;result;expected]
	if[result~expected;show "ok"]
	if[not result~expected;
		show description,": fail";
		show "    got: ",.Q.s result;
		show "    expected: ",.Q.s expected
	]
	}
/getMoves[(5 0 5 1,(52#0),-1,7#0);2;1;0]

/show 8 cut (1,5,(54#0),-1,7#0);

/ moves: getMoves[(1,5,(54#0),-1,7#0);2;1;0]
/ count moves

/ if alpha is 1, it should return an empty list
/ getMoves[(1,5,(54#0),-1,7#0);2;-1;1]~()

/ it should not move the king into the range of the rook
/show 8 cut (1,5,(54#0),-1,7#0);
/ board:(1,(55#0),-1,-5,6#0)
/ show 8 cut board;

/ show "----------"
/ result: getMoves[board;0;1]
/ test["1 deep - should find >0 >0 >0";0 < value result;111b];

/ result: getMoves[board;1;1]
/ test["2 deep - should find 0 >0 0";0 < value result;010b];

/ result: getMoves[board;2;1]
/ test["3 deep - should find 0 >0 0";0 < value result;010b];

board:(1,0,(54#0),-5,-1,6#0)
show 8 cut board;
result: getMoves[board;3;1]
/ test["4 deep - should find 0 >0 0";0 < value result;010b];
/test["should find 0 >0 0";0 < value getMoves[board;2;1];010b];

show "----------"
show result
/ there should be only one move (the other two mean game over)
/ (count moves)~1
/ show moves
/moves 0
/moves[;`score]