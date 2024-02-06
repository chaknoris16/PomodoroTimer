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

                //onHoverChanged: widget.hover = !widget.hover
                text: defTime
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                selectionColor: "#e32091c1"
                mouseSelectionMode: TextInput.SelectWords
                font.pixelSize: 35
                font.family: "SF Pro Text"
                font.bold: true

                validator: IntValidator { bottom: 5; top: 250 }

                onTextChanged: control.setMinutes(parseInt(text))
                onEditingFinished: control.setMinutes(parseInt(text))

                MouseArea {
                    anchors.fill: parent
                    propagateComposedEvents: true
                    onWheel: {
                        if (wheel.angleDelta.y > 0) {

                            inputField.text = (parseInt(inputField.text) + 1).toString();
                        } else {

                            inputField.text = (parseInt(inputField.text) - 1).toString();
                        }
                    }
                }

            }

            Column {
                anchors.right: parent.right
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
                            source: "Images/UpArrow.svg"
                            anchors.fill: parent
                        }
                    }
                    onClicked: inputField.text = (parseInt(inputField.text) + 1).toString()
                    onHoveredChanged: buttonUp.hover = !buttonUp.hover
                }

                Button {
                    id: buttonDown
                    width: widget.width * 0.28
                    height: widget.height / 2
                    hoverEnabled: true
                    Layout.fillHeight: true
                    property bool hover: false
                    property color buttonColor: "#494f5f"
                    Rectangle {
                        anchors.fill: parent
                        color: buttonDown.hover ? "#627197" : "#494f5f"
                        radius: 5
                        Image {
                            anchors.fill: parent
                            id: downButton
                            source: "Images/DownArrow.svg"
                        }
                    }
                    onHoveredChanged: buttonDown.hover = !buttonDown.hover
                    onClicked: inputField.text = (parseInt(inputField.text) - 1).toString()
                }
            }
        }

    }
}
