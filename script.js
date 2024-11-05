
function getComputerChoice(items) {
    return items[Math.floor(Math.random() * items.length)];
    
}
const arrayValues = ['rock','paper','scissors'];


function getHumanChoice() {
    let choice = prompt('Enter your choice (Rock, Paper or Scissors): ');
    return choice;
}

