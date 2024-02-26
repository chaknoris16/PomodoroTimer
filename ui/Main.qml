import QtQuick 6.5
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Basic

Window {
    id: root
    width: 840
    height: 720
    visible: true
    color: "#232732"
    title: "TestTimer"


    RowLayout {
        anchors.fill: parent

        Rectangle {
            id: tasksBar
            width: root.width / 3
            Layout.fillHeight: true
            visible: width >= 150
            color: "#202020"
        }

        ColumnLayout {
            id: leftSection
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 10


            StackView {
                id: stackView
                Layout.maximumWidth: leftSection.width
                Layout.minimumHeight: 213
                Layout.fillHeight: true
                Layout.fillWidth: true
                initialItem: timerSelector
                Layout.leftMargin: 30
                Layout.rightMargin: 30
                Layout.topMargin: 30

                pushEnter: Transition {
                        PropertyAnimation {
                            property: "opacity"
                            from: 0
                            to:1
                            duration: 300
                        }
                    }
                    pushExit: Transition {
                        PropertyAnimation {
                            property: "opacity"
                            from: 1
                            to:0
                            duration: 300
                        }
                    }
                    popEnter: Transition {
                        PropertyAnimation {
                            property: "opacity"
                            from: 0
                            to:1
                            duration: 300
                        }
                    }
                    popExit: Transition {
                        PropertyAnimation {
                            property: "opacity"
                            from: 1
                            to:0
                            duration: 300
                        }
                    }
            }

            TimeSelectorPage {
                id: timerSelector
                backgroundColor: "#313236"
                onStartTimer: {
                    dial.controller.startDial(minutes)
                    stackView.push(dial)
                }

            }

            DialPage {
                id: dial
                visible: false
                backgroundColor: "#313236"
                onResetButtonClicked: stackView.pop(timerSelector)
            }



            Rectangle {
                id: historyBlock
                color: "#313236"
                radius: 7
                Layout.fillWidth: true
                Layout.preferredHeight: 250
                Layout.minimumWidth: 200
                Layout.margins: 30
                clip: true

                Rectangle {
                    id: listViewHeader
                    height: 35
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    color: "#201E1E"
                    radius: 7

                    Rectangle {
                        //This rectangle is to cover the bottom curves.
                        height: parent.radius
                        color: parent.color
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                    }

                    Button {
                        id: addRecord
                        width: buttonAddRecordImg.sourceSize.width
                        height: buttonAddRecordImg.sourceSize.heigh
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.rightMargin: 10

                        background: Image {
                            id: buttonAddRecordImg
                            fillMode: Image.PreserveAspectFit

                            source: "qrc:/ui/Images.png/AddTask.png"
                        }
                        onClicked: {
                            console.log("The button 'AddRecord' is pressed")
                        }
                    }
                }

                Component {
                    id: contactDelegate
                    Rectangle {
                        id: elemen
                        height: 40
                        width: listView.width - 30
                        color: "#201E1E"
                        radius: 5
                        RowLayout {
                            anchors.fill: parent
                            Text {
                                id: minsText
                                Layout.alignment: Qt.AlignVCenter
                                color: "white"
                                text: model.mins + " mins"
                                leftPadding: 10
                            }
                            TextInput {
                                id: nameText
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                color: "white"
                                text: model.name
                                horizontalAlignment: Text.AlignHCenter
                                Layout.fillWidth: true
                                onEditingFinished: {
                                    itemModel.updateItem(index, text);
                                    console.log(index)
                                }
                            }
                            Text {
                                id: dateText
                                Layout.alignment: Qt.AlignVCenter
                                color: "white"
                                text: model.date
                                rightPadding: 10
                            }

                            Button {
                                id: deleteRecordButton
                                visible: mouse.hovered
                                Layout.alignment: Qt.AlignVCenter
                                width: delRecordImg.sourceSize.width
                                height: delRecordImg.sourceSize.heigh
                                scale: 0.7
                                background: Image {
                                    id: delRecordImg
                                    fillMode: Image.PreserveAspectFit
                                    source: "qrc:/ui/Images.png/delete 1.png"
                                }

                                onClicked: {
                                    console.log("The button 'DeleteRecord' is pressed")
                                    itemModel.removeRows(index, 1)
                                }
                            }

                            HoverHandler {
                                id: mouse
                                acceptedDevices: PointerDevice.Mouse
                                cursorShape: Qt.PointingHandCursor
                            }
                        }
                    }
                }

                ListView {
                    id: listView
                    anchors {
                        left: historyBlock.left
                        right: historyBlock.right
                        top: listViewHeader.bottom
                        bottom: historyBlock.bottom
                    }
                    model: itemModel
                    delegate: contactDelegate
                    focus: true
                    spacing: 5
                    leftMargin: 15
                    rightMargin: 15
                    topMargin: 5
                    clip: true


                    ScrollBar.vertical: ScrollBar {
                        policy: ScrollBar.AlwaysOn
                        size: listView.contentHeight / listView.height
                    }

                }
            }

        }

    }

}

