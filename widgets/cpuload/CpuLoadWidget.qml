import QtQuick
import Quickshell.Io
import "../../globals"

Rectangle {
	width: parent.width * 0.1
	height: parent.height
	color: Globals.mainColor

	Text {
		id: clock
		anchors.centerIn: parent
		color: "white"
		text: CpuLoad.currentLoad
	}
}
