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
			
			implicitWidth: 45
			
			visible: true
			
			exclusiveZone: 40
			exclusionMode: ExclusionMode.Auto

			mask: Region {
				item: barBase
			}

			Rectangle {
				id: barBase
				anchors.left: parent.left

				width: barWindow.implicitWidth
				height: barWindow.height - 115
				color: Colours.palette.surface

				anchors.top: parent.top
				anchors.topMargin: (parent.height / 2) - (height / 2)

				topRightRadius: Config.settings.borderRadius
				bottomRightRadius: Config.settings.borderRadius

				IconImage {
					id: icon
					width: 25
					height: 25
					opacity: Config.settings.usePfpInsteadOfLogo ? 0 : 1
					anchors.top: parent.top
					anchors.left: parent.left
					anchors.leftMargin: (parent.width / 2) - (width / 2) - 1
					anchors.topMargin: 15
					source: Qt.resolvedUrl(Quickshell.shellDir + "/assets/icon.png")

					Behavior on opacity {
						PropertyAnimation {
							duration: Config.settings.animationSpeed
							easing.type: Easing.InSine
						}
					}
				}

				ClippingWrapperRectangle {
					id: pfp
					width: 25
					height: 25
					opacity: Config.settings.usePfpInsteadOfLogo ? 1 : 0
					anchors.top: parent.top
					anchors.left: parent.left
					anchors.leftMargin: (parent.width / 2) - (width / 2) - 1
					anchors.topMargin: 15
					color: "transparent"
					radius: 1000

					IconImage {
						source: `file://${Config.settings.pfpLocation}`
					}

					Behavior on opacity {
						PropertyAnimation {
							duration: Config.settings.animationSpeed
							easing.type: Easing.InSine
						}
					}
				}

				MultiEffect {
					visible: !Config.settings.usePfpInsteadOfLogo
					source: icon
					anchors.fill: icon
					colorizationColor: Qt.alpha(Colours.palette.on_surface, 0.8)
					colorization: 1.0
				}

				WorkspacesWidget {}
						
				ColumnLayout {
					spacing: 10
					anchors.left: parent.left

					width: parent.width - 5
					anchors.bottom: parent.bottom
					anchors.bottomMargin: 5
							
					SysTray {
						Layout.preferredHeight: (SystemTray.items.values.length * 25)
						Layout.preferredWidth: 20
						Layout.leftMargin: 2
						Layout.alignment: Qt.AlignHCenter
						bar: barWindow
					}

					Rectangle {
						id: recordingButton
						property bool hovered: false

						Layout.preferredHeight: {
							if (!Recorder.isRecordingRunning)
								return 0
							else if (hovered)
								return 55
							else
								return 50
						}

						Layout.preferredWidth: barBase.width - 10
						Layout.alignment: Qt.AlignHCenter
						Layout.bottomMargin: -4
						Layout.leftMargin: 3
						visible: Layout.preferredHeight == 0 ? false : true

						topLeftRadius: Config.settings.borderRadius
						topRightRadius: Config.settings.borderRadius

						bottomLeftRadius: hovered ? Config.settings.borderRadius : 5
						bottomRightRadius: hovered ? Config.settings.borderRadius : 5

						color: hovered ? Colours.palette.error_container : Qt.alpha(Colours.palette.error_container, 0.8)

						Behavior on bottomLeftRadius {
							PropertyAnimation {
								duration: Config.settings.animationSpeed
								easing.type: Easing.InSine
							}
						}

						Behavior on bottomRightRadius {
							PropertyAnimation {
								duration: Config.settings.animationSpeed
								easing.type: Easing.InSine
							}
						}

						Behavior on color {
							PropertyAnimation {
								duration: Config.settings.animationSpeed
								easing.type: Easing.InSine
							}
						}

						Behavior on Layout.preferredHeight {
							PropertyAnimation {
								duration: Config.settings.animationSpeed
								easing.type: Easing.InSine
							}
						}

						ColumnLayout {
							width: parent.width
							height: parent.height

							Text {
								color: Colours.palette.on_error_container

								text: "screen_record"
						
								font.family: Config.settings.iconFont
								font.weight: 400
									
								font.pixelSize: 18
								Layout.preferredHeight: 20
								Layout.leftMargin: 0
								Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

								opacity: Recorder.isRecordingRunning ? 1 : 0
								visible: recordingButton.visible

								Behavior on color {
									PropertyAnimation {
										duration: Config.settings.animationSpeed
										easing.type: Easing.InSine
									}
								}

								Behavior on opacity {
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

							onEntered: recordingButton.hovered = true
							onExited: recordingButton.hovered = false
							onClicked: Recorder.stopRecording()
						}
					}

					Rectangle {
						id: notificationButton
						property bool hovered: false

						Layout.preferredHeight: hovered ? 55 : 50
						Layout.preferredWidth: barBase.width - 10
						Layout.alignment: Qt.AlignHCenter
						Layout.bottomMargin: -4

						function getTopRadius() {
							if (hovered)
								return Config.settings.borderRadius
							else if (Recorder.isRecordingRunning)
								return 5
							else
								return Config.settings.borderRadius
						}

						topLeftRadius: getTopRadius()
						topRightRadius: getTopRadius()

						bottomLeftRadius: hovered ? Config.settings.borderRadius : 5
						bottomRightRadius: hovered ? Config.settings.borderRadius : 5

						color: hovered ? Qt.alpha(Colours.palette.primary, 0.8) : Qt.alpha(Colours.palette.surface, 0.8)

						Behavior on bottomLeftRadius {
							PropertyAnimation {
								duration: Config.settings.animationSpeed
								easing.type: Easing.InSine
							}
						}

						Behavior on bottomRightRadius {
							PropertyAnimation {
								duration: Config.settings.animationSpeed
								easing.type: Easing.InSine
							}
						}

						Behavior on topLeftRadius {
							PropertyAnimation {
								duration: Config.settings.animationSpeed
								easing.type: Easing.InSine
							}
						}

						Behavior on topRightRadius {
							PropertyAnimation {
								duration: Config.settings.animationSpeed
								easing.type: Easing.InSine
							}
						}

						Behavior on color {
							PropertyAnimation {
								duration: Config.settings.animationSpeed
								easing.type: Easing.InSine
							}
						}

						Behavior on Layout.preferredHeight {
							PropertyAnimation {
								duration: Config.settings.animationSpeed
								easing.type: Easing.InSine
							}
						}

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

							onEntered: notificationButton.hovered = true
							onExited: notificationButton.hovered = false
						}
					}
						
					
					Rectangle {
						id: quickActionsButton
						property bool hovered: false
						Layout.preferredHeight: hovered ? 105 : 100
						Layout.preferredWidth: barBase.width - 10
						Layout.alignment: Qt.AlignHCenter
						Layout.bottomMargin: 10

						topLeftRadius: hovered ? Config.settings.borderRadius : 5
						topRightRadius: hovered ? Config.settings.borderRadius : 5

						bottomLeftRadius: Config.settings.borderRadius
						bottomRightRadius: Config.settings.borderRadius

						function isColoured() {
							if (hovered) {
								return true
							}
							else {
								if (IPCLoader.isDashboardOpen)
									return true
								else
									return false
							}
						}

						color: isColoured() ? Qt.alpha(Colours.palette.primary, 0.8) : Qt.alpha(Colours.palette.surface, 0.8)

						Behavior on color {
							PropertyAnimation {
								duration: Config.settings.animationSpeed
								easing.type: Easing.InSine
							}
						}

						Behavior on Layout.preferredHeight {
							PropertyAnimation {
								duration: Config.settings.animationSpeed
								easing.type: Easing.InSine
							}
						}

						Behavior on topLeftRadius {
							PropertyAnimation {
								duration: Config.settings.animationSpeed
								easing.type: Easing.InSine
							}
						}

						Behavior on topRightRadius {
							PropertyAnimation {
								duration: Config.settings.animationSpeed
								easing.type: Easing.InSine
							}
						}

						ColumnLayout {
							width: parent.width
							height: parent.height
							spacing: 7
							
							TimeWidget {
								color: quickActionsButton.isColoured() ? Colours.palette.on_primary : Qt.alpha(Colours.palette.on_surface, 0.8)
					
								font.family: Config.settings.font
								font.weight: 500
								
								font.pixelSize: 12
								Layout.preferredHeight: 7
								Layout.topMargin: 9

								Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

								Behavior on color {
									PropertyAnimation {
										duration: Config.settings.animationSpeed
										easing.type: Easing.InSine
									}
								}

							}

							NetworkWidget {
								color: quickActionsButton.isColoured() ? Colours.palette.on_primary : Network.getBool() ? Qt.alpha(Colours.palette.on_surface, 0.8) : Colours.palette.outline
									
								font.family: Config.settings.iconFont
								font.weight: 600

								Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
								Layout.preferredHeight: 8

								font.pixelSize: 15

								Behavior on color {
									PropertyAnimation {
										duration: Config.settings.animationSpeed
										easing.type: Easing.InSine
									}
								}
							}
									
							BatteryWidget {
									
								color: quickActionsButton.isColoured() ? Colours.palette.on_primary : Qt.alpha(Colours.palette.on_surface, 0.8)

								font.family: Config.settings.iconFont
								font.weight: 600
								
								Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
								Layout.preferredHeight: 12
								font.pixelSize: 17

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
							hoverEnabled: true
							cursorShape: Qt.PointingHandCursor

							onEntered: quickActionsButton.hovered = true
							onExited: quickActionsButton.hovered = false
							onClicked: IPCLoader.toggleDashboard()
						}
					}
				}
			}
		}
	}
}

