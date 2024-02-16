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
                    dial.controller.startDial(time)
                    stackView.push(dial)
                }

            }

            DialPage {
                id: dial
                visible: false
                //minutes: timerSelector.minutes + " min"
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

                ListModel {
                    id: listModel
                    ListElement {
                        name: "Work"
                        mins: 5
                        date: "15.02.2024"
                    }
                    ListElement {
                        name: "Hobbi"
                        mins: 25
                        date: "14.02.2024"
                    }
                    ListElement {
                        name: "Cook"
                        mins: 3
                        date: "14.02.2024"
                    }
                }
                Component {
                    id: contactDelegate
                    Rectangle {
                        id: elemen
                        height: 40
                        width: listView.width - 10
                        color: "#201E1E"
                        radius: 5

                        Row {
                            anchors.fill: parent
                            spacing: 50
                            Text {
                                anchors.left: parent.left
                                anchors.verticalCenter: parent.verticalCenter
                                color: "white"
                                text: model.mins + " mins"
                                leftPadding: 10
                            }
                            TextInput {
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter
                                color: "white"
                                text: model.name
                                onEditingFinished: {
                                    itemModel.updateItem(index, text);
                                }
                            }
                            Text {
                                anchors.right: parent.right
                                anchors.verticalCenter: parent.verticalCenter
                                color: "white"
                                text: model.date
                                rightPadding: 10
                            }
                        }
                    }
                }

                ListView {
                    id: listView
                    anchors.fill: parent
                    model: itemModel
                    delegate: contactDelegate
                    focus: true
                    spacing: 5
                    leftMargin: 5
                    rightMargin: 5
                    topMargin: 5
                    clip: true
                }
            }

        }

    }

}

