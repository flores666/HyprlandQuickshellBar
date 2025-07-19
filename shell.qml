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
				height: parent.height
				anchors { 
					right: right.left
					left: left.right
					top: parent.top
				}

				Rectangle {
					anchors.centerIn: center 
					height: parent.height

					CpuLoadWidget {
						id: cpuLoadWidget
						width: 54
						height: parent.height
						anchors.verticalCenter: parent.verticalCenter
						anchors.right: workspaces.left
					}

					WorkspacesWidget {
						id: workspaces
						width: 244
						height: parent.height
						anchors.horizontalCenter: parent.horizontalCenter
					}

					ClockWidget {
						id: clockWidget
						width: 140
						height: parent.height
						anchors.verticalCenter: parent.verticalCenter
						anchors.left: workspaces.right
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


