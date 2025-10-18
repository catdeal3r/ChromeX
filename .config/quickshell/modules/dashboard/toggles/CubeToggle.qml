import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets

import qs.config

Rectangle {
	id: root
	
	property bool isHovered: false
	property bool isToggled: false

    property int rWidth
    property int rHeight
	
	property var toRun

	property string bgColour: Colours.palette.primary
	property string colour: Colours.palette.on_primary
	
	property string bgColourHovered: Colours.palette.primary
	property string colourHovered: Colours.palette.on_primary
	
	property string bgColourUntoggled: Colours.palette.surface_container
	property string colourUntoggled: Colours.palette.on_surface_variant
	
	property string bgColourHoveredUntoggled: Colours.palette.primary_container
	property string colourHoveredUntoggled: Colours.palette.on_primary_container
	
	property string bigText: "Placeholder"

    property int bigTextSize: 14

	property string iconCode: "settings"
	property real iconSize: 25


	Layout.preferredWidth: isHovered ? rWidth + 10 : rWidth
	Layout.preferredHeight: rHeight

    Behavior on Layout.preferredWidth {
		PropertyAnimation {
			duration: Config.settings.animationSpeed
			easing.type: Easing.InSine
		}
	}
	
	function getColourBg() {
		if (root.isToggled) {
			if (root.isHovered) {
				return root.bgColourHovered
			}
			return root.bgColour
		}
		if (root.isHovered) {
			return root.bgColourHoveredUntoggled
		}
		return root.bgColourUntoggled
	}
	
	function getColour() {
		if (root.isToggled) {
			if (root.isHovered) {
				return root.colourHovered
			}
			return root.colour
		}
		if (root.isHovered) {
			return root.colourHoveredUntoggled
		}
		return root.colourUntoggled
	}

    function getRadius() {
        if (root.isHovered) 
            return Config.settings.borderRadius + 12
        if (root.isToggled)
            return Config.settings.borderRadius + 10
        else
            return Config.settings.borderRadius
    }
	
	color: getColourBg()
	
	Behavior on color {
		PropertyAnimation {
			duration: Config.settings.animationSpeed
			easing.type: Easing.InSine
		}
	}
	
	radius: getRadius()

    Behavior on radius {
		PropertyAnimation {
			duration: Config.settings.animationSpeed
			easing.type: Easing.InSine
		}
	}
	
	ColumnLayout {
		anchors.centerIn: parent
        width: root.rWidth - 10
        height: root.rHeight - 10
		spacing: 0
		
		Rectangle {
			Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
			Layout.topMargin: 15
			
			Layout.preferredWidth: root.rWidth / 10
			Layout.preferredHeight: root.rHeight / 10
			color: "transparent"
		
			Text {
				anchors.centerIn: parent
				
				text: iconCode
				font.family: Config.settings.iconFont
				
				font.pixelSize: root.iconSize
				font.weight: 500
				color: root.getColour()
				
				Behavior on color {
					PropertyAnimation {
						duration: Config.settings.animationSpeed
						easing.type: Easing.InSine
					}
				}
			}
		}
		
		Rectangle {
			Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
			Layout.topMargin: 10
			
			Layout.preferredWidth: root.rWidth * 0.6
			Layout.preferredHeight: root.rHeight / 4
			color: "transparent"
			
			Text {
				anchors.centerIn: parent
				
				text: bigText
				font.family: Config.settings.font
			
				font.pixelSize: bigTextSize
				font.weight: 500
                //wrapMode: Text.Wrap
				
				color: root.getColour()
				
				Behavior on color {
					PropertyAnimation {
						duration: Config.settings.animationSpeed
						easing.type: Easing.InSine
					}
				}
			}
		}
	}
	
	MouseArea {
		anchors.fill: parent
		hoverEnabled: true
		
		cursorShape: Qt.PointingHandCursor
		
		onEntered: parent.isHovered = true
		onExited: parent.isHovered = false
		onClicked: parent.toRun()
	}
}