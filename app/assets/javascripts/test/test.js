let cardsToStudy = {
    'cards':[
        {'front':'test','back':'test'},
        {'front':'test1','back':'test1'},
        {'front':'test2','back':'test2'},
    ]
};

function start() {
    hide = document.querySelector('#start');
    hide.style.visibility = 'hidden';
    front = document.querySelector('#front');

    back = document.querySelector('#back');
    var card = cardsToStudy.cards.shift();

    frontDiv = document.createElement('div');
    frontDiv.setAttribute('id','frontContent');
    content = document.createElement('p');
    content.textContent = card.front;

    backdiv = document.createElement('div');
    backdiv.setAttribute('id','backContent');
    backcontent = document.createElement('p');
    backcontent.textContent = card.back;
    backdiv.appendChild(backcontent);
    back.insertBefore(backdiv,back.childNodes[0]);

    frontDiv.appendChild(content);
    front.appendChild(frontDiv)
}

function answer(){
    back = document.querySelector('#back');
    back.style.visibility = 'visible';
    document.querySelector('#answer').style.visibility = 'hidden';
}

function next(){
    //if the queue is not empty?
    //get the front and back cards and set them to nil 
    //and set the new cards
    //else
    //inform the user
    if (cardsToStudy.cards == 0){
        alert('ALL the cards are over');
    }
    else {
        let card = cardsToStudy.cards.shift();
        const frontContent = document.querySelector('#frontContent');
        frontContent.lastChild.textContent = card.front;
        const backContent = document.querySelector('#backContent');
        backContent.lastChild.textContent = card.back;
        document.querySelector("#back").style.visibility = 'hidden';
        document.querySelector('#answer').style.visibility = 'visible';
    }
}
const buttons = document.querySelectorAll('button');
back = document.querySelector('#back');
back.style.visibility = 'hidden';
buttons.forEach((button) => {
    button.addEventListener('click', (e)=> {
        if (button.getAttribute('id')=='start'){
            start()
            console.log('test')
        }
        else if (button.getAttribute('id')=='answer'){
            answer();
        }
        else {
            next();
        }
    });
});