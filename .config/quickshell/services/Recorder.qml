pragma Singleton

import Quickshell
import Quickshell.Io

import QtQuick
import QtMultimedia

import qs.config

Singleton {
	id: root
    property bool isRecording: false
    property bool isRecordingRunning: false
    property string output_file: "capture_undefined.mp4"

	function startRecording() {
        root.isRecording = true
        dateProc.running = true
        console.log(isRecordingRunning)
    }

    function stopRecording() {
        root.isRecording = false
        dateProc.running = false
    }

    Process {
        id: isRecordingRunningProc
        running: false
        command: [ "pgrep", "wf-recorder" ]

        onExited: (exitCode) => {
            if (exitCode != 0)
                isRecordingRunning = false
            else
                isRecordingRunning = true
        }
    }

    Timer {
        interval: 500
	    running: true
	    repeat: true
	    onTriggered: isRecordingRunningProc.running = true
    }

    Process {
        id: dateProc
        running: false
        command: [ "date", "+%Y-%m-%d-%H-%M-%S" ]
        stdout: SplitParser {
            onRead: data => console.log(`capture_${data}.mp4`)//output_file = `capture_${data}.mp4`
        }
    }
}
