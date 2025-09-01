import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets

import qs.Data
import qs.Helpers

RowLayout {
    property HyprlandMonitor monitor: Hyprland.monitorFor(screen)

    Rectangle {
        id: workspaceBar
        Layout.preferredWidth: Math.max(50, Workspaces.maxWorkspace * 25)
        Layout.fillHeight: true
        radius: 7
        color: Appearance.colors.background

        Row {
            anchors.centerIn: parent
            spacing: 15

            Repeater {
                model: Workspaces.maxWorkspace || 1

                Item {
                    required property int index
                    property bool focused: Hyprland.focusedMonitor?.activeWorkspace?.id === (index + 1)
                    
                    width: workspaceText.width
                    height: workspaceText.height

                    Text {
                        id: workspaceText
                        text: (index + 1).toString()
                        color: "white"
                        font.pixelSize: 15
                        font.bold: focused
                    }

                    Rectangle {
                        visible: focused
                        anchors {
                            left: workspaceText.left
                            right: workspaceText.right
                            top: workspaceText.bottom
                            topMargin: -3
                        }
                        height: 2
                        color: "white"
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: Workspaces.switchWorkspace(index + 1)
                    }
                }
            }
        }
    }
}
