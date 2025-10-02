//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma UseQApplication

import Quickshell
import Quickshell.Io

import QtQuick
import qs.modules
import qs.services
import qs.config

Scope {
	Modules {}
	
	Component.onCompleted: {
		Notifications.dummyInit();
		if (Config.settings.nightmodeOnStartup)
			Nightmode.turnOn();
	}

	//Desktop {}
	
	EyeProtection {}
}
