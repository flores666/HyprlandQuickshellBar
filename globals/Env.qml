pragma Singleton
import QtQuick 2.15

QtObject {
	readonly property QtObject colors: QtObject {
		readonly property color primary: "#000807";
		readonly property color secondary: "#d2c0ea";
	}

	readonly property QtObject sizes: QtObject {
		readonly property real aspectRatio: Screen.width / Screen.height;
		readonly property real barHeight: Screen.height * 0.025;
		readonly property real barWidthCoef: 0.25;
	}
}
