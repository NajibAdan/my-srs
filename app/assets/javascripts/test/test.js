let cardsToStudy = ["a","b","c","d","e","f"];

function start() {
    front = document.querySelector('#front');
    frontDiv = document.createElement('div');
    content = document.createElement('p');
    content.textContent = cardsToStudy.shift();
    frontDiv.appendChild(content);
    front.appendChild(frontDiv)
}

function back(){
    start()
}
const buttons = document.querySelectorAll('button');

buttons.forEach((button) => {
    button.addEventListener('click', (e)=> {
        if (button.getAttribute('id')=='start'){
            start()
            console.log('test')
        }
    });
});