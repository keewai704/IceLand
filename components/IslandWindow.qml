import Quickshell
import Quickshell.Wayland
import QtQuick
import qs.config

PanelWindow {
    id: root

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: Theme.windowHeight
    color: "transparent"
    surfaceFormat.opaque: false
    exclusionMode: ExclusionMode.Ignore
    aboveWindows: true
    focusable: false

    WlrLayershell.namespace: "iceland"
    WlrLayershell.layer: WlrLayer.Overlay

    mask: Region {
        item: islandSurface
    }

    IslandSurface {
        id: islandSurface

        anchors.top: parent.top
        anchors.topMargin: Theme.topMargin
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
