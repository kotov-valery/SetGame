import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: card

    property int type: -1
    property bool clicked: false

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

        HueSaturation {
            id: hueSaturationEffect
            anchors.fill: cardContent
            source: cardContent
            lightness: -0.1
            opacity: clicked ? 1 : 0
        }

        GaussianBlur {
            anchors.fill: hueSaturationEffect
            source: hueSaturationEffect
            radius: 4
            samples: 16
            opacity: clicked ? 1 : 0
        }

    }
}



