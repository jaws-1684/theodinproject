const displayResult = document.querySelector('.result');
displayResult.addEventListener('dragstart', (event) => event.preventDefault());
const operators = document.querySelectorAll('.btn.operand');
const nums = document.querySelectorAll('.btn.num');
const decimal = document.querySelector('#decimal');

let firstNumber = '';
let secondNumber = '';
let operator = '';
let total = ''; 
 
function runCalculator() {
    populateDisplay()
    keyboardSupport()
    signToggle();
    deleteLastChar()
    calculate()
    clearResultBox()
    preventSelect()
}

runCalculator()


function add (a ,b) {
    return a+b;
};

function subtract (a, b) {
    return a-b;
};

function multiply (a, b) {
    return a*b;
};

function divide(a, b) {
    if (b === 0) {
        return "404";
    }
    return a / b;
};

function remainder(a, b) {
    if (b === 0) {
        return "404";
    }
    return a % b;
};



function operate (operator, firstNumber, secondNumber) {
    switch (operator) {
        case '+': return add(firstNumber, secondNumber);
        case '-': return subtract(firstNumber, secondNumber);
        case '×': return multiply(firstNumber, secondNumber);
        case '÷': return divide(firstNumber, secondNumber);
        case '%': return remainder(firstNumber, secondNumber);
        default: return null; 
    };

};



function populateDisplay() {

        nums.forEach(clickNumber)
        operators.forEach(clickOperator)

        decimal.addEventListener('click', () => {
          
            if (operator === '') {
                if (!firstNumber.includes('.')) {
                    firstNumber += '.';
                    displayResult.textContent = firstNumber;
                }
            } else {
                if (!secondNumber.includes('.')) {
                    secondNumber += '.';
                    displayResult.textContent = secondNumber;
                }
            }
        });
}





function signToggle() {
    const sign = document.querySelector('#sign-toggle');
    sign.addEventListener('click', () => {
        let currentValue = Number(displayResult.textContent);
        displayResult.textContent = currentValue * -1;
    });
}



function calculate() {
    const equal = document.querySelector("#equal");
    equal.addEventListener('click', () => {
        if (firstNumber !== '' && secondNumber !== '' && operator !== '') {
            const num1 = Number(firstNumber);
            const num2 = Number(secondNumber);

            total = operate(operator, num1, num2);

            displayResult.textContent = total;

            firstNumber = operResult;

            secondNumber = '';
            operator = '';
            total = '';
        } else {
            console.log('404');
        }
    });
}



function clearResultBox () {
    const clear = document.querySelector('#clear');
    clear.addEventListener('click', () => {
            displayResult.textContent = '0'
            firstNumber = '';
            secondNumber = '';
            total = '';
            operator = '';
        
    });
    
};



function deleteLastChar () {
        const backspaceButton = document.querySelector('#backspace');
        backspaceButton.addEventListener('dragstart', (event) => event.preventDefault());
        backspaceButton.addEventListener('selectstart', (event) => event.preventDefault());
        
        backspaceButton.addEventListener('click', () => {
                if (operator === '') {
                firstNumber = firstNumber.slice(0, -1);
                displayResult.textContent = firstNumber || '0';
            } else {
                secondNumber = secondNumber.slice(0, -1);
                displayResult.textContent = secondNumber || '0';
            }
        });
    }



function preventSelect () {
    const container = document.querySelectorAll('.screen');
    container.forEach(() => {
        container.addEventListener('dragstart', (event) => event.preventDefault());
        container.addEventListener('selectstart', (event) => event.preventDefault());
    })
}



function keyboardSupport() {
    window.addEventListener('keydown', function(event) {
        let targetKey = event.key;
        let nums = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
        let oper = ['+', '/', '-', '*', '%']

        switch(targetKey) {
            case 'Enter': 
                const equalButton = document.querySelector('#equal');
                equalButton.click();
                equalButton.focus();
                break;
            case '.': 
                const decimalButton = document.querySelector('#decimal');
                decimalButton.click();
                decimalButton.focus();
                break;
            case 'Escape': 
                const clearButton = document.querySelector('#clear');
                clearButton.click();
                clearButton.focus();
                break;
            case 'Backspace':
                    let backSpace = document.querySelector('#backspace');
                    backSpace.style.color = 'red';
                    backSpace.click();
                    setTimeout(() => {
                        backSpace.style.color = '';
                    }, 300);
                    
                    break;
                
                
        }

        
            if(nums.includes(targetKey)) {
               let keyNums = document.getElementById(targetKey);
               keyNums.click();
               keyNums.focus();
            } else if (oper.includes(targetKey)) {
                let keyOper = document.getElementById(targetKey)
                keyOper.click();
                keyOper.focus();
            }
        event.preventDefault();  
    });
};

// helpers
function clickNumber(num) {
     num.addEventListener('click', (event) => {
            const content = event.target.textContent;
            
            if (operator === '') {
                firstNumber += content;
                return displayResult.textContent = firstNumber;
            } else {
                secondNumber += content;
                return displayResult.textContent = secondNumber;
            }
        });
}

function clickOperator (oper) {
     oper.addEventListener('click', (event) => {
            const content = event.target.textContent;
            

            if (firstNumber && secondNumber && operator) {
                let operResult = operate(operator, Number(firstNumber), Number(secondNumber))
                displayResult.textContent = operResult;
                firstNumber = operResult
                secondNumber = ''
                operator = ''
                
            } else if (firstNumber) {
                operator = content;
            }


            
        });
}