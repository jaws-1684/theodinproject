function gameBoard () {
  let board = new Array(9).fill(null);
  const update = function (pos, marker) {
  	board[pos] = marker
  };
  const reset = () => {
    board = new Array(9).fill(null)
  }
  const array = () => board;
  const full = () => !board.includes(null);
  const cellOccupied  = (i) => {
    return board[i] == null ? false : true;
  }
  return { array, update, reset, full, cellOccupied };
}

function Player (playerName, playerMarker) {
  const name = () => playerName;
  const marker = () => playerMarker;
  return { name, marker };
}
function createPlayer (playerName, playerMarker) {
  const { name, marker} = Player(playerName, playerMarker);
  const info = () => {
    return `${name()}: ${marker()}`
  }
  return { name, marker, info };
}

function gameController() {
	const combinations =  [[0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
      [0, 4, 8], [2, 4, 6]]; // Diagonals
  const markersAreNull = function (currentBoard, arrayOfPositions) {
  	for (i of arrayOfPositions) {
  		if (currentBoard[i] == null) return true
  	}
  	return false
  }     
  const win = function(board) {
    const currentBoard = board.array();
  	for (combo of combinations) {
  		const [i, j, k] = combo
  		if (markersAreNull(currentBoard,combo)) {
  			continue
  		}
  		if (currentBoard[i] === currentBoard[j] && currentBoard[j] === currentBoard[k]) {
  			return true
  		}
    }
    return false
  }
  const tie = function (board) {
    return board.full();
  }
  const switchPlayer = function (currentPlayer, player1, player2) {
  	return currentPlayer == player1 ? player2 : player1
  };
  return { win, switchPlayer, tie };                 
}



const DOMAction = (function (doc) {
  const addListener = function(element, funct, action="click") {
    select(element).addEventListener(action, funct);
  };
  const removeListener = function(element, funct, action="click") {
    select(element).removeEventListener(action, funct)
  };
  const select = function(attr) {
   return document.querySelector(attr)
  }
  const write = function (attr, text) {
    select(attr).textContent = text; 
  };
  const parseInput = function (element) {
    const inp = document.getElementById(element)
    if (inp.value == "") {
      write(".info", "Names are required!")
      throw Error("Names required")
    }
    return inp.value[0].toUpperCase() + inp.value.substring(1)
  }
  const clearInput = function () {
    const inp1 = document.getElementById("p1");
    const inp2 = document.getElementById("p2");
    inp1.value = "";
    inp2.value = "";
  }
  const hide = function (element) {
    select(element).classList.add("hidden")
  };
  const show = function (element) {
    select(element).classList.remove("hidden")
  };
  const clear = () => {
    const cells = document.querySelectorAll(".cell")
    cells.forEach((cell) => cell.textContent = "")
  }
  return {addListener, removeListener, write, parseInput, clearInput, clear, hide, show}
})(document);


function TicTacToe (name1, name2) {
  const player1 = createPlayer(name1, "X")
  const player2 = createPlayer(name2, "O")
  let currentPlayer = player1
  DOMAction.write('.player1', player1.info())
  DOMAction.write(".player2", player2.info())
 

  const board = gameBoard()
  const gameCtrl = gameController()

  const gameOverMessage = () => `Game Over. ${currentPlayer.name()}[${currentPlayer.marker()}] has won the Game!`;
  const clickHandler = function (event) {
    DOMAction.write(".message", `${currentPlayer.marker()} just moved!`)
    let target = event.target;

    if (target.classList.contains("cell")) {
        let i = target.getAttribute("data-attribute")
        
        if (board.cellOccupied(i)) {
          DOMAction.write(".message", "This cell is already occupied")
          return
        } else {
          board.update(Number(i), currentPlayer.marker())
          target.textContent = currentPlayer.marker()
        }
        if (gameCtrl.win(board)) { 
          DOMAction.write(".message", gameOverMessage())
          DOMAction.removeListener(".game-container", clickHandler)
          return 
        } else if (gameCtrl.tie(board)) {
           DOMAction.write(".message", "It's a tie")
           DOMAction.removeListener(".game-container", clickHandler)
         }
        currentPlayer = gameCtrl.switchPlayer(currentPlayer, player1, player2)
    }
  };
  const reset = () => {
    board.reset()
    currentPlayer = player1
    DOMAction.clear()
    DOMAction.write(".message", "Reset complete")
    DOMAction.addListener('.game-container', clickHandler)
  };
  const newGame = () => {
     board.reset()
     DOMAction.clear()
     DOMAction.clearInput()
     DOMAction.show(".header")
     DOMAction.hide(".main")
  }
  DOMAction.addListener(".new", newGame)
  DOMAction.addListener(".reset", reset)
  DOMAction.addListener('.game-container', clickHandler)
  
}

const Game = (function () {
  const start = () => {
    const name1 = DOMAction.parseInput("p1");
    const name2 = DOMAction.parseInput("p2");
    if (name1 && name2) {
      TicTacToe(name1, name2);
      DOMAction.hide(".header");
      DOMAction.show(".main");
    }
   
  };
 
  const flow = (startBtn) => {
    DOMAction.addListener(startBtn, start)
  }
  return {flow}
})();

// Driver code
Game.flow(".start")

