import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.Data

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
			color: Appearance.colors.background
			screen: modelData
			exclusionMode: ExclusionMode.Auto
			focusable: false
			implicitHeight: 30
			exclusiveZone: 1
			surfaceFormat.opaque: false

			Item {
				id: base
				anchors.fill: parent
				anchors.margins: 4

				RowLayout {
					width: parent.width
					anchors.fill: parent

					Left {
						Layout.fillHeight: true
						Layout.preferredWidth: parent.width / 6 
						Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
					}

					Middle {
						Layout.fillHeight: true
						Layout.preferredWidth: parent.width / 6 
						Layout.alignment: Qt.AlignCenter
					}

					Right {
						Layout.fillHeight: true
						Layout.preferredWidth: parent.width / 6 
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
