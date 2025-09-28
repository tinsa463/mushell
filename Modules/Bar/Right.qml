import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pipewire

import qs.Widgets
import qs.Data
import qs.Components

Rectangle {
	color: "transparent"
	RowLayout {
		anchors.fill: parent
		anchors.rightMargin: 8
		layoutDirection: Qt.RightToLeft
		spacing: Appearance.spacing.small

		Clock {
			Layout.alignment: Qt.AlignVCenter
			Layout.maximumWidth: implicitWidth
		}
		Tray {
			Layout.alignment: Qt.AlignVCenter
		}
		PowerProfiles {
			Layout.alignment: Qt.AlignVCenter
			Layout.maximumWidth: implicitWidth
		}
		Rectangle {
			Layout.alignment: Qt.AlignVCenter
			Layout.preferredWidth: 220
			Layout.preferredHeight: 25
			color: mArea.containsPress ? Appearance.colors.withAlpha(Appearance.colors.on_surface, 0.08) : mArea.containsMouse ? Appearance.colors.withAlpha(Appearance.colors.on_surface, 0.16) : Appearance.colors.withAlpha(Appearance.colors.on_surface, 0.20)
			radius: Appearance.rounding.normal

			Behavior on color {
				ColAnim {}
			}

			RowLayout {
				anchors.fill: parent
				spacing: Appearance.spacing.small

				Sound {
					Layout.alignment: Qt.AlignVCenter
					Layout.fillHeight: true
				}
				Sound {
					Layout.alignment: Qt.AlignVCenter
					Layout.fillHeight: true
					node: Pipewire.defaultAudioSource
				}
				Battery {
					Layout.alignment: Qt.AlignVCenter
					Layout.fillHeight: true
				}
			}

			MouseArea {
				id: mArea

				anchors.fill: parent
				hoverEnabled: true
				onClicked: console.log("test")
			}
		}
	}
}
