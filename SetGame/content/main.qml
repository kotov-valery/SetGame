import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1

import "setgame.js" as SetGame

Window {
    id: root
    width: 450
    height: 550
    visible: true

    SystemPalette { id: activePalette }

    Image {
        id: background
        width: parent.width
        height: parent.height - 30
        anchors {
            top: parent.top
        }
        source: "qrc:/setgame/content/images/background.png"
        fillMode: Image.PreserveAspectCrop
   }

    GridView {
        id: playgroundView
        anchors.fill:background

        cellWidth: 90
        cellHeight: 140

        header: Item {
            height: 20
        }

        footer: Item {
            height: 20
        }

        model: ListModel {
            id: playgroundModel
        }

        delegate: Item {
            id: cardWrapper
            width: playgroundView.cellWidth
            height: playgroundView.cellHeight

            Card {
                type: cardType
                width: cardWrapper.width - 5
                height: cardWrapper.height - 15

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        SetGame.cardClicked(index)
                    }
                }
            }
        }
   }

    Rectangle {
          id: toolBar
          width: parent.width; height: 30
          color: activePalette.window
          anchors.bottom: root.bottom
          y: parent.height - 30

          Button {
              anchors { left: parent.left; verticalCenter: parent.verticalCenter }
              text: "New Game"
              onClicked: SetGame.startGame();
          }

          Text {
              id: score
              anchors { right: parent.right; verticalCenter: parent.verticalCenter }
              text: "Score: Who knows?"
          }
    }
}

