import Quickshell
import "Widgets/Clock"
import "Widgets/Workspaces"
import "Widgets/SysTray"
import Quickshell.Hyprland

Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData
      screen: modelData

      anchors {
        top: true
        left: true
        right: true
      }

      implicitHeight: 30

      WorkspacesWidget {
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        workspaces: Hyprland.workspaces.values
        monitor: Hyprland.monitorFor(screen)
      }

      ClockWidget {
        anchors.centerIn: parent
      }

      SysTrayWidget {
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter
      }
    }
  }
}
