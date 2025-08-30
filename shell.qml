import qs.Data
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

ShellRoot {
	Pam {
		id: lockContext

		lock: lock
	}

	WlSessionLock {
		id: lock

		locked: true

		signal unlocked

		LockSurface {
			id: surface

			lock: lock

			context: lockContext
		}
	}

	IpcHandler {
		target: "lock"

		function lock(): void {
			lock.locked = true;
		}
		function unlock(): void {
			lock.unlocked();
		}
		function isLocked(): void {
			return lock.locked;
		}
	}
}
