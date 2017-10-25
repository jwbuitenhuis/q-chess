# q-chess

Simple chess engine in q.
A board is a vector of 64 integers.
White king = 1, black queen = -2, etc., empty is 0.
Algorithm is negamax with alpha pruning.
No castling/en-passant yet. 


```sh
cd q
q server.q -p 3002
```

To test all:

```sh
cd q
q test.spec.q
```

Run any *.spec.q for partial tests.
Start q with -s [n] to benefit from peach.