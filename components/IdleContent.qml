import Quickshell
import QtQuick
import qs.config

Item {
    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    Item {
        anchors.centerIn: parent
        width: indicator.width + 8 + clockLabel.implicitWidth
        height: Math.max(indicator.height, clockLabel.implicitHeight)

        Rectangle {
            id: indicator

            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            width: 6
            height: 6
            radius: 3
            color: Theme.idleIndicatorColor
        }

        Text {
            id: clockLabel

            anchors.left: indicator.right
            anchors.leftMargin: 8
            anchors.verticalCenter: parent.verticalCenter
            text: Qt.formatDateTime(clock.date, "HH:mm")
            textFormat: Text.PlainText
            color: Theme.primaryTextColor
            font.pixelSize: 15
            font.weight: Font.DemiBold
        }
    }
}
