import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: card

    //Oh... I miss C++ enums soooo much! =(
    property var availableTypes: [
        "oval", // 0
        "rect", // 1
        "curly" // 2
    ]

    property var availableColors: [
        "red",      // 0
        "green",    // 1
        "purple"    // 2
    ]

    property var availableFilling: [
        "empty",   // 0
        "stripes", // 1
        "filled"   // 2
    ]

    property int figuresType: -1
    property int figuresCount: -1
    property int figuresColor: -1
    property int figuresFilling: -1

    property bool clicked: false

    Component.onCompleted: {
        cardContent.source = compileSourceName();
    }

    function compileSourceName() {
        console.assert(figuresType >= 0 && figuresCount > 0 && figuresColor >= 0 && figuresFilling >= 0);
        // Compose source name out of the properties:
        // card-<type>-<count>-<color>-<filling>.svg
        return "qrc:/setgame/content/images/card-" + availableTypes[figuresType] + "-" + figuresCount + "-" + availableColors[figuresColor] + "-" + availableFilling[figuresFilling] + ".svg";
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



