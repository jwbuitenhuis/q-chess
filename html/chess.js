const FEN = " KQBNRP";
function convert(position, piece) {
    const [col, row] = position.split("");
    const index = ((parseInt(row, 10) - 1) * 8) +
        "hgfedcba".indexOf(col);

    const [color, type] = piece.split("");
    const factor = color === 'w' ? 1 : -1;
    const kind = factor * FEN.indexOf(type);
    return {index, kind};
}

const q2FEN = n => (n > 0 ? 'w' : 'b') + FEN[Math.abs(n)];
const indexToFEN = i => "hgfedcba"[i % 8] + (1 + Math.floor(i / 8));
const indexesToFEN = list => list.map(indexToFEN).join("-");

function logBoard(board) {
    for(var i = 0;i<8;i++) {
        console.log(board.slice(i * 8, i * 8 + 8).join("  "));
    }
}

const emptyBoard = _ => Array(64).fill(0);

let isChangeBlack = false;
function handleChange(old, positions) {
    const board = emptyBoard();

    Object
      .keys(positions)
      .map(key => convert(key, positions[key]))
      .forEach(piece => {
        board[piece.index] = piece.kind;
      })

    // logBoard(board);

    if(isChangeBlack) {
      // console.log(JSON.stringify(board));
        sendBoard(board);
        isChangeBlack = false;
    }
}

// const boarda = [5,4,3,1,2,3,4,5,6,6,6,6,6,6,6,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-6,0,0,0,0,0,0,0,0,0,0,0,-6,-6,-6,-6,0,-6,-6,-6,-5,-4,-3,-1,-2,-3,-4,-5]
// const boarda = [5,0,5,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-5,0,0,0,0,0,0]

const take = (n,d)=>Array(n).fill(d);
const raze = list => [].concat.apply([], list);
const boarda = raze([take(9,0),1,take(7,0),-6,take(45,0),-1]);

function generatePosition(board) {
    return board.reduce((acc, val, index) =>
        val ? Object.assign(acc, {[indexToFEN(index)]: q2FEN(val)}) : acc, {});
}
const minimal = generatePosition(boarda);
// console.log(JSON.stringify(minimal));

const board1 = ChessBoard('board1', {
    orientation: 'black',
    draggable: true,
    // position: generatePosition(boarda),
    dropOffBoard: 'trash',
    onDrop: _ => isChangeBlack = true,
    onChange: handleChange
});
board1.start();

// sendBoard(boarda);

function handleResponse(data) {
  const moves = data.sort((a,b) => b.score - a.score);
  console.log("------------ response -----------");
  moves.map(d => console.log(d.move.join("-") + ": " + d.score));

  const fen = indexesToFEN(moves[0].move);
  const move = "Server says: " + fen;
  announce(move);
  board1.move(fen);  
}

function announce(message) {
    // console.log(message);
    document.getElementById("status").innerHTML = message;
}

function sendBoard(board) {
    announce("Sent board to server...");
    const data = JSON.stringify(board);
    console.log("board:", data)
    $.post('http://localhost:5042/counter', data)
      .then(handleResponse);
}