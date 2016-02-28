import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: card

    property string figuresType: ""
    property string figuresCount: ""
    property string figuresColor: ""
    property string figuresFilling: ""

    property bool clicked: false
    property bool hintHighlight: false


    Component.onCompleted: {
        cardContent.source = compileSourceName();
    }

    function compileSourceName() {
        // Compose source name out of the properties:
        // card-<type>-<count>-<color>-<filling>.svg
        return "qrc:/setgame/content/images/card-" + figuresType + "-" + figuresCount + "-" + figuresColor + "-" + figuresFilling + ".svg.png";
        // TODO: Use png so far. Qt SVG does not support "Stripes" element
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

//        GaussianBlur {
//            id: gaussianBlurEffect
//            anchors.fill: hueSaturationEffect
//            source: hueSaturationEffect
//            radius: 4
//            samples: 16
//            opacity: 0
//        }

        Colorize {
            id: colorizeEffect // for hint
            anchors.fill: cardContent
            source: cardContent
            hue: 0.15
            saturation: 1
            lightness: -0.08
            opacity: 0
        }
    }

    // TODO: There is a really wierd glich. From time to time when you click on a card you see blurred (and shaded)
    // image of a card with another type. States didn't helped...
    states: [
        State { name: "Unselsected"; when: clicked == false && hintHighlight == false
//            PropertyChanges { target: gaussianBlurEffect; opacity: 0 }
            PropertyChanges { target: hueSaturationEffect; opacity: 0 }
        },
        State { name: "Selected"; when: clicked == true && hintHighlight == false
            PropertyChanges { target: hueSaturationEffect; opacity: 1 }
//            PropertyChanges { target: gaussianBlurEffect; opacity: 1 }
        },
        State { name: "Highlighted"; when: hintHighlight == true && clicked == false
            PropertyChanges { target: colorizeEffect; opacity: 1 }
        },
        State { name: "Unhighlighted"; when: hintHighlight == false && clicked == false
            PropertyChanges { target: colorizeEffect; opacity: 0 }
        }
    ]
}



