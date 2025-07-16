pragma Singleton
import Quickshell.Io
import QtQuick
import Quickshell
import "utils.js" as Utils

Singleton {
    id: clockManager
    property string currentTime: ""

    Process {
        id: dateProc
        command: ["date"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                clockManager.currentTime = Utils.formatDateTime(this.text)
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: dateProc.running = true
    }
}

