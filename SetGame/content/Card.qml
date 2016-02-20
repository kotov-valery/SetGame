import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: card

    property int type: -1
    property bool clicked: false

    Component.onCompleted: {
        if (type == 1) {
            cardContent.source = "qrc:/setgame/content/images/card-oval-1-red-filled.svg"
        } else if (type == 2) {
            cardContent.source = "qrc:/setgame/content/images/card-rect-1-green-filled.svg"
        } else if (type == 3) {
            cardContent.source = "qrc:/setgame/content/images/card-curly-1-purple-filled.svg"
        }
    }

    Image {
        id: cardContent
        anchors.fill: parent

        HueSaturation {
            id: hueSaturationEffect
            anchors.fill: cardContent
            source: cardContent
            lightness: -0.1
            opacity: 0
        }

        GaussianBlur {
            id: gaussianBlurEffect
            anchors.fill: hueSaturationEffect
            source: hueSaturationEffect
            radius: 4
            samples: 16
            opacity: 0
        }
    }

    // TODO: There is a really wierd glich. From time to time when you click on a card you see blurred (and shaded)
    // image of a card with another type. States didn't helped...
    states: [
        State { name: "Unselsected"; when: clicked == false
            PropertyChanges { target: gaussianBlurEffect; opacity: 0 }
            PropertyChanges { target: hueSaturationEffect; opacity: 0 }
        },
        State { name: "Selected"; when: clicked == true
            PropertyChanges { target: hueSaturationEffect; opacity: 1 }
            PropertyChanges { target: gaussianBlurEffect; opacity: 1 }
        }
    ]
}



