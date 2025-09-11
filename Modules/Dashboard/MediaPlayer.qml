import Quickshell
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls

import qs.Data
import qs.Helpers
import qs.Components

Rectangle {
	id: root

	Layout.fillWidth: true
	Layout.fillHeight: true
	radius: Appearance.rounding.normal
	color: Appearance.colors.withAlpha(Appearance.colors.surface, 0.7)
	border.color: Appearance.colors.outline
	border.width: 2

	function formatTime(seconds) {
		const hours = Math.floor(seconds / 3600);
		const minutes = Math.floor((seconds % 3600) / 60);
		const secs = Math.floor(seconds % 60);

		if (hours > 0)
			return `${hours}:${minutes.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`;

		return `${minutes}:${secs.toString().padStart(2, '0')}`;
	}

	ColumnLayout {
		anchors.fill: parent

		Item {
			id: mprisControll

			anchors.fill: parent

			required property int index
			readonly property MprisPlayer player: Mpris.players.values[index]

			Rectangle {
				anchors.fill: parent
				color: "transparent"

				Column {
					anchors.horizontalCenter: parent.horizontalCenter
					anchors.top: parent.top
					anchors.topMargin: 60
					spacing: Appearance.spacing.large

					Item {
						id: coverContainer

						anchors.horizontalCenter: parent.horizontalCenter
						width: 250
						height: 250

						Image {
							id: cover

							anchors.centerIn: parent

							property string notFoundImage: Qt.resolvedUrl(Quickshell.shellDir + "/Assets/image_not_found.svg")

							visible: false
							source: notFoundImage
							fillMode: Image.PreserveAspectCrop
							mipmap: true

							onStatusChanged: {
								if (mprisControll.player.trackArtUrl || mprisControll.player.trackArtUrl !== "")
									source = mprisControll.player.trackArtUrl;
							}
						}

						MultiEffect {
							source: cover
							anchors.fill: parent
							maskEnabled: true
							maskSource: maskCover
						}

						Item {
							id: maskCover

							anchors.fill: parent
							layer.enabled: true
							visible: false
							Rectangle {
								anchors.fill: parent
								radius: width / 2
							}
						}
					}

					Column {
						anchors.horizontalCenter: parent.horizontalCenter
						spacing: 8

						Text {
							id: titleText

							anchors.horizontalCenter: parent.horizontalCenter
							text: mprisControll.player.trackTitle !== "" ? mprisControll.player.trackTitle : "null"
							color: Appearance.colors.on_background
							font.pixelSize: Appearance.fonts.extraLarge
							font.bold: true
							horizontalAlignment: Text.AlignHCenter
							wrapMode: Text.WordWrap
							width: Math.min(implicitWidth, 300)
						}

						Text {
							id: artistText

							anchors.horizontalCenter: parent.horizontalCenter
							text: mprisControll.player.trackArtist !== "" ? mprisControll.player.trackArtist : "null"
							color: Appearance.colors.on_background
							font.pixelSize: Appearance.fonts.large
							opacity: 0.8
							horizontalAlignment: Text.AlignHCenter
							wrapMode: Text.WordWrap
							width: Math.min(implicitWidth, 300)
						}
					}

					Row {
						anchors.horizontalCenter: parent.horizontalCenter
						spacing: Appearance.spacing.large

						Repeater {
							model: [
								{
									icon: "skip_previous",
									action: () => {
										if (!mprisControll.player.canGoPrevious) {
											console.log("Can't go back");
											return;
										}
										mprisControll.player?.previous();
									}
								},
								{
									icon: mprisControll.player.playbackState === MprisPlaybackState.Playing ? "pause_circle" : "play_circle",
									action: () => {
										mprisControll.player.togglePlaying();
									}
								},
								{
									icon: "skip_next",
									action: () => {
										mprisControll.player.next();
									}
								}
							]

							delegate: Item {
								id: delegateController

								required property var modelData
								width: 56
								height: 56

								Rectangle {
									id: bgCon
									anchors.fill: parent
									anchors.margins: 4
									color: Appearance.colors.primary
									radius: Appearance.rounding.small
									opacity: clickArea.containsMouse ? 1 : 0.7
									scale: clickArea.pressed ? 0.95 : 1.0

									Behavior on opacity {
										NumberAnimation {
											duration: 150
										}
									}

									Behavior on scale {
										NumberAnimation {
											duration: 100
										}
									}
								}

								MouseArea {
									id: clickArea

									anchors.fill: parent
									cursorShape: Qt.PointingHandCursor
									hoverEnabled: true
									onClicked: delegateController.modelData.action()
								}

								MatIcon {
									anchors.centerIn: parent
									color: Appearance.colors.on_primary
									font.pixelSize: Appearance.fonts.large * 1.5
									icon: delegateController.modelData.icon
								}
							}
						}
					}

					Column {
						anchors.horizontalCenter: parent.horizontalCenter
						spacing: 8

						Text {
							id: timeTrack

							anchors.horizontalCenter: parent.horizontalCenter
							text: root.formatTime(mprisControll.player.position)
							color: Appearance.colors.on_background

							Timer {
								running: mprisControll.player.playbackState == MprisPlaybackState.Playing
								interval: 100
								repeat: true
								onTriggered: mprisControll.player.positionChanged()
							}
						}

						Slider {
							id: trackProgress

							hoverEnabled: true
							Layout.alignment: Qt.AlignHCenter

							background: Item {
								implicitWidth: 300
								implicitHeight: 10
								width: trackProgress.availableWidth
								x: trackProgress.leftPadding
								y: trackProgress.topPadding + trackProgress.availableHeight / 2 - height / 2

								Rectangle {
									id: unprogressBackground

									anchors.fill: parent
									color: Appearance.colors.withAlpha(Appearance.colors.primary, 0.1)
									radius: Appearance.rounding.small
								}

								Rectangle {
									id: progressBackground

									width: parent.width * trackProgress.visualPosition
									height: parent.height
									color: Appearance.colors.withAlpha(Appearance.colors.primary, 0.8)
									radius: Appearance.rounding.small
								}
							}

							value: mprisControll.player.length > 0 ? mprisControll.player.position / mprisControll.player.length : 0

							Timer {
								running: mprisControll.player.playbackState == MprisPlaybackState.Playing
								repeat: true
								interval: 100
								onTriggered: mprisControll.player.positionChanged()
							}

							handle: Rectangle {
								id: sliderHandle

								x: trackProgress.leftPadding + trackProgress.visualPosition * (trackProgress.availableWidth - width)
								y: trackProgress.topPadding + trackProgress.availableHeight / 2 - height / 2
								implicitWidth: 15
								implicitHeight: 15
								radius: width / 2
								color: trackProgress.pressed ? Appearance.colors.primary : Appearance.colors.on_surface

								Rectangle {
									anchors.centerIn: parent
									width: trackProgress.pressed ? 28 : (trackProgress.hovered ? 24 : 0)
									height: width
									radius: width / 2
									color: Appearance.colors.withAlpha(Appearance.colors.primary, 0.12)
									visible: trackProgress.pressed || trackProgress.hovered

									Behavior on width {
										NumbAnim {}
									}
								}
							}

							onMoved: mprisControll.player.position = value * mprisControll.player.length
						}
					}
				}
			}
		}
	}
}
