import QtQuick
import Quickshell
import Quickshell.Widgets
import "../../globals"
import Quickshell.Services.Pipewire

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

	property bool ready: Pipewire.defaultAudioSink?.ready ?? false
	property PwNode sink: Pipewire.defaultAudioSink
	property PwNode source: Pipewire.defaultAudioSource

	// bounding objects, without this will not work
	PwObjectTracker {
		objects: [sink, source]
	}

	Component.onCompleted: {
		if (sink.ready && (isNaN(sink.audio.volume) || sink.audio.volume === undefined || sink.audio.volume === null)) {
			sink.audio.volume = 0;
		}
	}

	// just in case
	function preventWrongAudioValues() : void {
		let currentVolume = sink.audio.volume;
		if (currentVolume > 1) sink.audio.volume = 1;
		if (currentVolume < 0) sink.audio.volume = 0;
	}

	// update icon
	function resolveImageSource() : void {
		let offSorce = Qt.resolvedUrl("icons/volume_off.svg");
		let downSorce = Qt.resolvedUrl("icons/volume_down.svg");
		let upSorce = Qt.resolvedUrl("icons/volume.svg");
		let currentVolume = sink.audio.volume;

		if (sink.audio.muted) image.source = offSorce;
		else {
			if (currentVolume < 0.5) image.source = downSorce;
			if (currentVolume == 0) image.source = offSorce;
			if (currentVolume > 0.5) image.source = upSorce;
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
			 sink.audio.muted = !sink.audio.muted;
			 resolveImageSource();
		 }
		 onWheel: event => {
			 if (!sink.audio.muted) {
				 var up = event.angleDelta.y > 0;
				 if (up && sink.audio.volume < 1) sink.audio.volume += 0.05;
				 if (!up && sink.audio.volume >= 0) sink.audio.volume -= 0.05;

				 preventWrongAudioValues();
				 resolveImageSource();
			 }
		 }
	 }
 }

