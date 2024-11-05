let humanScore = 0;
let computerScore = 0;

function getComputerChoice() {
    const items = ['rock','paper','scissors'];
    return items[Math.floor(Math.random() * items.length)].toLowerCase();
    
}

function getHumanChoice() {
    let choice = prompt('Enter your choice (Rock, Paper or Scissors): ');
    return choice.toLowerCase();
}


function playRound(humanChoice, computerChoice) {
  
    if (humanChoice === computerChoice) {
        console.log("It's a tie");
    }
    else if (
        (humanChoice === 'paper' && computerChoice === 'rock') ||
        (humanChoice === 'rock' && computerChoice === 'scissors') ||
        (humanChoice === 'scissors' && computerChoice === 'paper')
    ) {
        console.log(`You won! ${humanChoice} beats ${computerChoice}`);
        humanScore += 1;
    } 
 
    
    else {
        console.log(`You've lost. ${computerChoice} beats ${humanChoice}`);
        computerScore += 1;
    } 
}




const humanSelection = getHumanChoice();
const computerSelection = getComputerChoice();
playRound(humanSelection, computerSelection)

