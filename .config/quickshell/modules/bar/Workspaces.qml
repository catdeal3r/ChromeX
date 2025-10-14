
pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

import qs.config

Singleton {
	id: root
	property var niriWorkspaces

	Process {
		id: workspaceNiri
		running: true

		command: [ "niri", "msg", "--json", "workspaces" ];

		stdout: SplitParser {
			onRead: data => {
				let workspaceData = JSON.parse(data)

				workspaceData.sort((a, b) => {
                    if (a.output !== b.output) {
                        return a.output.localeCompare(b.output)
                    }
                    return a.idx - b.idx
                })
				niriWorkspaces = workspaceData
			}
		}
	}

	Timer {
		running: true
		interval: 100
		repeat: true
		onTriggered: {
			workspaceNiri.running = true
		}
	}
}
