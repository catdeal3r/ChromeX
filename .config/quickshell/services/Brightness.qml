pragma Singleton

import Quickshell
import Quickshell.Io

import QtQuick

import qs.config

Singleton {
	id: root
    property int brightnessPercent: 10
    property int maxBrightness: 1500

    function getBrightnessPercent(p) {
        brightnessPercent = (p / maxBrightness) * 100;
    }

    function setBrightnessPercent(p) {
        Quickshell.execDetached([ "brightnessctl", "s", `${p}%` ]);
    }

    Process {
        id: brightnessPercentProc
        running: false
        command: [ "brightnessctl", "g" ]

        stdout: SplitParser {
            onRead: data => getBrightnessPercent(data);
        }
    }

    Timer {
        interval: 150
	    running: true
	    repeat: true
	    onTriggered: brightnessPercentProc.running = true
    }

    Process {
        running: true
        command: [ "brightnessctl", "m" ]
        stdout: SplitParser {
            onRead: data => maxBrightness = data;
        }
    }
}
