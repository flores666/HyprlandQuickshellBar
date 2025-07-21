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
	property bool isMuted: false

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

	Process {
		id: muteAudio
		command: ["pactl", "set-sink-mute", "@DEFAULT_SINK@", "toggle"]
		running: false
	}

	function resolveImageSource() : void {
		var offSorce = Qt.resolvedUrl("icons/volume_off.svg");
		var downSorce = Qt.resolvedUrl("icons/volume_down.svg");
		var upSorce = Qt.resolvedUrl("icons/volume.svg");

		if (volumeWidget.isMuted) image.source = offSorce;
		else {
			if (volumeWidget.currentVolume < 50) image.source = downSorce;
			if (volumeWidget.currentVolume == 0) image.source = offSorce;
			if (volumeWidget.currentVolume > 50) image.source = upSorce;
		}
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
		 onClicked: event => {
			 isMuted = !isMuted;
			 muteAudio.running = true;
			 resolveImageSource();
		 }
		 onWheel: event => {
			 if (!isMuted) {
				 var up = event.angleDelta.y > 0;
				 if (up && volumeWidget.currentVolume < 100) volumePlusProccess.running = true
				 if (!up && volumeWidget.currentVolume >= 0) volumeMinusProccess.running = true;
				 getCurrentVolume.running = true;
				 resolveImageSource();
			 }
		 }
	 }
 }

