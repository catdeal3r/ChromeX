 
pragma Singleton
 
import Quickshell
import Quickshell.Io
import QtQuick
 
Singleton {
	id: root
	property string time
 
    Process {
		id: dateProc

		command: [ "date", "+%I%n%M" ]
		running: true

		stdout: SplitParser {
			onRead: data => root.time = `${data}`
			splitMarker: ""
		}
	}

    Timer {
	    interval: 1000
	    running: true
	    repeat: true
	    onTriggered: dateProc.running = true
	}
}
