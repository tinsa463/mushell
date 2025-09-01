//@ pragma UseQApplication
import qs.Modules.Lock
import qs.Modules.Bar

import QtQuick
import Quickshell

ShellRoot {
	Bar {}
	Lock {}

	Connections {
		function onReloadCompleted() {
			Quickshell.inhibitReloadPopup();
		}

		function onReloadFailed() {
			Quickshell.inhibitReloadPopup();
		}

		target: Quickshell
	}
}
