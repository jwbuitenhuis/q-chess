function convert(position, piece) {
    const [col, row] = position.split("");
    const index = ((parseInt(row, 10) - 1) * 8) +
        "hgfedcba".indexOf(col);

    const [color, type] = piece.split("");
    const factor = color === 'w' ? 1 : -1;
    const kind = factor * " KQBNRP".indexOf(type);
    return {index, kind};
}

function indexToFEN(indexes) {
    return indexes.map(index =>
        "hgfedcba"[index%8] + (1 +Math.floor(index/8))
    ).join("-");
}

function logBoard(board) {
    for(var i = 0;i<8;i++) {
        console.log(board.slice(i * 8, i * 8 + 8).join("  "));
    }
}

const emptyBoard = _ => Array(64).fill(0);

let isChangeBlack = false;
function handleChange(old, positions) {
    console.log("change", arguments);
    const board = emptyBoard();

    Object
      .keys(positions)
      .map(key => convert(key, positions[key]))
      .forEach(piece => {
        board[piece.index] = piece.kind;
      })

    logBoard(board);

    if(isChangeBlack) {
      console.log(JSON.stringify(board));
        sendBoard(board);
        isChangeBlack = false;
    }
}

const board1 = ChessBoard('board1', {
    orientation: 'black',
    draggable: true,
    dropOffBoard: 'trash',
    onDrop: _ => isChangeBlack = true,
    onChange: handleChange
});

const ws = new WebSocket("ws://localhost:5042/");
ws.binaryType="arraybuffer";
// const boarda = [5,4,3,1,2,3,4,5,6,6,6,6,6,6,6,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-6,0,0,0,0,0,0,0,0,0,0,0,-6,-6,-6,-6,0,-6,-6,-6,-5,-4,-3,-1,-2,-3,-4,-5]
// const boarda = [5,0,5,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-5,0,0,0,0,0,0]
ws.onopen = () => {
    board1.start();
    // sendBoard(boarda)
};

// ws.onmessage = e => {
//   const data = deserialize(e.data);
//   const fen = indexToFEN(data);
//   const move = "Server says: " + data + " " + fen;
//   announce(move);
//   board1.move(fen);
// };

function handleResponse(data) {
  const bestMove = data.sort((a,b) => b.score - a.score)[0];

  // const data = deserialize(data);
  const fen = indexToFEN([bestMove.from, bestMove.to]);
  const move = "Server says: " + data + " " + fen;
  announce(move);
  board1.move(fen);  
}
ws.onerror = e => console.error(e);

function announce(message) {
    console.log(message);
    document.getElementById("status").innerHTML = message;
}

function sendBoard(board) {
    announce("Sent board to server...");
    $.post('http://localhost:5042/counter', JSON.stringify(board))
      .then(handleResponse);
}