import QtQuick 2.15
import QtQuick.Controls.Basic
import QtQuick.Controls 2.15
import QtQuick.Window 2.2
import QtQuick.Dialogs

MessageDialog {
    id: notification

    property string message: "Default message"
    property int notificationWidth: 200
    property int notificationHeight: 100
    property int animationDuration: 300 // мілісекунди
    // x: ScreenInfo.height - notificationHeight
    // y: ScreenInfo.width - notificationWidth
    Rectangle {
        id: notificationRectangle
        width: notification.notificationWidth
        height: notification.notificationHeight
        color: "lightblue"
        border.color: "darkblue"
        border.width: 1
        radius: 10



        Text {
            anchors.centerIn: parent
            text: notification.message
        }


    }


    function show(message) {
        notification.message = message;
        visible = true;

        // Запустіть анімацію зникнення через певний час
        //notificationRectangle.opacityAnimation.start();
    }
}
