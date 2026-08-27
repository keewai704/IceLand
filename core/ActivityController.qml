pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    readonly property string idleMode: "idle"
    readonly property string activityMode: "activity"

    property string mode: idleMode
    property string activityId: ""
    property string iconText: "✦"
    property string title: ""
    property string detail: ""
    property real progress: -1
    property int priority: 0
    property bool expanded: false
    property bool pinned: false

    readonly property bool active: mode !== idleMode

    signal activityAccepted(string activityId)
    signal activityRejected(string activityId, int incomingPriority, int currentPriority)
    signal activityCleared(string activityId)

    Timer {
        id: dismissTimer
        repeat: false

        onTriggered: {
            if (!root.pinned) {
                root.clearActivity(root.activityId);
            }
        }
    }

    function normalizedProgress(value: real): real {
        if (!isFinite(value)) {
            return -1;
        }

        return Math.max(-1, Math.min(1, value));
    }

    function showActivity(activityKey: string, titleText: string, detailText: string, icon: string, progressValue: real, timeoutMs: int, incomingPriority: int, keepVisible: bool): bool {
        const acceptedPriority = Math.max(0, incomingPriority);
        const acceptedId = activityKey.length > 0 ? activityKey : "anonymous";

        if (root.active && acceptedPriority < root.priority) {
            root.activityRejected(acceptedId, acceptedPriority, root.priority);
            return false;
        }

        dismissTimer.stop();

        root.activityId = acceptedId;
        root.title = titleText;
        root.detail = detailText;
        root.iconText = icon.length > 0 ? icon : "✦";
        root.progress = root.normalizedProgress(progressValue);
        root.priority = acceptedPriority;
        root.pinned = keepVisible;
        root.expanded = false;
        root.mode = root.activityMode;

        if (!root.pinned && timeoutMs > 0) {
            dismissTimer.interval = timeoutMs;
            dismissTimer.start();
        }

        root.activityAccepted(root.activityId);
        return true;
    }

    function updateProgress(activityKey: string, value: real): bool {
        if (!root.active || activityKey !== root.activityId) {
            return false;
        }

        root.progress = root.normalizedProgress(value);
        return true;
    }

    function clearActivity(activityKey: string): bool {
        if (!root.active || (activityKey.length > 0 && activityKey !== root.activityId)) {
            return false;
        }

        const clearedId = root.activityId;
        dismissTimer.stop();

        root.mode = root.idleMode;
        root.activityId = "";
        root.iconText = "✦";
        root.title = "";
        root.detail = "";
        root.progress = -1;
        root.priority = 0;
        root.expanded = false;
        root.pinned = false;

        root.activityCleared(clearedId);
        return true;
    }

    function setExpanded(value: bool): bool {
        if (!root.active) {
            return false;
        }

        root.expanded = value;
        return true;
    }

    function toggleExpanded(): bool {
        return root.setExpanded(!root.expanded);
    }
}
