import Quickshell
import Quickshell.Io

import QtQuick
import qs.config

import qs.modules

import qs.modules.bar
import qs.modules.launcher
import qs.modules.lockscreen
import qs.modules.notificationslist
import qs.modules.desktop
import qs.modules.dashboard
import qs.modules.dock
import qs.modules.settings

Scope {
	NotificationList {}
	
	Loader {
		active: IPCLoader.isBarOpen
		
		sourceComponent: Bar {
			onFinished: IPCLoader.toggleBar()
		}
	}

	Loader {
		active: IPCLoader.isDockOpen
		
		sourceComponent: Dock {
			onFinished: IPCLoader.toggleDock()
		}
	}

	Dashboard {
		isDashboardOpen: IPCLoader.isDashboardOpen
	}

	Launcher {
		isLauncherOpen: IPCLoader.isLauncherOpen
	}
	
	Lockscreen {}

	Desktop {}

	SettingsWindow {
		isSettingsWindowOpen: IPCLoader.isSettingsOpen
	}
}
