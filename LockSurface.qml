import qs.Data

import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import Quickshell.Io
import QtQuick.Layouts
import QtQuick.Controls.Fusion
import Quickshell.Wayland

WlSessionLockSurface {
	id: root

	required property Pam context
	required property WlSessionLock lock

	Rectangle {
		id: surface
		anchors.fill: parent

		property color clockColor: Appearance.colors.primary_container
		property string path
		color: Appearance.colors.background

		Process {
			id: wallPath
			running: true
			command: ["sh", "-c", "caelestia wallpaper"]
			stdout: StdioCollector {
				onStreamFinished: {
					surface.path = text.trim();
				}
			}
		}
		Image {
			id: wall
			source: `${surface.path}`
			sourceSize: parent
			fillMode: Image.PreserveAspectFit
			visible: false
			opacity: 0

			onStatusChanged: {
				if (status === Image.Ready) {
					fadeIn.start();
				}
			}

			NumberAnimation {
				id: fadeIn
				target: wall
				property: "opacity"
				from: 0
				to: 1
				duration: Appearance.animations.durations.small * 1.2
				easing.type: Easing.BezierSpline
				easing.bezierCurve: Appearance.animations.curves.emphasizedAccel
			}
		}
		MultiEffect {
			source: wall
			anchors.fill: wall
			width: parent.width
			height: parent.height
			blurEnabled: true
			blurMax: 60
			blur: 1.0

			opacity: wall.opacity
			Behavior on opacity {
				NumberAnimation {
					duration: Appearance.animations.durations.small * 1.2
					easing.type: Easing.BezierSpline
					easing.bezierCurve: Appearance.animations.curves.emphasizedAccel
				}
			}
		}

		ColumnLayout {
			anchors.centerIn: parent
			spacing: 5

			property var currentDate: new Date()

			function getDayName(index) {
				const days = ["Minggu", "Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu"];
				return days[index];
			}

			function getMonthName(index) {
				const months = ["Jan", "Feb", "Mar", "Apr", "Mei", "Jun", "Jul", "Aug", "Sep", "Okt", "Nov", "Des"];
				return months[index];
			}

			Timer {
				interval: 1000
				repeat: true
				running: true
				onTriggered: parent.currentDate = new Date()
			}

			Label {
				font.pointSize: Appearance.fonts.extraLarge * 4
				font.family: Appearance.fonts.family_Clock
				font.bold: true
				color: surface.clockColor
				renderType: Text.NativeRendering
				text: {
					const hours = parent.currentDate.getHours().toString().padStart(2, '0');
					const minutes = parent.currentDate.getMinutes().toString().padStart(2, '0');
					return `${hours}\n${minutes}`;
				}
				Layout.alignment: Qt.AlignHCenter
			}

			Label {
				font.pointSize: Appearance.fonts.medium * 2
				font.family: Appearance.fonts.family_Mono
				color: surface.clockColor
				renderType: Text.NativeRendering
				text: parent.getDayName(parent.currentDate.getDay())
				Layout.alignment: Qt.AlignHCenter
			}

			Label {
				font.pointSize: Appearance.fonts.smaller * 3.5
				font.family: Appearance.fonts.family_Sans
				color: Appearance.colors.on_primary
				renderType: Text.NativeRendering
				text: `${parent.currentDate.getDate()} ${parent.getMonthName(parent.currentDate.getMonth())}`
				Layout.alignment: Qt.AlignHCenter
			}
		}

		ColumnLayout {
			anchors {
				horizontalCenter: parent.horizontalCenter
				bottom: parent.bottom
				bottomMargin: 75
			}
			Label {
				id: incorrectPasswordText
				text: "Incorrect password"
				color: Appearance.colors.on_error
				visible: root.context.showFailure
				opacity: root.context.showFailure ? 1 : 0

				Behavior on opacity {
					PropertyAnimation {
						duration: Appearance.animations.durations.normal
						easing.type: Easing.BezierSpline
						easing.bezierCurve: Appearance.animations.curves.standard
					}
				}
			}

			RowLayout {
				TextField {
					id: passwordBox

					echoMode: TextInput.Password
					enabled: !root.context.unlockInProgress
					focus: true
					color: root.context.unlockInProgress ? Appearance.colors.on_error : Appearance.colors.on_background
					background: Rectangle {
						anchors.fill: parent
						color: Appearance.colors.withAlpha(Appearance.colors.background, 0.25)
						border.color: Appearance.colors.on_primary
						border.width: 2
						radius: 35
						opacity: passwordBox.activeFocus ? 1 : 0.5

						Behavior on border.width {
							PropertyAnimation {
								duration: Appearance.animations.durations.normal
								easing.type: Easing.BezierSpline
								easing.bezierCurve: Appearance.animations.curves.standard
							}
						}
						Behavior on opacity {
							PropertyAnimation {
								duration: Appearance.animations.durations.normal
								easing.type: Easing.BezierSpline
								easing.bezierCurve: Appearance.animations.curves.standard
							}
						}
					}
					implicitWidth: 400
					inputMethodHints: Qt.ImhSensitiveData
					padding: 10
					onAccepted: {
						onStatusChanged: {
							root.context.tryUnlock();
						}
					}
					onTextChanged: root.context.currentText = this.text
					Layout.alignment: Qt.AlignVBottom
					Connections {
						function onCurrentTextChanged() {
							passwordBox.text = root.context.currentText;
						}
						target: root.context
					}
				}
			}
		}
	}
}
