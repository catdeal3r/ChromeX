pragma Singleton

import Quickshell
import Quickshell.Io

import QtQuick
import QtMultimedia

import qs.config

Singleton {
	id: root
    property bool isNightmodeOn: false

    function turnOn() {
        Quickshell.execDetached([ "gammastep", "-O", `${Config.settings.nightmodeColourTemp}` ]);
    }

    function turnOff() {
        Quickshell.execDetached([ "pkill", "gammastep" ]);
    }

    function toggle() {
        if (isNightmodeOn)
            turnOff();
        else
            turnOn();
    }

    Process {
        id: isNightmodeRunningProc
        running: false
        command: [ "pgrep", "gammastep" ]

        onExited: (exitCode) => {
            if (exitCode != 0)
                isNightmodeOn = false;
            else
                isNightmodeOn = true;
        }
    }

    Timer {
        interval: 500
	    running: true
	    repeat: true
	    onTriggered: isNightmodeRunningProc.running = true
    }
}
