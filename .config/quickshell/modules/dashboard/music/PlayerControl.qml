import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets

import qs.config
import qs.modules.common

Rectangle {
	id: root
	property bool isHovered: false
	property var toRun
	property string iconName
	width: 35
	height: 35
	
	property string bgColour: Colours.palette.surface
	property string colour: Colours.palette.on_surface
	
	property string bgColourHovered: Colours.palette.surface_container_high
	property string colourHovered: Colours.palette.on_surface
	
	color: isHovered ? root.bgColourHovered : root.bgColour
	radius: isHovered ? Config.settings.borderRadius : Config.settings.borderRadius - 5

    Behavior on color {
		PropertyAnimation {
			duration: Config.settings.animationSpeed
			easing.type: Easing.InSine
		}
	}

    Behavior on radius {
		PropertyAnimation {
			duration: Config.settings.animationSpeed
			easing.type: Easing.InSine
		}
	}
	
	Text {
		id: icon
		anchors.centerIn: parent
		font.pixelSize: 20
		color: root.isHovered ? root.colourHovered : root.colour
		text: root.iconName
		font.family: Config.settings.iconFont

        Behavior on color {
			PropertyAnimation {
				duration: Config.settings.animationSpeed
				easing.type: Easing.InSine
			}
		}
	}
	
	MouseArea {
		anchors.fill: parent
		hoverEnabled: true
		cursorShape: Qt.PointingHandCursor
		
		onEntered: root.isHovered = true
		onExited: root.isHovered = false
		onClicked: root.toRun();
	}
}
