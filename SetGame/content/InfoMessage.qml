import QtQuick 2.0

Rectangle {
    id: infoMessage
    opacity: 0
    visible: opacity === 1

    property string message: ""
    property string type: "info"

    radius: 8

    gradient: Gradient {
        GradientStop {
            position: 0.0
            color: "white"
        }
        GradientStop {
            position: 1.0;
            color: {
                if (type == "info")
                    return "gray";
                else
                    return "red";
            }
        }
    }

    border.color: "black"
    border.width: 5

    width: 250
    height: 250

    anchors {
        centerIn: parent
    }

    function open(newType, newMessage) {
        type = newType
        message = newMessage;
        opacity = 1;
    }

    function close() {
        opacity = 0;
    }

    Text {
        anchors {
            left: parent.left
            right: parent.right
            verticalCenter: parent.verticalCenter
            leftMargin: 20
            rightMargin: 20
            topMargin: 20
            bottomMargin: 20
        }

        wrapMode: Text.WordWrap
        text: message;
    }

    MouseArea {
        anchors.fill: parent
        onClicked: { parent.opacity = 0 }
    }

    Behavior on opacity { NumberAnimation{ duration: 200 } }

    Timer {
        id: showTimeout
        interval: 4000
        running: false
        repeat:  false
        onTriggered: { parent.opacity = 0 }
    }

    onOpacityChanged: {
        if(opacity == 1)
            showTimeout.restart();
        else if(opacity == 0)
            showTimeout.stop();
    }

    states: [
        State {
            name: "Visible"; when: opacity == 1
        },
        State {
            name: "Invisible"; when: opacity == 0
        }
    ]
}
