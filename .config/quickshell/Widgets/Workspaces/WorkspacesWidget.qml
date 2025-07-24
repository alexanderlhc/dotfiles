import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

RowLayout {
    id: workspacesWidget
    spacing: 12

    property int dotSize: 10
    property int focusedDotSize: 14
    property int workspaceCount: 10
    property color colorEmpty: "#444"
    property color colorOccupied: "#888"
    property color colorHover: "#ccc"
    property color colorFocused: "#4CAF50"
    property color colorFocusedOther: "#FBC02D"

    property var monitor: null
    property var workspaces: []

    property var workspaceMap: ({})
    onWorkspacesChanged: {
        var newMap = {};
        for (var i = 0; i < workspaces.length; ++i) {
            newMap[workspaces[i].id] = workspaces[i];
        }
        workspaceMap = newMap;
    }

    Repeater {
        model: workspaceCount

        Item {
            id: dotDelegate
            width: focusedDotSize
            height: focusedDotSize

            readonly property int wsIndex: index + 1
            readonly property var ws: workspacesWidget.workspaceMap[wsIndex]

            property bool isFocused: ws ? ws.focused : false
            property bool isFocusedOnOtherMonitor: ws ? (ws.active && !ws.focused) : false
            property bool isOccupied: (ws != null) && !isFocused && !isFocusedOnOtherMonitor

            Rectangle {
                id: dot
                x: (parent.width - width) / 2
                y: (parent.height - height) / 2
                width: dotSize
                height: dotSize
                radius: width / 2

                color: {
                    if (isFocused) return workspacesWidget.colorFocused;
                    if (isFocusedOnOtherMonitor) return workspacesWidget.colorFocusedOther;
                    if (mouseArea.containsMouse) return workspacesWidget.colorHover;
                    if (isOccupied) return workspacesWidget.colorOccupied;
                    return workspacesWidget.colorEmpty;
                }

                transform: Scale {
                    origin.x: dot.width / 2
                    origin.y: dot.height / 2
                    xScale: {
                        if (isFocused) return focusedDotSize / dotSize;
                        if (isFocusedOnOtherMonitor) return 1.25;
                        if (mouseArea.containsMouse) return 1.15;
                        return 1.0;
                    }
                    yScale: xScale
                }

                Behavior on color { ColorAnimation { duration: 200 } }
                Behavior on transform { ScaleAnimator { duration: 200; easing.type: Easing.OutBack } }
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: { Hyprland.dispatch(`workspace ${wsIndex}`); }
            }
        }
    }
}
