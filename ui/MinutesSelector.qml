import QtQuick 6.5
import QtQuick.Controls 6.5
import QtQuick.Layouts


Item {
    id: widget
    width: 167
    height: 94
    property int time: parseInt(inputField.text)
    property alias defTime: inputField.text
    property bool hover: false
    property int minMinsNum: 5
    property int maxMinsNum: 240
    Rectangle {
        id: widgetBackground
        width: widget.width
        height: widget.height
        radius: 5
        color: "#494f5f"

        Row {
            anchors.fill: parent

            TextInput {
                id: inputField
                width: widgetBackground.width * 0.715
                height: widgetBackground.height
                color: "#eaeaea"
                selectByMouse: true


                text: control.minutes
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                selectionColor: "#e32091c1"
                mouseSelectionMode: TextInput.SelectWords
                font.pixelSize: 35
                font.family: "SF Pro Text"
                font.bold: true
                onEditingFinished: control.setMinutes(parseInt(text))
                validator: IntValidator { bottom: minMinsNum; top: maxMinsNum }


                WheelHandler {
                    onWheel: {
                        wheelChangingHandler(event.angleDelta.y)
                    }

                    function wheelChangingHandler(delta) {
                        if (delta > 0) {
                            control.setMinutes(control.minutes + 1)
                        } else {
                            control.setMinutes(control.minutes - 1)
                        }
                    }
                }
            }

            Column {
                width: widget.width * 0.28
                height: widget.height
                Layout.fillHeight: true
                Layout.fillWidth: true
                Button {
                    id: buttonUp
                    width: widget.width * 0.28
                    height: widget.height / 2
                    icon.color: "#5a6b97"
                    hoverEnabled: true
                    property bool hover: false
                    //onClicked: control.increment()
                    Layout.fillHeight: true
                    Rectangle {
                        anchors.fill: parent
                        color: buttonUp.hover ? "#627197" : "#494f5f"
                        radius: 5
                        Image {
                            id: upButton
                            fillMode: Image.PreserveAspectFit
                            source: "qrc:/ui/Images.png/UpArrow.png"
                             anchors.centerIn: parent
                        }
                    }
                    onClicked: control.setMinutes(control.minutes + 1)
                    onHoveredChanged: buttonUp.hover = !buttonUp.hover
                }

                Button {
                    id: buttonDown
                    property bool hover: false
                    property color buttonColor: "#494f5f"
                    width: widget.width * 0.28
                    height: widget.height / 2
                    hoverEnabled: true
                    Layout.fillHeight: true

                    Rectangle {
                        anchors.fill: parent
                        color: buttonDown.hover ? "#627197" : "#494f5f"
                        radius: 5
                        Image {
                            anchors.centerIn: parent
                            id: downButton
                            source: "qrc:/ui/Images.png/DownArrow.png"
                        }
                    }
                    onHoveredChanged: buttonDown.hover = !buttonDown.hover
                    onClicked: control.setMinutes(control.minutes - 1)
                }
            }
        }
    }

}
