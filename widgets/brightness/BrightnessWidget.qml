import QtQuick
import Quickshell
import Quickshell.Widgets
import "../../globals"
import Quickshell.Io

Rectangle {
	id: brightnessWidget
	height: parent.height
	width: parent.width * 0.1
	color: Env.colors.primary
	IconImage {
		id: image
		//visible: false
		source: Qt.resolvedUrl("icons/sun.svg")
		width: 18
		height: 18
		anchors.centerIn: parent
	}

	Process {
		id: brightPlusProccess
		command: ["brightnessctl", "set", "5%+"]
		running: false
	}

	Process {
		id: brightMinusProccess
		command: ["brightnessctl", "set", "5%-"]
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
			 if (up) brightPlusProccess.running = true
			 else brightMinusProccess.running = true;
		 }
	 }
 }
