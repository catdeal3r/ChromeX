import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets

import "root:/config"
import "root:/modules/common"

Rectangle {
	id: root
	
	property bool isHovered: false

    required property int number
    required property int selected

    property int rWidth
    property int rHeight
	
	property var toRun

	property string bgColour: "transparent"
	property string colour: Colours.palette.on_surface
	
	property string bgColourHovered: Colours.palette.surface_container
	property string colourHovered: Colours.palette.on_surface
	
	property string bigText: "Placeholder"

    property int bigTextSize: 16

	property string iconCode: "settings"
	property real iconSize: 25

	Layout.preferredWidth: rWidth
	Layout.preferredHeight: rHeight
	
	color: {
        if (root.selected == root.number)
            return "transparent"
        else if (isHovered)
            return bgColourHovered
        else
            return bgColour
    }
	
	Behavior on color {
		PropertyAnimation {
			duration: Config.settings.animationSpeed
			easing.type: Easing.InSine
		}
	}
	
	radius: isHovered ? Config.settings.borderRadius + 10 : Config.settings.borderRadius

    Behavior on radius {
		PropertyAnimation {
			duration: Config.settings.animationSpeed
			easing.type: Easing.InSine
		}
	}

	RowLayout {
		anchors.centerIn: parent
        width: root.rWidth - 10
        height: root.rHeight - 10
		spacing: 0
		
		Rectangle {
			Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
			Layout.leftMargin: 25
			
			Layout.preferredWidth: root.rWidth / 10
			Layout.preferredHeight: root.rHeight / 3
			color: "transparent"
		
			Text {
				anchors.centerIn: parent
				
				text: iconCode
				font.family: Config.settings.iconFont
				
				font.pixelSize: root.iconSize
				font.weight: 500
				color: {
                    if (root.selected == root.number)
                        return Colours.palette.on_primary
                    else if (root.isHovered)
                        return root.colourHovered
                    else
                        return root.colour
                }
				
				Behavior on color {
					PropertyAnimation {
						duration: Config.settings.animationSpeed
						easing.type: Easing.InSine
					}
				}
			}
		}
		
		Rectangle {
			Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
			Layout.leftMargin: 15
			
			Layout.preferredWidth: root.rWidth * 0.7
			Layout.preferredHeight: root.rHeight / 1.5
			color: "transparent"

			TextMetrics {
				id: bigTextMetrics
				text: bigText
                font.family: Config.settings.font
                elideWidth: rWidth - 130
                elide: Text.ElideRight
			}
			
			Text {
				anchors.left: parent.left
				anchors.top: parent.top
				
				anchors.topMargin: parent.height / 5 
				text: bigTextMetrics.elidedText
				font.family: Config.settings.font
			
				font.pixelSize: bigTextSize
				font.weight: 500
				
				color: {
                    if (root.selected == root.number)
                        return Colours.palette.on_primary
                    else if (root.isHovered)
                        return root.colourHovered
                    else
                        return root.colour
                }

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