const container = document.querySelector('.container');

for (i = 1; i <= 16*16; i++) {
    const square = document.createElement('div');
    square.setAttribute('class', 'box'); 
    square.style.height = '20px';
    square.style.width = '20px'; 
    container.appendChild(square);
    console.log(i)
}

const box = document.querySelectorAll('.box');
box.forEach(box => {
    box.addEventListener('mouseenter', (event) => {
        event.target.style.backgroundColor = 'black';
    })
})
