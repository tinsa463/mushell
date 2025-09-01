import QtQuick
import QtQuick.Layouts
import qs.Widgets

Item {
	RowLayout {
		anchors.centerIn: parent
		spacing: 8
		
		Clock {
			Layout.alignment: Qt.AlignCenter
		}
	}
}
