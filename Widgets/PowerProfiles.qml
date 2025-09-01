pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower

import qs.Data
import qs.Helpers

Rectangle {
	Layout.fillHeight: true
	clip: true
	color: Appearance.colors.withAlpha(Appearance.colors.background, 0.79)
	implicitWidth: container.width
	radius: 5

	Behavior on implicitWidth {
		NumberAnimation {
			duration: Appearance.animations.durations.normal
			easing.type: Easing.BezierSpline
			easing.bezierCurve: Appearance.animations.curves.standard
		}
	}

	MouseArea {
		id: mArea

		anchors.fill: parent
		hoverEnabled: true

		RowLayout {
			id: container

			anchors.bottom: parent.bottom
			anchors.left: parent.left
			anchors.top: parent.top
			clip: true

			Repeater {
				model: [
					{
						icon: "potted_plant",
						profile: PowerProfile.PowerSaver
					},
					{
						icon: "balance",
						profile: PowerProfile.Balanced
					},
					{
						icon: "speed",
						profile: PowerProfile.Performance
					},
				]

				delegate: Item {
					id: delegateRoot

					required property int index
					required property var modelData

					Layout.fillHeight: true
					implicitWidth: this.height ? this.height : 1

					Rectangle {
						id: bgCon

						anchors.fill: parent
						anchors.margins: 4
						color: Appearance.colors.primary
						radius: 5
						visible: delegateRoot.modelData.profile == PowerProfiles.profile
					}

					MArea {
						anchors.margins: 4
						layerColor: fgText.color
						layerRadius: 5
						visible: !bgCon.visible

						onClicked: PowerProfiles.profile = delegateRoot.modelData.profile
					}

					MatIcon {
						id: fgText

						anchors.centerIn: parent
						color: bgCon.visible ? Appearance.colors.on_primary : Appearance.colors.on_background
						fill: bgCon.visible
						font.pointSize: 14
						icon: delegateRoot.modelData.icon
					}
				}
			}
		}
	}
}
