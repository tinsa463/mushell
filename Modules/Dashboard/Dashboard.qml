pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

import Quickshell
import Quickshell.Io
import Quickshell.Wayland

import qs.Data
import "Inbox" as Inbox

Scope {
	id: root

	property bool isDashboardOpen: false
	property int currentIndex: 0
	property int baseWidth: 1366
	property int baseHeight: 768
	property int baseSectionWidth: 455
	property int baseSectionHeight: baseWidth
	property int cpuUsage: 0
	property int ramUsage: 0

	function toggleDashboard(): void {
		isDashboardOpen = !isDashboardOpen;
	}

	PanelWindow {
		id: dashboard

		property ShellScreen modelData

		anchors {
			top: true
			bottom: true
			right: true
			left: true
		}

		WlrLayershell.namespace: "shell"
		visible: root.isDashboardOpen
		focusable: true
		color: "transparent"
		screen: modelData
		exclusiveZone: 0
		implicitWidth: root.baseWidth
		implicitHeight: root.baseHeight

		Rectangle {
			anchors.fill: parent
			anchors.margins: 20
			color: "transparent"

			Item {
				anchors.fill: parent
				focus: true
				Keys.onEscapePressed: root.toggleDashboard()

				RowLayout {
					anchors.fill: parent
					spacing: Appearance.spacing.large

					ColumnLayout {
						id: notifsAndWeatherLayout

						Layout.fillWidth: true
						Layout.alignment: Qt.AlignTop
						Layout.maximumHeight: parent.height
						Layout.preferredWidth: root.baseWidth / 3
						Layout.minimumWidth: 400

						Inbox.Header {}

						Inbox.Notification {}

						WeatherWidget {
							Layout.fillWidth: true
							Layout.preferredHeight: 350
							Layout.topMargin: 8
						}
					}
					ColumnLayout {
						id: performanceLayout

						Layout.fillWidth: true
						Layout.fillHeight: true

						Layout.preferredWidth: root.baseWidth / 3
						Layout.minimumWidth: 400

						Rectangle {
							Layout.fillWidth: true
							Layout.fillHeight: true
							radius: 8
							color: "transparent"
						}
					}

					ColumnLayout {
						id: mprisLayout

						Layout.fillWidth: true
						Layout.fillHeight: true
						Layout.preferredWidth: root.baseWidth / 3
						Layout.minimumWidth: 400

						MediaPlayer {}
					}
				}
			}
		}
	}

	IpcHandler {
		target: "dashboard"

		function toggle(): void {
			root.toggleDashboard();
		}
	}
}
