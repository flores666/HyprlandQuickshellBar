import QtQuick
import Quickshell
import Quickshell.Widgets
import "../../globals"
import Quickshell.Io

Rectangle {
	id: volumeWidget
	height: parent.height
	width: parent.width * 0.1
	color: Globals.mainColor
	IconImage {
		id: image
		//visible: false
		source: Qt.resolvedUrl("icons/volume.svg")
		width: 21
		height: 21
		anchors.centerIn: parent
	}
	property int currentVolume: 0

	Process {
		id: getCurrentVolume
		command: ["sh", "-c", "pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\\d+(?=%)' | head -1"]
		running: true

		stdout: StdioCollector {
			onStreamFinished: {
				currentVolume = parseInt(this.text)
			}
		}
	}

	Process {
		id: volumePlusProccess 
		command: ["pactl", "set-sink-volume", "@DEFAULT_SINK@", "+5%"]
		running: false
	}

	Process {
		id: volumeMinusProccess
		command: ["pactl", "set-sink-volume", "@DEFAULT_SINK@", "-5%"]
		running: false
	}

	MouseArea {
		anchors.fill: parent
		cursorShape: Qt.PointingHandCursor
		hoverEnabled: true
		/*onEntered: {
			 image.visible = true
		 }
		 onExited: {
			 image.visible = false
		 }*/
		 onWheel: event => {
			 var up = event.angleDelta.y > 0;
			 if (up && volumeWidget.currentVolume < 100) volumePlusProccess.running = true
			 if (!up && volumeWidget.currentVolume >= 0) volumeMinusProccess.running = true;
			 getCurrentVolume.running = true;
		 }
	 }}
