pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import Qt5Compat.GraphicalEffects

MouseArea {
    id: root

    required property SystemTrayItem modelData

    acceptedButtons: Qt.LeftButton | Qt.RightButton
    implicitWidth: 13
    implicitHeight: 13

    onClicked: event => {
        // For nm-applet and similar items without an Activate method,
        // open the menu on left-click.
        if (event.button === Qt.LeftButton) {
            if (modelData.hasMenu) {
                menu.open();
            } else {
                modelData.activate(); // Fallback for items that do have activate
            }
        } else if (modelData.hasMenu) {
            menu.open();
        }
    }

    QsMenuAnchor {
        id: menu
        menu: root.modelData.menu
        anchor.window: this.QsWindow.window
    }

    IconImage {
        id: trayIcon
        width: parent.implicitWidth
        height: parent.implicitHeight
        // visible:
        source: root.modelData.icon
        anchors.centerIn: parent
        // onPaletteChanged: {
        //     // var oldSource = source;
        //     // source = "";
        //     // source = oldSource;
        //     console.info("CHHH -> " + oldSource);
        // }
    }
}
