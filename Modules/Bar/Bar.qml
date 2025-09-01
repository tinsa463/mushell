import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import qs.Data
import qs.Widgets

Scope {
	Variants {
		id: bar
		model: Quickshell.screens
		delegate: PanelWindow {
			id: root
			required property ShellScreen modelData

			anchors {
				left: true
				right: true
				top: true
			}
			color: "transparent"
			screen: modelData
			exclusionMode: ExclusionMode.Auto
			focusable: false
			implicitHeight: 35
			exclusiveZone: 1
			surfaceFormat.opaque: false

			Item {
				id: base
				anchors.fill: parent
				anchors.margins: 4

				RowLayout {
					anchors.fill: parent
					spacing: 0

					Left {
						Layout.fillHeight: true
						Layout.preferredWidth: parent.width / 3
						Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
					}

					Middle {
						Layout.fillHeight: true
						Layout.preferredWidth: parent.width / 3
						Layout.alignment: Qt.AlignCenter
					}

					Right {
						Layout.fillHeight: true
						Layout.preferredWidth: parent.width / 3
						Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
					}
				}
			}
		}
	}

	IpcHandler {
		target: "layerShell"
		function toggle(): void {
			if (bar.model == "") {
				bar.model = Quickshell.screens;
			} else {
				bar.model = "";
			}
		}
	}
}
