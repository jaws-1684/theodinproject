let humanScore = 0;
let computerScore = 0;
const para = document.querySelector('.result-box');
const score = document.querySelector('.score-box');
const h2 = document.querySelector('.container h2');

const link = document.createElement('link');
link.rel = 'stylesheet';
link.href = 'https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap';
document.head.appendChild(link);

const choices = ['rock', 'paper', 'scissors'];

function getComputerChoice() {
    return choices[Math.floor(Math.random() * choices.length)];
}

function updateScore() {
    score.textContent = `Human: ${humanScore} Computer: ${computerScore}`;
}

function displayWinner(winnerMessage) {
    h2.style.fontFamily = 'Press Start 2P';
    h2.style.color = 'blue';
    h2.textContent = winnerMessage;
}

function playRound(humanChoice, computerChoice) {
    if (humanChoice === computerChoice) {
        para.textContent = "It's a tie!";
    } else if (
        (humanChoice === 'paper' && computerChoice === 'rock') ||
        (humanChoice === 'rock' && computerChoice === 'scissors') ||
        (humanChoice === 'scissors' && computerChoice === 'paper')
    ) {
        para.textContent = `You won! ${humanChoice} beats ${computerChoice}!`;
        humanScore++;
    } else {
        para.textContent = `You lost. ${computerChoice} beats ${humanChoice}!`;
        computerScore++;
    }

    updateScore();

    if (humanScore === 5) {
        displayWinner("You won the game! Congratulations!");
        resetScores();
    } else if (computerScore === 5) {
        displayWinner("Computer wins the game! Better luck next time.");
        resetScores();
    }
}

function resetScores() {
    humanScore = 0;
    computerScore = 0;
}

document.querySelectorAll('.btn').forEach(button => {
    button.addEventListener('click', (event) => {
        const humanChoice = event.target.textContent.toLowerCase();
        const computerChoice = getComputerChoice();
        playRound(humanChoice, computerChoice);
    });
});
