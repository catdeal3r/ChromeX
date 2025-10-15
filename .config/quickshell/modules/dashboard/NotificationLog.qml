import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets

import qs.config
import qs.modules.common
import qs.services

Rectangle {
	id: root
	
	anchors.fill: parent
			
	radius: Config.settings.borderRadius
	color: Colours.palette.surface
	
	property int notificationCount: Notifications.list.length

	clip: true
	
	ColumnLayout {
		anchors.fill: parent
		
		RowLayout {
			Layout.topMargin: 15
			
			Text {
				color: Colours.palette.on_surface
				text: "Notifications"
				font.family: Config.settings.font
				font.pixelSize: 15
				
				Layout.preferredWidth: 370
				Layout.leftMargin: 25
			}
		
			Rectangle {
                id: clearBtn
                property bool isHovered: false
				width: 90
				height: 35
				
				radius: isHovered ? Config.settings.borderRadius - 5 : Config.settings.borderRadius
				color: isHovered ? Colours.palette.primary : Colours.palette.surface_container
				
				Layout.alignment: Qt.AlignTop | Qt.AlignRight
				
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
				
				RowLayout {
					anchors.centerIn: parent
					
					Text {
						color: clearBtn.isHovered ? Colours.palette.on_primary : Colours.palette.on_surface
						text: "clear_all"
						font.family: Config.settings.iconFont
						font.pixelSize: 20

                        Behavior on color {
							PropertyAnimation {
							    duration: Config.settings.animationSpeed
								easing.type: Easing.InSine
							}
						}
					}
				
					Text {
						color: clearBtn.isHovered ? Colours.palette.on_primary : Colours.palette.on_surface
						text: "Clear"
						font.family: Config.settings.font
						font.pixelSize: 14

                        Behavior on color {
							PropertyAnimation {
							    duration: Config.settings.animationSpeed
								easing.type: Easing.InSine
							}
						}
					}
				}
				
				MouseArea {
					anchors.fill: parent
					
					cursorShape: Qt.PointingHandCursor
											
					hoverEnabled: true
										
					onClicked: Notifications.discardAllNotifications()
					onEntered: parent.isHovered = true
					onExited: parent.isHovered = false
				}
			}
		}

		ScrollView {
			implicitHeight: root.height - 100
			implicitWidth: 400

			Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
			Layout.topMargin: 10

			ListView {
				id: notifList

				implicitHeight: parent.implicitHeight
				implicitWidth: parent.implicitWidth

				model: ScriptModel {
					values: [...Notifications.list].reverse()
				}

				clip: true
						
				spacing: 20
						
				add: Transition {
					NumberAnimation {
						duration: 500
						easing.bezierCurve: Anim.standard
						from: 400
						property: "x"
					}
				}
				
				addDisplaced: Transition {
					NumberAnimation {
						duration: 500
						easing.bezierCurve: Anim.standard
						properties: "x,y"
					}
				}
								
				delegate: SingleNotification {
					required property Notifications.Notif modelData
				}
								
				remove: Transition {
					NumberAnimation {
						duration: 500
						easing.bezierCurve: Anim.standard
						property: "x"
						to: 400
					}
				}
				
				removeDisplaced: Transition {
					NumberAnimation {
						duration: 500
						easing.bezierCurve: Anim.standard
						properties: "x,y"
					}
				}
			}
		}
		
		
	}

    Rectangle {
		height: root.height - 50
		width: 120
		anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: (parent.width / 2) - (width / 2)

		color: "transparent"

        opacity: (root.notificationCount > 0) ? 0 : 1

        Behavior on opacity {
			PropertyAnimation {
				duration: Config.settings.animationSpeed
				easing.type: Easing.InSine
			}
		}
		
		Text {
			anchors.centerIn: parent
			text: "No notifications."
			font.pixelSize: 20
			font.family: Config.settings.font
				
			visible: parent.visible
					
			color: Qt.alpha(Colours.palette.on_surface, 0.7)
        }
	}
}
