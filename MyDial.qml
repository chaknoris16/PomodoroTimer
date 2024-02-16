import QtQuick 6.5
import QtQuick.Controls 6.5

Rectangle {
    property alias dialText: dialTexts.text
    property color divStateOn: "#47a7da"
    property color divStateOff: "transparent"
    width: 270
    height: 270
    id: root
    color: "transparent"

    Repeater {
        id: rectangleRepeater
        model: 24

        Rectangle {
            id: rectangleItem
            width: 13
            height: 27
            color: "#47a7da"

            x: 130 + 103 * Math.cos((360 / 24) * index * (Math.PI / 180))
            y: 118 + 103 * Math.sin((360 / 24) * index * (Math.PI / 180))
            rotation: 90 + (15 * index)
            radius: 5

            function changeColor(divState) {
                rectangleItem.color = divState ? divStateOn : divStateOff
            }
        }
    }

    function setDivisionColor(divNumber, divState) {
        rectangleRepeater.itemAt(divNumber).changeColor(divState)
    }

    function resetDial() {
        for (var i = 0; i < rectangleRepeater.count; ++i) {
            rectangleRepeater.itemAt(i).changeColor(divStateOn);
        }
    }

    Image {
        id: img_dial
        x: 0
        y: 0
        width: 270
        height: 270
        source: "qrc:/Images.png/Dial.png"
        fillMode: Image.PreserveAspectFit
        Item {
            anchors.fill: parent
            width: 103
            height: 65
            x: 84
            y: 103

            Text {
                id: dialTexts
                objectName: "timeText"
                anchors.fill: parent
                font.pixelSize: 36
                font.family: "SF Pro Text"
                font.bold: true
                color: "#FFFFFF"

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: "25 min"
            }
        }

    }



    // DropShadow {
    //     anchors.fill: img_dial
    //     anchors.leftMargin: 0
    //     anchors.rightMargin: 0
    //     anchors.topMargin: 8
    //     anchors.bottomMargin: -8
    //     horizontalOffset: 5
    //     verticalOffset: 5
    //     radius: 5
    //     samples: 16
    //     color: "#80000000"
    // }
    StateGroup {
        id: stateGroup
    }
}
