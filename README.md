# q-chess

Simple chess engine in q.
A board is an array 64 integers.
White king = 1, black queen = -2, etc., empty is 0.
Algorithm is negamax with alpha pruning.
No castling/en-passant yet. 

```sh
q q/server.q
cd html
live-server
```

To test all:

```sh
cd q
q test.spec.q
```

Run any *.spec.q for partial tests.