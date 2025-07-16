pragma Singleton
import Quickshell.Io
import Quickshell
import QtQuick

Singleton {
    id: cpuLoad
    property string currentLoad: ""

    Process {
        id: loadProc
		command: ["sh", "-c", "top -bn1 | grep '^%Cpu' | awk '{print 100 - $8}'"]
		running: true

        stdout: StdioCollector {
            onStreamFinished: {
				cpuLoad.currentLoad = parseFloat(this.text.trim()) + "%"
            }
        }
    }

    Timer {
        interval: 3000
        running: true
        repeat: true
        onTriggered: loadProc.running = true
    }
}

