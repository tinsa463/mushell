import QtQuick
import QtQuick.Layouts

import qs.Data
import qs.Components

Rectangle {
	id: root

	readonly property int diskProp: SysUsage.diskUsed / 1048576
	readonly property int ramProp: SysUsage.memUsed / 1048576

	anchors.centerIn: parent
	radius: Appearance.rounding.normal
	color: Appearance.colors.withAlpha(Appearance.colors.surface, 0.7)
	border.color: Appearance.colors.outline
	border.width: 2

	GridLayout {
		anchors.centerIn: parent
		columns: 3

		Item {
			id: ramItem

			Layout.alignment: Qt.AlignCenter
			Layout.preferredWidth: childrenRect.width
			Layout.preferredHeight: childrenRect.height

			ColumnLayout {
				anchors.centerIn: parent
				spacing: Appearance.spacing.normal

				Circular {
					id: ram

					value: Math.round(SysUsage.memUsed / SysUsage.memTotal * 100)
					size: 0
					text: value + "%"
				}

				StyledText {
					id: ramText

					Layout.alignment: Qt.AlignHCenter
					text: "RAM usage" + "\n" + root.ramProp + " GB"
					color: Appearance.colors.on_surface
				}
			}
		}

		Item {
			id: cpuItem

			Layout.alignment: Qt.AlignVCenter
			Layout.preferredWidth: childrenRect.width
			Layout.preferredHeight: childrenRect.height

			ColumnLayout {
				anchors.centerIn: parent
				spacing: Appearance.spacing.normal

				Circular {
					id: cpu

					Layout.alignment: Qt.AlignHCenter
					value: SysUsage.cpuPerc
					size: 40
					text: value + "%"
				}

				StyledText {
					id: cpuText

					Layout.alignment: Qt.AlignHCenter
					text: "CPU usage"
					color: Appearance.colors.on_surface
				}
			}
		}

		Item {
			id: diskItem

			Layout.alignment: Qt.AlignCenter
			Layout.preferredWidth: childrenRect.width
			Layout.preferredHeight: childrenRect.height

			ColumnLayout {
				anchors.centerIn: parent
				spacing: Appearance.spacing.normal

				Circular {
					id: disk

					value: Math.round(SysUsage.diskUsed / SysUsage.diskTotal * 100)
					text: value + "%"
					size: 0
				}

				StyledText {
					id: diskText

					Layout.alignment: Qt.AlignHCenter
					text: "Disk usage" + "\n" + root.diskProp + " GB"
					color: Appearance.colors.on_surface
				}
			}
		}

		Item {
			id: networkItem

			Layout.alignment: Qt.AlignLeft
			Layout.preferredWidth: childrenRect.width
			Layout.preferredHeight: childrenRect.height

			RowLayout {
				anchors.left: parent.left
				spacing: Appearance.spacing.normal
			}
		}
	}
}
