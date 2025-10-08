pragma Singleton

import Quickshell
import Quickshell.Io

import QtQuick
import QtMultimedia

import qs.config

Singleton {
	id: root
    property bool isRecordingRunning: false
    property string outputFile: "capture_undefined.mp4"
    property string fullOutputFile: `${Config.settings.recorder.output_loc}/${root.outputFile}`

    property int seconds: 0
    property int minutes: 0
    property int hours: 0

    property string fullTime: "00:00:00"

    property int recorderExitCode: 0
    property bool readyToNotif: false

    onRecorderExitCodeChanged: {
        console.log(`${recorderExitCode}`);
        if (recorderExitCode != 0) {
            Quickshell.execDetached(["notify-send", "Failed to start recording", `Monitor ${Config.settings.recorder.screen} possibly doesn't exist.`]);
            recorderExitCode = 0;
        }
    }

    Timer {
        interval: 1000
        running: isRecordingRunning
        repeat: true
        onTriggered: {
            seconds += 1;
            if (seconds == 60)
            {
                minutes += 1;
                seconds = 0;
            }

            if (minutes == 60)
            {
                hours += 1;
                minutes = 0;
            }

            let formattedSeconds = "00";
            let formattedMinutes = "00";
            let formattedHours = "00";

            if (seconds < 10)
                formattedSeconds = `0${seconds}`;
            else
                formattedSeconds = `${seconds}`;

            
            if (minutes < 10)
                formattedMinutes = `0${minutes}`;
            else
                formattedMinutes = `${minutes}`;

            if (hours < 10)
                formattedHours = `0${hours}`;
            else
                formattedHours = `${hours}`;

            fullTime = `${formattedHours}:${formattedMinutes}:${formattedSeconds}`;
        }
    }

    function resetTime() {
        seconds = 0;
        minutes = 0;
        hours = 0;
        fullTime = "00:00:00";
    }

    Process {
        id: recorderProc
        running: false

        onExited: (exitCode) => {
            console.log(`${exitCode}`); 
            recorderExitCode = `${exitCode}`;
        }
    }

    onOutputFileChanged: {
        //console.log(isRecordingRunning);
        fullOutputFile = `${Config.settings.recorder.output_loc}/${root.outputFile}`;
        //console.log(`Output file now is ${outputFile}.\nFull output file now is ${fullOutputFile}`);

        if (isRecordingRunning != true) {
            //console.log(`\nrunning wf-recorder .... \ncommand:\nwf-recorder -o ${Config.settings.recorder.screen} -c ${Config.settings.recorder.encoder} -f ${fullOutputFile}`);
           // Quickshell.execDetached([ "wf-recorder", "-o", `${Config.settings.recorder.screen}`, "-c", `${Config.settings.recorder.encoder}`, "-f", `${fullOutputFile}` ]);
            recorderProc.command = [ "wf-recorder", "-o", `${Config.settings.recorder.screen}`, "-c", `${Config.settings.recorder.encoder}`, "-f", `${fullOutputFile}` ];
            recorderProc.running = true;
        }
    }

    function closeRecording() {
        Quickshell.execDetached([ "pkill", "wf-recorder" ]);
    }

	function startRecording() {
        resetTime();
        dateProc.running = true;
        console.log(isRecordingRunning);
    }

    function stopRecording() {
        resetTime();
        dateProc.running = false;
        closeRecording();
    }

    function toggleRecording() {
        if (isRecordingRunning == true)
            stopRecording();
        else
            startRecording();
    }

    Process {
        id: isRecordingRunningProc
        running: false
        command: [ "pgrep", "wf-recorder" ]

        onExited: (exitCode) => {
            if (exitCode != 0)
                isRecordingRunning = false;
            else
                isRecordingRunning = true;
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
            onRead: data => outputFile = `capture_${data}.mp4`
        }
    }
}
