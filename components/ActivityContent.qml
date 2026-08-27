import QtQuick
import qs.config
import qs.core

Item {
    id: root

    readonly property real boundedProgress: Math.max(0, Math.min(1, ActivityController.progress))

    Text {
        id: iconLabel

        anchors.left: parent.left
        anchors.leftMargin: Theme.contentPadding
        anchors.verticalCenter: parent.verticalCenter
        text: ActivityController.iconText
        textFormat: Text.PlainText
        color: Theme.primaryTextColor
        font.pixelSize: ActivityController.expanded ? 24 : 20
    }

    Column {
        id: textColumn

        anchors.left: iconLabel.right
        anchors.leftMargin: Theme.contentSpacing
        anchors.right: parent.right
        anchors.rightMargin: Theme.contentPadding
        anchors.verticalCenter: parent.verticalCenter
        spacing: 2

        Text {
            width: parent.width
            text: ActivityController.title
            textFormat: Text.PlainText
            color: Theme.primaryTextColor
            font.pixelSize: ActivityController.expanded ? 17 : 15
            font.weight: Font.DemiBold
            elide: Text.ElideRight
            maximumLineCount: 1
        }

        Text {
            width: parent.width
            visible: text.length > 0
            text: ActivityController.detail
            textFormat: Text.PlainText
            color: Theme.secondaryTextColor
            font.pixelSize: ActivityController.expanded ? 14 : 12
            elide: Text.ElideRight
            maximumLineCount: 1
        }
    }

    Rectangle {
        id: progressTrack

        visible: ActivityController.progress >= 0
        anchors.left: textColumn.left
        anchors.right: parent.right
        anchors.rightMargin: Theme.contentPadding
        anchors.bottom: parent.bottom
        anchors.bottomMargin: ActivityController.expanded ? Theme.contentPadding : 7
        height: 3
        radius: height / 2
        color: Theme.progressTrackColor

        Rectangle {
            width: parent.width * root.boundedProgress
            height: parent.height
            radius: parent.radius
            color: Theme.accentColor

            Behavior on width {
                NumberAnimation {
                    duration: Theme.progressDuration
                    easing.type: Easing.OutCubic
                }
            }
        }
    }
}
