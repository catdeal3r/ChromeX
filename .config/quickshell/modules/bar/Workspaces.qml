
pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

import qs.config

Singleton {
	id: root
	
	property int workspaceCount: 8
	property int focusedWorkspace: 1
	property string monitor: "1"

	function setMonitor(m) {
		if (m == "eDP-1")
			root.monitor = "1";
		else
			root.montior = "2";
	}
	
	function getWorkspaceColour(state) {
		if (state == "ws") return Colours.palette.outline
		if (state == "wso") return Qt.alpha(Colours.palette.on_surface, 0.8)
		return Colours.palette.on_primary
	}
	
	function getWorkspaceSize(state) {
		if (state == "ws") return 15
		if (state == "wso") return 20
		return 40
	}
	
	function getWorkspaceHeight(state) {
		return 10
	}

	Process {
		id: focusedProc
		running: true

		command: [ Quickshell.shellDir + "/scripts/python/exe.sh", "i", `${root.monitor}` ];
		
		stdout: SplitParser {
			onRead: data => focusedWorkspace = data
		}
	}

	Timer {
		running: true
		interval: 100
		repeat: true
		onTriggered: {
			focusedProc.running = true
		}
	}
}
