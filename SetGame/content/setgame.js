var cardsArray = null;
var cardsOnScreen = 0;

var maxSetSize = 3;
var currentSetSize = 0;
var chosenSetCards = new Array(maxSetSize);

var maxRows = 4; // 4 by default + 1 row for additional cards
var maxColumns = 4;
var maxCardsOnScreen = 12; // not quite true... with additional cards there might be 15 cards. but I'll think about it later
var maxCardsCount = 81

function startGame() {
    if (cardsOnScreen > 0) {
        playgroundModel.clear();
        delete cardsArray;
        cardsOnScreen = 0;
    }

    // By now, just generate number, representing the type randomly
    // When all of the types will be available, there won't be any
    // need in random generation, but it will be needed shuffling
    // the array
    cardsArray = new Array(maxCardsCount);
    for (var i=0; i<maxCardsCount; i++) {
        cardsArray[i] = Math.floor(Math.random()*3) + 1; // [1,3]
    }

    populateCards();
}

function populateCards() {
    while((cardsOnScreen < maxCardsOnScreen) &&
          (cardsArray.length > 0)) {
        // Add card with appropriate type on the screen
        var cardType = cardsArray.pop() - 1;
        playgroundModel.append({
            "cardClicked" : false,
            "cardType": cardType,
            "cardCount": 1,
            "cardColor": cardType,
            "cardFilling": 2 // filled
        });
        cardsOnScreen++;
    }
}

function cardClicked(index) {
    var selected = playgroundModel.get(index).cardClicked;
    playgroundModel.get(index).cardClicked = !selected;

    if (selected) {
        // undo changes
        console.assert(currentSetSize > 0)
        chosenSetCards[currentSetSize] = -1;
        currentSetSize--;
    } else {
        chosenSetCards[currentSetSize] = index;
        currentSetSize++;

        // check for set if 3rd card was clicked
        if (currentSetSize == maxSetSize) {
            var isSet = true;
            var cardType = playgroundModel.get(index).cardType;

            for(var i=0; i < chosenSetCards.length; i++) {
                console.assert(chosenSetCards[i] !== -1);
                if(playgroundModel.get(chosenSetCards[i]).cardType !== cardType) {
                    isSet = false;
                }
            }

            if(isSet) {
                console.log("It is a set");
                // Sort indexes in a reverse order. Thus, remove from the model is safe
                chosenSetCards = chosenSetCards.sort(function (a, b) {
                    return b-a;
                });

                for(i=0; i<chosenSetCards.length; i++) {
                    var index = chosenSetCards[i];
                    playgroundModel.get(index).cardClicked = false;
                    playgroundModel.remove(index);
                }

                cardsOnScreen = cardsOnScreen - 3;
                populateCards();
            } else {
                console.log("It is not a set");
                // Reset set state
                for(i=0; i< cardsOnScreen; i++) {
                    if(playgroundModel.get(i).cardClicked) {
                        playgroundModel.get(i).cardClicked = false;
                    }
                }
           }

            for(i=0; i < chosenSetCards.length; i++) {
                chosenSetCards[i] = -1;
            }
            currentSetSize = 0;
        }
    }

}

function checkDelete(index) {
    var card = playgroundModel.get(index);
    if ( card && card.cardClicked ) {
        playgroundModel.remove(index);
        cardsOnScreen--;
        return true;
    }
    return false;
}
