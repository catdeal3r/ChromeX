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

Scope {
	NotificationList {}
	
	Loader {
		active: IPCLoader.isBarOpen
		
		sourceComponent: Bar {
			onFinished: IPCLoader.toggleBar()
		}
	}

	Dashboard {
		isDashboardOpen: IPCLoader.isDashboardOpen
	}

	Launcher {
		isLauncherOpen: IPCLoader.isLauncherOpen
	}
	
	Lockscreen {}

	//Desktop {}
}
