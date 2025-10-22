import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets

import qs.modules.settings
import qs.config
import qs.modules.common
import qs.modules
import qs.services

Loader {
	id: root
	required property bool isSettingsWindowOpen

    property int winWidth: 1200
    property int winHeight: 700

	property bool ani
	
	active: false
	
	onIsSettingsWindowOpenChanged: {
		if (root.isSettingsWindowOpen == true) {
			root.active = true
			root.ani = true
		} else {
			root.ani = false
		}
	}
	
	sourceComponent: Scope {
		signal finished();
		
		Variants {
			model: Quickshell.screens;
	  
			PanelWindow {
				id: settingsWindow
			
				property var modelData
				screen: modelData
				
				anchors {
					bottom: true
					left: true
					top: true
					right: true
				}
				
				aboveWindows: true
				color: "transparent"
				
				exclusionMode: ExclusionMode.Ignore
				
				mask: Region {
					item: maskId
				}
				
				visible: true
				
				ScrollView {
					id: maskId
					implicitHeight: root.winHeight
					implicitWidth: root.winWidth
					
					anchors {
						bottom: parent.bottom
						top: undefined
						left: parent.left
						right: undefined
					}

					anchors.leftMargin: (parent.width / 2) - (width / 2)
					
					anchors.bottomMargin: -1 * root.winHeight

                    opacity: 0
					
					Timer {
						running: root.ani
						repeat: false
						interval: 20
						onTriggered: {
                            maskId.anchors.bottomMargin = (settingsWindow.height / 2) - (maskId.height / 2)
                            maskId.opacity = 1
						}
					}
					
					Timer {
						running: !root.ani
						repeat: false
						interval: 1
						onTriggered: {
                            maskId.anchors.bottomMargin = -1 * root.winHeight
                            maskId.opacity = 0
						}
					}
					
					Timer {
						running: !root.ani
						repeat: false
						interval: 250
						onTriggered: {
							root.active = false
						}
					}

					clip: true

                    Behavior on anchors.bottomMargin {
						PropertyAnimation {
							duration: 200
							easing.type: Easing.InSine
						}
					}

                    Behavior on opacity {
						PropertyAnimation {
							duration: Config.settings.animationSpeed
							easing.type: Easing.InSine
						}
					}

					Rectangle {
						anchors.fill: parent
						color: Colours.palette.surface
						radius: Config.settings.borderRadius

						Text {
							id: windowIcon
							text: "settings"
							font.family: Config.settings.iconFont
							font.pixelSize: 17
							color: Qt.alpha(Colours.palette.on_surface, 0.8)
							anchors.top: parent.top
							anchors.left: parent.left
							anchors.topMargin: 12
							anchors.leftMargin: 15
						}

						Text {
							text: "Settings"
							font.family: Config.settings.font
							font.pixelSize: 16
							color: Qt.alpha(Colours.palette.on_surface, 0.8)
							anchors.top: parent.top
							anchors.left: windowIcon.right
							anchors.topMargin: 12
							anchors.leftMargin: 10
						}

						Rectangle {
							id: closeBtn
							property bool hovered: false
							anchors.top: parent.top
							anchors.right: parent.right
							anchors.topMargin: 10
							anchors.rightMargin: 10
							color: hovered ? Colours.palette.surface_container_highest : Colours.palette.surface_container
							radius: Config.settings.borderRadius

							width: 30
							height: 30

							Behavior on color {
								PropertyAnimation {
									duration: Config.settings.animationSpeed
									easing.type: Easing.InSine
								}
							}

							Text {
								anchors.centerIn: parent
								text: "close"
								font.family: Config.settings.iconFont
								font.pixelSize: 18
								color: closeBtn.hovered ? Qt.alpha(Colours.palette.on_surface, 0.8) : Qt.alpha(Colours.palette.on_surface, 0.5)

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

								onEntered: closeBtn.hovered = true
								onExited: closeBtn.hovered = false
								onClicked: IPCLoader.toggleSettings()
							}
						}

						RowLayout {
							anchors.fill: parent
							spacing: 10

							SettingsSidebar {
								Layout.preferredHeight: root.winHeight - 50
								Layout.preferredWidth: root.winWidth * 0.2
								Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
								Layout.leftMargin: 20
								Layout.bottomMargin: 20
							}

							SettingsContent {
								Layout.preferredHeight: root.winHeight - 50
								Layout.preferredWidth: root.winWidth * 0.75
								Layout.alignment: Qt.AlignRight | Qt.AlignBottom
								Layout.rightMargin: 20
								Layout.bottomMargin: 20
							}
						}
					}
				}
			}
		}
	}
}