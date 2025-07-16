import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Io
import "../../globals"

Rectangle {
	id: root
	width: parent.width * 0.3
	height: parent.height
	color: Globals.mainColor

	Text {
		id: workspaceLabel
		anchors.centerIn: parent
		color: "white"
		text: "Раб. стол: ..."
	}
}

