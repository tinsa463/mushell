import QtQuick
import QtQuick.Layouts
import qs.Widgets

Item {
	RowLayout {
		anchors.fill: parent
		anchors.leftMargin: 8
		spacing: 8
		
		OsText {
			Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
		}
		Workspaces {
			Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
		}
		WorkspaceName {
			Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
		}
		
		// Spacer untuk mendorong konten ke kiri
		Item {
			Layout.fillWidth: true
		}
	}
}
