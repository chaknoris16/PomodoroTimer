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
            spacing: 30


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
                visible: true
                color: "#313236"
                radius: 7
                Layout.fillWidth: true
                Layout.preferredHeight: 250
                Layout.minimumWidth: 200
                Layout.margins: 30
                ItemDelegate {
                    anchors.fill: parent
                }
            }

        }

    }

}

