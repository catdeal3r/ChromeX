pragma Singleton

import Quickshell
import Quickshell.Io

import QtQuick
import qs.config
import qs.services

Singleton {
	id: root
	property int settingsLocation: 0 
	
	function setLocation(loc) {
        root.settingsLocation = loc;
    }
}
