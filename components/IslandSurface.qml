import QtQuick
import qs.config
import qs.core

Rectangle {
    id: root

    readonly property bool isExpanded: ActivityController.active && ActivityController.expanded
    readonly property int requestedWidth: isExpanded
        ? Theme.expandedWidth
        : ActivityController.active ? Theme.activityWidth : Theme.idleWidth
    readonly property int requestedHeight: isExpanded
        ? Theme.expandedHeight
        : ActivityController.active ? Theme.activityHeight : Theme.idleHeight
    readonly property int availableWidth: parent
        ? Math.max(Theme.idleWidth, parent.width - Theme.screenEdgeMargin * 2)
        : requestedWidth

    width: Math.min(requestedWidth, availableWidth)
    height: requestedHeight
    radius: isExpanded
        ? Theme.expandedRadius
        : ActivityController.active ? Theme.activityRadius : Theme.idleRadius
    color: Theme.surfaceColor
    border.width: 1
    border.color: Theme.surfaceBorderColor
    clip: true
    transformOrigin: Item.Top
    scale: pointerArea.containsMouse ? 1.01 : 1

    Behavior on width {
        NumberAnimation {
            duration: Theme.geometryDuration
            easing.type: Easing.OutCubic
        }
    }

    Behavior on height {
        NumberAnimation {
            duration: Theme.geometryDuration
            easing.type: Easing.OutCubic
        }
    }

    Behavior on radius {
        NumberAnimation {
            duration: Theme.geometryDuration
            easing.type: Easing.OutCubic
        }
    }

    Behavior on scale {
        NumberAnimation {
            duration: Theme.hoverDuration
            easing.type: Easing.OutCubic
        }
    }

    IdleContent {
        anchors.fill: parent
        opacity: ActivityController.active ? 0 : 1
        visible: opacity > 0.01

        Behavior on opacity {
            NumberAnimation {
                duration: Theme.opacityDuration
            }
        }
    }

    ActivityContent {
        anchors.fill: parent
        opacity: ActivityController.active ? 1 : 0
        visible: opacity > 0.01

        Behavior on opacity {
            NumberAnimation {
                duration: Theme.opacityDuration
            }
        }
    }

    MouseArea {
        id: pointerArea

        anchors.fill: parent
        hoverEnabled: true
        cursorShape: ActivityController.active ? Qt.PointingHandCursor : Qt.ArrowCursor

        onClicked: {
            if (ActivityController.active) {
                ActivityController.toggleExpanded();
            }
        }
    }
}
