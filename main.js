const container = document.querySelector('.container');
const resetButton = document.getElementById('btn');
const resizeButton = document.getElementById('resize-btn');
const totalWidth = 336; 


function createGrid(numSquaresPerSide) {
    
    while (container.firstChild) {
        container.removeChild(container.firstChild);
    }

    const squareSize = totalWidth / numSquaresPerSide; 

    for (let i = 0; i < numSquaresPerSide * numSquaresPerSide; i++) {
        const square = document.createElement('div');
        square.setAttribute('class', 'box');
        square.style.width = `${squareSize}px`;
        square.style.height = `${squareSize}px`;
        container.appendChild(square);
    }

    
    document.querySelectorAll('.box').forEach(box => {
        box.addEventListener('mouseenter', (event) => {
            event.target.style.backgroundColor = getRandomColor();
        });
    });
}


createGrid(16);


resetButton.addEventListener('click', () => {
   
    let numSquares = parseInt(prompt('Enter the number of squares per side (max 100):'), 10);

    
    if (isNaN(numSquares) || numSquares < 1 || numSquares > 100) {
        alert('Please enter a valid number between 1 and 100.');
        return;
    }

    
    createGrid(numSquares);
});


function getRandomColor() {
    var r = Math.floor(Math.random() * 256); // Random between 0-255
    var g = Math.floor(Math.random() * 256); // Random between 0-255
    var b = Math.floor(Math.random() * 256); // Random between 0-255
    return 'rgb(' + r + ',' + g + ',' + b + ')';
    }