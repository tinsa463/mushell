pragma Singleton

import Quickshell
import QtQuick

Singleton {
	id: root

	readonly property QtObject colors: QtObject {
		readonly property color background: "#171216"
		readonly property color error: "#ffb4ab"
		readonly property color error_container: "#93000a"
		readonly property color inverse_on_surface: "#352e34"
		readonly property color inverse_primary: "#7d4e7d"
		readonly property color inverse_surface: "#ebdfe6"
		readonly property color on_background: "#ebdfe6"
		readonly property color on_error: "#690005"
		readonly property color on_error_container: "#ffdad6"
		readonly property color on_primary: "#4a204c"
		readonly property color on_primary_container: "#ffd6f9"
		readonly property color on_primary_fixed: "#320935"
		readonly property color on_primary_fixed_variant: "#633664"
		readonly property color on_secondary: "#3c2b3b"
		readonly property color on_secondary_container: "#f6dbf0"
		readonly property color on_secondary_fixed: "#261625"
		readonly property color on_secondary_fixed_variant: "#544152"
		readonly property color on_surface: "#ebdfe6"
		readonly property color on_surface_variant: "#d0c3cc"
		readonly property color on_tertiary: "#4c261d"
		readonly property color on_tertiary_container: "#ffdad3"
		readonly property color on_tertiary_fixed: "#33110a"
		readonly property color on_tertiary_fixed_variant: "#663b32"
		readonly property color outline: "#998d96"
		readonly property color outline_variant: "#4d444b"
		readonly property color primary: "#eeb4ea"
		readonly property color primary_container: "#633664"
		readonly property color primary_fixed: "#ffd6f9"
		readonly property color primary_fixed_dim: "#eeb4ea"
		readonly property color scrim: "#000000"
		readonly property color secondary: "#d9bfd4"
		readonly property color secondary_container: "#544152"
		readonly property color secondary_fixed: "#f6dbf0"
		readonly property color secondary_fixed_dim: "#d9bfd4"
		readonly property color shadow: "#000000"
		readonly property color surface: "#171216"
		readonly property color surface_bright: "#3e373c"
		readonly property color surface_container: "#241e23"
		readonly property color surface_container_high: "#2e282d"
		readonly property color surface_container_highest: "#393338"
		readonly property color surface_container_low: "#1f1a1f"
		readonly property color surface_container_lowest: "#120d11"
		readonly property color surface_dim: "#171216"
		readonly property color surface_tint: "#eeb4ea"
		readonly property color surface_variant: "#4d444b"
		readonly property color tertiary: "#f6b8aa"
		readonly property color tertiary_container: "#663b32"
		readonly property color tertiary_fixed: "#ffdad3"
		readonly property color tertiary_fixed_dim: "#f6b8aa"

		function withAlpha(color, alpha) {
			return Qt.rgba(color.r, color.g, color.b, alpha);
		}
	}

	// Fonts
	readonly property QtObject fonts: QtObject {
		readonly property string family_Clock: "14 SegmentLED"
		readonly property string family_Material: "Material Symbols Rounded"
		readonly property string family_Mono: "Hack"
		readonly property string family_Sans: "Rubik"

		readonly property real fontScale: 1.0

		readonly property real small: 11 * fontScale
		readonly property real medium: 12 * fontScale
		readonly property real normal: 13 * fontScale
		readonly property real large: 15 * fontScale
		readonly property real larger: 17 * fontScale
		readonly property real extraLarge: 28 * fontScale
	}

	// Animations
	readonly property QtObject animations: QtObject {
		readonly property QtObject curves: QtObject {
			readonly property list<real> emphasized: [0.05, 0, 2 / 15, 0.06, 1 / 6, 0.4, 5 / 24, 0.82, 0.25, 1, 1, 1]
			readonly property list<real> emphasizedAccel: [0.3, 0, 0.8, 0.15, 1, 1]
			readonly property list<real> emphasizedDecel: [0.05, 0.7, 0.1, 1, 1, 1]
			readonly property list<real> expressiveDefaultSpatial: [0.38, 1.21, 0.22, 1, 1, 1]
			readonly property list<real> expressiveEffects: [0.34, 0.8, 0.34, 1, 1, 1]
			readonly property list<real> expressiveFastSpatial: [0.42, 1.67, 0.21, 0.9, 1, 1]
			readonly property list<real> standard: [0.2, 0, 0, 1, 1, 1]
			readonly property list<real> standardAccel: [0.3, 0, 1, 1, 1, 1]
			readonly property list<real> standardDecel: [0, 0, 0, 1, 1, 1]
		}

		readonly property QtObject durations: QtObject {
			property real scale: 1.0
			property int expressiveDefaultSpatial: 500 * scale
			property int expressiveEffects: 200 * scale
			property int expressiveFastSpatial: 350 * scale
			property int extraLarge: 1000 * scale
			property int large: 600 * scale
			property int normal: 400 * scale
			property int small: 200 * scale
		}
	}

	readonly property QtObject rounding: QtObject {
		property real scale: 1
		property int small: 12 * scale
		property int normal: 17 * scale
		property int large: 25 * scale
		property int full: 1000 * scale
	}

	readonly property QtObject spacing: QtObject {
		property real scale: 1
		property int small: 7 * scale
		property int smaller: 10 * scale
		property int normal: 12 * scale
		property int larger: 15 * scale
		property int large: 20 * scale
	}

	readonly property QtObject padding: QtObject {
		property real scale: 1
		property int small: 5 * scale
		property int smaller: 7 * scale
		property int normal: 10 * scale
		property int larger: 12 * scale
		property int large: 15 * scale
	}
}
