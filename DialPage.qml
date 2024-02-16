import QtQuick 6.5
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts
import DialController 1.0
Rectangle {
    id: root
    property alias backgroundColor: root.color
    property alias minutes: dial.dialText
    property alias controller: dialCntroller
    signal resetButtonClicked()
    implicitHeight: 389
    implicitWidth: 473
    Layout.fillWidth: true
    Layout.fillHeight: true
    color: backgroundColor  //"#313236"
    radius: 7

    ColumnLayout {
        id: dialColumn
        anchors.fill: parent
        Layout.alignment: Qt.AlignHCenter
        MyDial {
            id: dial
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 30
            dialText: controller.minutes.toString() + " mins"

        }
        RowLayout {
            id: buttonRow
            Layout.alignment: Qt.AlignHCenter

            Button {
                id: buttonPause
                visible: false
                width: buttonPauseImg.sourceSize.width
                height: buttonPauseImg.sourceSize.heigh


                background: Image {
                    id: buttonPauseImg
                    fillMode: Image.PreserveAspectFit

                    Layout.minimumHeight: sourceSize.height
                    Layout.minimumWidth: sourceSize.width
                    source: "qrc:/Images.png/PauseButton.png"
                }
                onClicked: {
                    //stack.currentIndex = stack.currentIndex ? 0:1

                }
            }
            Button {
                id: buttonStop
                background: Image {
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    Layout.maximumHeight: sourceSize.height
                    Layout.maximumWidth: sourceSize.width
                    source: "qrc:/Images.png/StopButton.png"
                }
                onClicked: {
                    console.log("buttonStop is pressed")
                    buttonStop.visible = !buttonStop.visible
                    buttonPause.visible = !buttonPause.visible
                    buttonReset.visible = !buttonReset.visible
                }
            }

            Button {
                id: buttonReset
                visible: false

                background: Image {
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    Layout.maximumHeight: sourceSize.height
                    Layout.maximumWidth: sourceSize.width
                    source: "qrc:/Images.png/ResetButton.png"
                }
                onClicked: {
                    root.returnToSelector()
                }
            }
        }

        DialController {
            id: dialCntroller
            onDivisionsColorChanged: {
                dial.setDivisionColor(divNumber, divState)
            }
            onDialTimerTimeout: root.returnToSelector()
        }
    }
    function returnToSelector() {
        buttonStop.visible = true
        buttonPause.visible = false
        buttonReset.visible = false
        resetButtonClicked()
        dial.resetDial()
    }
}

