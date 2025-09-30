import Quickshell
import Quickshell.Io
import QtQuick.Controls
import Quickshell.Widgets
import Quickshell.Services.SystemTray

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

import qs.modules
import qs.modules.bar
import qs.config
import qs.modules.common
import qs.services

Scope {
	signal finished();
	id: root

	
	Variants {
		model: Quickshell.screens;
  
		PanelWindow {
			id: barWindow
		
			property var modelData
			screen: modelData
			
			anchors {
				top: true
				bottom: true
				left: true
				right: false
			}

			color: "transparent"
			
			implicitWidth: 40
			
			visible: true
			
			exclusiveZone: 40

			mask: Region {
				item: barBase
			}

			Rectangle {
				id: barBase
				anchors.left: parent.left

				width: 40
				height: barWindow.height
				color: Colours.palette.surface

				IconImage {
					id: icon
					width: 30
					height: 30
					anchors.top: parent.top
					anchors.left: parent.left
					anchors.leftMargin: (parent.width / 2) - (width / 2) - 1
					anchors.topMargin: 5
					source: Qt.resolvedUrl(Quickshell.shellDir + "/assets/icon.png")
				}

				MultiEffect {
					source: icon
					anchors.fill: icon
					colorizationColor: Colours.palette.on_surface
					colorization: 1.0
				}

				WorkspacesWidget {
					monitor: modelData.name
				}
						
				ColumnLayout {
					spacing: 10
					anchors.left: parent.left

					width: parent.width - 5
					anchors.bottom: parent.bottom
							
					SysTray {
						Layout.preferredHeight: (SystemTray.items.values.length * 25)
						Layout.preferredWidth: 20
						Layout.leftMargin: 3.5
						Layout.alignment: Qt.AlignHCenter
						bar: barWindow
					}

					Rectangle {
						id: notificationButton
						property bool hovered: false
						property string time

						Layout.preferredHeight: 50
						Layout.preferredWidth: barBase.width - 10
						Layout.alignment: Qt.AlignHCenter
						Layout.bottomMargin: -4
						Layout.leftMargin: 3

						topLeftRadius: Config.settings.borderRadius
						topRightRadius: Config.settings.borderRadius

						bottomLeftRadius: 5
						bottomRightRadius: 5

						color: hovered ? Qt.alpha(Colours.palette.primary, 0.8) : Qt.alpha(Colours.palette.surface_container, 0.8)

						ColumnLayout {
							width: parent.width
							height: parent.height

							Text {
								color: notificationButton.hovered ? Colours.palette.on_primary : Qt.alpha(Colours.palette.on_surface, 0.8)

								text: Notifications.list.length != 0 ? "notifications_unread" : "notifications"
						
								font.family: Config.settings.iconFont
								font.weight: 400
									
								font.pixelSize: 18
								Layout.preferredHeight: 20
								Layout.leftMargin: 0
								Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

								Behavior on color {
									PropertyAnimation {
										duration: 150
										easing.type: Easing.InSine
									}
								}
							}
						}

						Behavior on color {
							PropertyAnimation {
								duration: 150
								easing.type: Easing.InSine
							}
						}


						MouseArea {
							anchors.fill: parent
							hoverEnabled: true
							cursorShape: Qt.PointingHandCursor

							onEntered: notificationButton.hovered = true
							onExited: notificationButton.hovered = false
						}
					}
						
					
					Rectangle {
						id: quickActionsButton
						property bool hovered: false
						Layout.preferredHeight: 100
						Layout.preferredWidth: barBase.width - 10
						Layout.alignment: Qt.AlignHCenter
						Layout.leftMargin: 3
						Layout.bottomMargin: 10

						topLeftRadius: 5
						topRightRadius: 5

						bottomLeftRadius: Config.settings.borderRadius
						bottomRightRadius: Config.settings.borderRadius

						color: hovered ? Qt.alpha(Colours.palette.primary, 0.8) : Qt.alpha(Colours.palette.surface_container, 0.8)

						Behavior on color {
							PropertyAnimation {
								duration: 150
								easing.type: Easing.InSine
							}
						}

						ColumnLayout {
							width: parent.width
							height: parent.height
							spacing: 7
							
							TimeWidget {
								color: quickActionsButton.hovered ? Colours.palette.on_primary : Qt.alpha(Colours.palette.on_surface, 0.8)
					
								font.family: Config.settings.font
								font.weight: 500
								
								font.pixelSize: 12
								Layout.preferredHeight: 7
								Layout.topMargin: 9

								Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

								Behavior on color {
									PropertyAnimation {
										duration: 150
										easing.type: Easing.InSine
									}
								}

							}

							NetworkWidget {
								color: quickActionsButton.hovered ? Colours.palette.on_primary : Network.getBool() ? Qt.alpha(Colours.palette.on_surface, 0.8) : Colours.palette.outline
									
								font.family: Config.settings.iconFont
								font.weight: 600

								Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
								Layout.preferredHeight: 8

								font.pixelSize: 15

								Behavior on color {
									PropertyAnimation {
										duration: 150
										easing.type: Easing.InSine
									}
								}
							}
									
							BatteryWidget {
									
								color: quickActionsButton.hovered ? Colours.palette.on_primary : Qt.alpha(Colours.palette.on_surface, 0.8)

								font.family: Config.settings.iconFont
								font.weight: 600
								
								Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
								Layout.preferredHeight: 12
								font.pixelSize: 17

								Behavior on color {
									PropertyAnimation {
										duration: 150
										easing.type: Easing.InSine
									}
								}
							}
						}

						MouseArea {
							anchors.fill: parent
							hoverEnabled: true
							cursorShape: Qt.PointingHandCursor

							onEntered: quickActionsButton.hovered = true
							onExited: quickActionsButton.hovered = false
						}
					}
				}
			}
		}
	}
}

