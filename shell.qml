import Quickshell
import QtQuick
import "widgets/clock"
import "widgets/cpuload"
import "widgets/workspaces"
import "globals"

Variants {
	model: Quickshell.screens;

	delegate: Component {
		PanelWindow {
			property var modelData
			screen: modelData

			anchors {
				top: true
				left: true
				right: true
			}

			implicitHeight: Globals.height

			Rectangle {
				id: left
				color: Globals.mainColor
				anchors { 
					left: parent.left
					top: parent.top
				}

				width: Screen.width * Globals.widthCoef
				height: parent.height
			}

			Rectangle {
				id: center
				color: Globals.mainColor
				anchors { 
					right: right.right
					left: left.right
					top: parent.top
				}

				height: parent.height
				CpuLoadWidget {
					id: cpuLoadWidget
					width: 50
					anchors {
						left: parent.left
						verticalCenter: parent.verticalCenter
					}
				}

				WorkspacesWidget {
					id: workspaces
					width: 300
					anchors {
						left: cpuLoadWidget.right
						verticalCenter: parent.verticalCenter
					}
				}

				ClockWidget {
					id: clockWidget
					width: 100
					anchors {
						left: workspaces.right
						verticalCenter: parent.verticalCenter
					}
				}

			}

			Rectangle {
				id: right
				color: Globals.mainColor
				anchors { 
					right: parent.right
					top: parent.top
				}

				width: Screen.width * Globals.widthCoef
				height: parent.height
			}
		}
	}
}


