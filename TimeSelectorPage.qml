import QtQuick 6.5
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts
import TimeSelectorController 1.0

Rectangle {
    id: root
    property alias backgroundColor: root.color
    property string minutes: minSelector.time
    signal startTimer(time: int)
    implicitHeight: 284
    implicitWidth: 473
    Layout.fillWidth: true
    Layout.fillHeight: true
    color: backgroundColor
    radius: 7

    ColumnLayout {
        id: slectorColum
        anchors.fill: parent
        spacing: 30
        Layout.alignment: Qt.AlignHCenter
        MinutesSelector {
            id: minSelector
            defTime: control.minutes
            Layout.alignment: Qt.AlignHCenter
        }
        Button {
            id: buttonStart
            width: buttonStartImg.sourceSize.width
            height: buttonStartImg.sourceSize.heigh
            Layout.alignment: Qt.AlignHCenter
            background: Image {
                id: buttonStartImg
                fillMode: Image.PreserveAspectFit

                source: "qrc:/Images.png/StartButton.png"
            }

            onClicked: {
                control.buttonStartClicked(minSelector.time)
                startTimer(minSelector.time)
                console.log("'Button Start' is Presset!")
            }
        }
    }
    TimeSelector {
        id: control

    }
}

