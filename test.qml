import QtQuick
import Quickshell

ShellRoot {
	Pam {
		id: lockcontext
		onUnlocked: Qt.quit();
	}

	FloatingWindow {
		LockSurface {
			anchors.fill: parent 
			context: lockcontext
		}
	}

	Connections {
		target: Quickshell

		function onLastWindowClosed() {
			Qt.quit();
		}
	}

}
