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
        console.log("capture_data.mp4")
    }

    function stopRecording() {
        root.isRecording = false
    }

    Process {
        id: isRecordingRunningProc
        running: false
        command: [ "pgrep", "wf-recorder" ]
        stdout: SplitParser {
			onRead: data => {
                if (data != "")
                    isRecordingRunning = true
                else
                    isRecordingRunning = false
            }
		}
    }

    Timer {
        interval: 500
	    running: true
	    repeat: true
	    onTriggered: isRecordingRunningProc.running = true
    }

    Process {
        running: isRecording
        command: [ "date", "+%Y-%m-%d-%H-%M-%S" ]
        stdout: SplitParser {
            onRead: data => console.log("capture_${data}.mp4")//output_file = `capture_${data}.mp4`
        }
    }
}
