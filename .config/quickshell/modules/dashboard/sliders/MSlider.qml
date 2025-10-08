import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Controls

import qs.services
import qs.config

Slider {
	id: slider
	property int rWidth: 300
	property int rHeight: 30
	property int minIndicator: 25
	property string iconCode: "bedtime"

	property bool isEnabled: true
	property bool isHovered: false

	height: rHeight
	width: rWidth

	Behavior on height {
		PropertyAnimation {
			duration: Config.settings.animationSpeed
			easing.type: Easing.InSine
		}
	}

	background: Item {
		width: parent.rWidth
		height: parent.height
				
		Rectangle {
			id: bgRec
			height: parent.height / 5
            width: ((1 - (slider.value / slider.to)) * parent.parent.width) - 5
            anchors.top: parent.top
            anchors.topMargin: (parent.height / 2) - (height / 2)
			anchors.right: parent.right
			radius: Config.settings.borderRadius

			color: slider.isHovered ? Colours.palette.surface_container_high : Qt.alpha(Colours.palette.surface_container, 0.8)

			Behavior on color {
				PropertyAnimation {
					duration: Config.settings.animationSpeed
					easing.type: Easing.InSine
				}
			}
		}
				
		Rectangle {
			anchors.top: parent.top
			anchors.bottom: parent.bottom
			anchors.left: parent.left

			implicitWidth: Math.max((slider.value / slider.to) * parent.parent.width, minIndicator)
	    	color: {
				if (slider.isEnabled) {
					if (slider.isHovered)
						return Colours.palette.primary
					else
						return Qt.alpha(Colours.palette.primary, 0.8)
				} else {
					return Colours.palette.surface_container
				}
			}
            radius: slider.isHovered ? Config.settings.borderRadius : Config.settings.borderRadius - 5

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
				anchors.left: parent.left
				anchors.leftMargin: 3

				anchors.top: parent.top
				anchors.topMargin: 3

				text: iconCode
				font.family: Config.settings.iconFont
				color: slider.isEnabled ? Colours.palette.on_primary : Qt.alpha(Colours.palette.on_surface, 0.5)
				font.pixelSize: 20

				Behavior on color {
					PropertyAnimation {
						duration: Config.settings.animationSpeed
						easing.type: Easing.InSine
					}
				}

				Behavior on anchors.topMargin {
					PropertyAnimation {
						duration: Config.settings.animationSpeed
						easing.type: Easing.InSine
					}
				}
			}
		}

		MouseArea {
			anchors.fill: parent
			hoverEnabled: true
			cursorShape: Qt.PointingHandCursor

			onEntered: slider.isHovered = true
			onExited: slider.isHovered = false
		}
	}

    from: 0
	value: 10
	//to: 100
			
	handle: Item {}
}