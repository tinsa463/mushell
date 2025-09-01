import QtQuick
import QtQuick.Layouts

import qs.Data
import qs.Helpers

Rectangle {
	property int padding: 16

	Layout.fillHeight: true
	color: Appearance.colors.withAlpha(Appearance.colors.background, 0.79)
	implicitWidth: timeContainer.width + padding
	radius: 5

	Dots {
		id: timeContainer

		icon {
			id: icon

			color: Appearance.colors.on_background
			text: "schedule"
		}

		text {
			id: text

			color: Appearance.colors.on_background
			font.pointSize: 11
			text: Qt.formatDateTime(Time?.date, "h:mm:ss AP")
		}
	}
}
