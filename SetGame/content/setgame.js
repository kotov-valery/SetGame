var maxCardsCount = 81
var cardsArray = null;
var maxCardsOnScreen = 12;
var cardsOnScreen = 0;
var maxColumns = 4;
var maxRows = 4; // 4 by default + 1 row for additional cards

function startGame() {
    if (cardsOnScreen > 0) {
        playgroundModel.clear();
        delete cardsArray;
    }

    // By now, just generate number, representing the type randomly
    // When all of the types will be available, there won't be any
    // need in random generation, but it will be needed shuffling
    // the array
    cardsArray = new Array(maxCardsCount);
    for (var i=0; i<maxCardsCount; i++) {
        cardsArray[i] = Math.floor(Math.random()*2) + 1; // [1,2]
    }

    populateCards();
}

function populateCards() {
    while((cardsOnScreen < maxCardsOnScreen) &&
          (cardsArray.length > 0)) {
        // Add card with appropriate type on the screen
        playgroundModel.append({
            "cardType" : cardsArray.pop()
        });
        cardsOnScreen++;
    }
}

function cardClicked(index) {
    playgroundModel.remove(index);
    cardsOnScreen--;
    populateCards();
}
