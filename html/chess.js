(function(){
'use strict';

const FEN = " KQBNRP";

// h2 => 8
const FEN2index = ([row, col]) =>
    "hgfedcba".indexOf(row) + 8 * (parseInt(col, 10) - 1);

const index2FEN = i => "hgfedcba"[i % 8] + (1 + Math.floor(i / 8));

function convert([position, piece]) {
    const index = FEN2index(position);

    const [color, type] = piece.split("");
    const factor = color === 'w' ? 1 : -1;
    const kind = factor * FEN.indexOf(type);
    return {index, kind};
}

const q2FEN = n => (n > 0 ? 'w' : 'b') + FEN[Math.abs(n)];
const indexesToFEN = list => list.map(index2FEN).join("-");

const entries = o => Object.keys(o).map(d => [d, o[d]]);
const repeat = (n, x) => Array(n).fill(x);

const addPiece = (board, piece) => (board[piece.index] = piece.kind, board);
const getBoard = positions => entries(positions)
    .map(convert)
    .reduce(addPiece, repeat(64, 0));

let isChangeBlack = false;
function handleChange(_, positions) {
    if(isChangeBlack) {
        const board = getBoard(positions);
        sendBoard(board);
        isChangeBlack = false;
    }
}

// const raze = list => [].concat.apply([], list);
// const take = (n, d) => Array(n).fill(d);
// const boarda = [5,4,3,1,2,3,4,5,6,6,6,6,6,6,6,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-6,0,0,0,0,0,0,0,0,0,0,0,-6,-6,-6,-6,0,-6,-6,-6,-5,-4,-3,-1,-2,-3,-4,-5]
// const boarda = [5,0,5,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-5,0,0,0,0,0,0]

// const boarda = raze([take(9,0),1,take(7,0),-6,take(45,0),-1]);

// function generatePosition(board) {
//     return board.reduce((acc, val, index) =>
//         val ? Object.assign(acc, {[indexToFEN(index)]: q2FEN(val)}) : acc, {});
// }
// const minimal = generatePosition(boarda);

function handleDrop(from, to) {
    const move = FEN2index(from) + "-" + FEN2index(to);
    isChangeBlack = true;
    const found = allowedMoves
        .map(d => d.join("-"))
        .find(d => d === move);

    return !found && 'snapback';
}

let allowedMoves;
let currentBoard;
function getMoves() {
    const board = getBoard(board1.position());
    currentBoard = JSON.stringify(board);
    console.log("board:", currentBoard)
    return $.post('legalMoves', currentBoard)
        .then(d => allowedMoves = d);
}

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
    document.getElementById("status").innerHTML = message;
}

function sendBoard(board) {
    announce("Sent board to server...");
    const data = JSON.stringify(board);
    console.log("board:", data)
    return $.post('counter', data)
        .then(handleResponse)
        .then(getMoves);
}

const board1 = ChessBoard('board1', {
    orientation: 'black',
    draggable: true,
    // position: generatePosition(boarda),
    dropOffBoard: 'trash',
    showNotation: false,
    onDrop: handleDrop,
    onChange: handleChange
});

board1.start();
sendBoard(getBoard(board1.position()));

}());