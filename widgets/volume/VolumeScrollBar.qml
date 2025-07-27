import QtQuick.Controls
import Quickshell
import QtQuick
import Quickshell.Services.Pipewire
import "../../globals"

PanelWindow {
	id: root
	visible: false
	implicitHeight: 152
	implicitWidth: 40
	color: "transparent"

	anchors {
		right: true
		top: true
	}

	margins {
		top: 6
		right: 6
	}

	property bool ready: Pipewire.defaultAudioSink?.ready ?? false
	property PwNode sink: Pipewire.defaultAudioSink

	PwObjectTracker {
		objects: [sink]
	}

	Connections {
		target: sink?.audio
		function onVolumeChanged() {
			root.visible = true;
			visibilityHandler.restart();
		}
	}

	Rectangle {
		color: Env.colors.primary
		height: parent.height
		width: parent.width
		radius: 20

		Slider {
			id: slider
			orientation: Qt.Vertical
			stepSize: 0.05
			from: 0
			to: 1
			z: 2
			value: sink.audio.volume
			anchors.centerIn: parent
			height: 134

			handle: Rectangle {
				width: 30
				height: 11
				radius: 16
				border.color: Env.colors.primary
				border.width: 4
				y: slider.visualPosition * (slider.height - height)
				x: (slider.width - width) / 2
				color: Env.colors.secondary

				MouseArea {
					id: dragArea
					anchors.fill: parent
					drag.target: draggableRect
					drag.axis: Drag.YAxis
					drag.minimumY: 0
					drag.maximumY: 1
					onPressed: {
						slider.pressed = true;
					}
					onReleased: {
						slider.pressed = false;
					}
					onPositionChanged: event => {
						var y = event.y;
						if (y < 0 || y > slider.height) dragArea.drag.active = false;
						var value = y / slider.height;

						console.log(value);
						slider.value = 1 - value;
						slider.moved();
					}
				}
			}

			background: Rectangle {
				color: "white"
				height: parent.height
				width: 4
				radius: 20
				y: parent.topPadding + slider.availableHeight / 2 - height / 2
				x: slider.leftPadding - width / 2

				Rectangle {
					height: slider.height * slider.value - 3
					width: parent.width
					color: Env.colors.secondary
					radius: parent.radius
					anchors.bottom: parent.bottom
				}
			}

			MouseArea {
				id: sliderMouseArea
				hoverEnabled: true
				cursorShape: Qt.PointingHandCursor
				anchors.fill: slider

				onEntered: visibilityHandler.stop()
				onPositionChanged: visibilityHandler.stop()
				onPressed: mouse => mouse.accepted = false
				onWheel: event => {
					let up = event.angleDelta.y > 0;
					if (up) slider.increase();
					else slider.decrease();

					slider.moved();
				}
			}

			onMoved: event => {
				let value = slider.value;
				if (value > 0 && value < 1) sink.audio.volume = value;
			}
		}

		MouseArea {
			id: mouseArea
			anchors.fill: parent
			hoverEnabled: true
			onEntered: visibilityHandler.stop()
			onExited: visibilityHandler.restart()
			z: 1
		}
	}

	Timer {
		id: visibilityHandler
		interval: 2000
		running: false
		onTriggered: root.visible = false
	}
}

