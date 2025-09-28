import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets

import qs.Data
import qs.Helpers
import qs.Components

Scope {
	Variants {
		model: Quickshell.screens

		delegate: WlrLayershell {
			id: root

			required property ShellScreen modelData

			anchors {
				top: true
				right: true
				left: true
				bottom: true
			}

			namespace: "shell:bigclock"
			layer: WlrLayer.Background
			screen: modelData
			color: "transparent"

			exclusiveZone: 0

			Rectangle {
				anchors.centerIn: parent

				color: "transparent"

				ColumnLayout {
					id: clock

					anchors.centerIn: parent
					spacing: Appearance.spacing.normal

					StyledText {
						id: hours

						Layout.alignment: Qt.AlignCenter
						text: Qt.formatDateTime(Time?.date, "h:mm AP")
						font.pixelSize: Appearance.fonts.extraLarge * 2.5
						font.family: "Inter"
						font.bold: true
						antialiasing: true
						color: Appearance.colors.withAlpha(Appearance.colors.surface, 0.5)
					}

					RowLayout {
						Layout.alignment: Qt.AlignCenter

						StyledText {
							id: day

							text: Qt.formatDateTime(Time?.date, "dddd")
							font.pixelSize: Appearance.fonts.large
							color: Appearance.colors.withAlpha(Appearance.colors.surface, 0.3)
							antialiasing: true
							font.bold: true
						}

						StyledText {
							id: month

							text: Qt.formatDateTime(Time?.date, "MMMM")
							font.pixelSize: Appearance.fonts.large
							color: Appearance.colors.withAlpha(Appearance.colors.surface, 0.3)
							antialiasing: true
							font.bold: true
						}

						StyledText {
							id: year

							text: Qt.formatDateTime(Time?.date, "yyyy")
							font.pixelSize: Appearance.fonts.large
							color: Appearance.colors.withAlpha(Appearance.colors.surface, 0.3)
							antialiasing: true
							font.bold: true
						}

						IconImage {
							id: weatherIcon

							Layout.alignment: Qt.AlignHCenter
							implicitSize: 37
							source: Qt.resolvedUrl("https://openweathermap.org/img/wn/" + Weather.weatherIconData + "@4x.png")
							asynchronous: true
							smooth: true
						}

						StyledText {
							id: temp

							text: Weather.tempData + "°"
							font.pixelSize: Appearance.fonts.large
							color: Appearance.colors.withAlpha(Appearance.colors.surface, 0.3)
							antialiasing: true
							font.bold: true
						}

						MatIcon {
							id: humidityIcon

							icon: "humidity_low"
							font.pixelSize: Appearance.fonts.large
							color: Appearance.colors.withAlpha(Appearance.colors.surface, 0.3)
							antialiasing: true
							font.bold: true
						}

						StyledText {
							id: humidity

							text: Weather.humidityData + "%"
							font.pixelSize: Appearance.fonts.large
							color: Appearance.colors.withAlpha(Appearance.colors.surface, 0.3)
							antialiasing: true
							font.bold: true
						}
					}
				}
			}
		}
	}
}
