pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris

import qs.Data
import qs.Helpers
import qs.Components

Rectangle {
	id: root

	anchors.centerIn: parent

	color: "transparent"

	property bool playerControlShow: false

	RowLayout {
		id: mediaInfo

		anchors.centerIn: parent
		spacing: Appearance.spacing.small

		MatIcon {
			icon: Player.active.playbackState === MprisPlaybackState.Playing ? "genres" : "play_circle"
			font.pixelSize: Appearance.fonts.medium * 1.8
			color: Appearance.colors.on_background
		}

		RowLayout {
			StyledText {
				text: Player.active.trackArtist
				color: Appearance.colors.on_background
			}
		}
	}

	MouseArea {
		anchors.fill: mediaInfo

		cursorShape: Qt.PointingHandCursor
		hoverEnabled: true
		onClicked: root.playerControlShow = !root.playerControlShow
	}

	RowLayout {
		id: mediaControl

		anchors.left: parent.left
		anchors.leftMargin: Appearance.margin.large * 4
		anchors.verticalCenter: parent.verticalCenter

		opacity: root.playerControlShow ? 1 : 0
		visible: opacity > 0

		Behavior on opacity {
			NumbAnim {}
		}

		Repeater {
			model: [
				{
					icon: "skip_previous",
					action: () => {
						if (!Player.active.canGoPrevious) {
							console.log("Can't go back");
							return;
						}
						Player.active.previous();
					}
				},
				{
					icon: Player.active.playbackState === MprisPlaybackState.Playing ? "pause_circle" : "play_circle",
					action: () => {
						Player.active.togglePlaying();
					}
				},
				{
					icon: "skip_next",
					action: () => {
						Player.active.next();
					}
				}
			]

			delegate: Item {
				id: delegateItem

				required property var modelData

				Layout.preferredHeight: 28
				Layout.preferredWidth: 28

				opacity: root.playerControlShow ? 1 : 0
				scale: root.playerControlShow ? 1 : 0.8

				Behavior on opacity {
					NumbAnim {}
				}

				Behavior on scale {
					NumbAnim {}
				}

				Rectangle {
					anchors.fill: parent
					anchors.margins: 2
					color: Appearance.colors.on_primary
					radius: Appearance.rounding.small
					opacity: clickArea.containsMouse ? 1 : 0.8
					scale: clickArea.pressed ? 0.95 : 1.0

					Behavior on opacity {
						NumbAnim {}
					}

					Behavior on scale {
						NumbAnim {}
					}
				}

				MouseArea {
					id: clickArea

					anchors.fill: parent
					cursorShape: Qt.PointingHandCursor
					hoverEnabled: true
					onClicked: delegateItem.modelData.action()
				}

				MatIcon {
					anchors.centerIn: parent
					color: Appearance.colors.primary
					font.pixelSize: Appearance.fonts.large * 1.2
					icon: delegateItem.modelData.icon
				}
			}
		}
	}
}
