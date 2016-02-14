import QtQuick 2.0

Item {
    id: card

    property int type: -1

    Component.onCompleted: {
        if (type == 1) {
            cardContent.source = "qrc:/setgame/content/images/simple-card-type-1.png"
        } else if (type == 2) {
            cardContent.source = "qrc:/setgame/content/images/simple-card-type-2.png"
        }
    }

    Image {
        id: cardContent
        anchors.fill: parent
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            console.log("Card with type " + type + " was clicked");
        }
    }
}


