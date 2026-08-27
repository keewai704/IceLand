pragma Singleton

import Quickshell
import QtQuick

Singleton {
    readonly property int windowHeight: 216
    readonly property int topMargin: 8
    readonly property int screenEdgeMargin: 16

    readonly property int idleWidth: 112
    readonly property int idleHeight: 36
    readonly property int activityWidth: 336
    readonly property int activityHeight: 68
    readonly property int expandedWidth: 424
    readonly property int expandedHeight: 152

    readonly property int idleRadius: 18
    readonly property int activityRadius: 26
    readonly property int expandedRadius: 30

    readonly property int contentPadding: 14
    readonly property int contentSpacing: 10

    readonly property int geometryDuration: 300
    readonly property int opacityDuration: 150
    readonly property int progressDuration: 180
    readonly property int hoverDuration: 120

    readonly property color surfaceColor: "#F0101116"
    readonly property color surfaceBorderColor: "#26FFFFFF"
    readonly property color primaryTextColor: "#F5F7FA"
    readonly property color secondaryTextColor: "#AEB6C2"
    readonly property color accentColor: "#8FB8FF"
    readonly property color progressTrackColor: "#32FFFFFF"
    readonly property color idleIndicatorColor: "#79A7FF"
}
