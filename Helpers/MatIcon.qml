import qs.Data
import QtQuick

Text {
	id: root

	property real targetFill: 0
	property real fill: 0
	property int grad: 0
	required property string icon

	font.family: Appearance.fonts.family_Material
	font.hintingPreference: Font.PreferNoHinting
	layer.enabled: true

	onTargetFillChanged: updateTimer.restart()

	Timer {
		id: updateTimer
		interval: 16
		onTriggered: root.fill = root.targetFill
	}

	font.variableAxes: {
		"opsz": root.fontInfo.pixelSize,
		"wght": root.fontInfo.weight
	}

	renderType: Text.QtRendering
	text: root.icon

	Behavior on fill {
		NumberAnimation {
			duration: Appearance.animations.durations.small
			easing.type: Easing.BezierSpline
			easing.bezierCurve: Appearance.animations.curves.standard
		}
	}
}
