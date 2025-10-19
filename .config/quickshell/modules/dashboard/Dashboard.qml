import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets

import qs.modules.dashboard
import qs.config
import qs.modules.common
import qs.modules
import qs.services

Loader {
	id: root
	required property bool isDashboardOpen

    property int dashWidth: 515
    property int dashHeight: {
		if (!Config.settings.componentControl.dockIsEnabled)
			return 960
		else if (Config.settings.dock.pinned)
			return 930
		else
			return 960
	}

    property int dashHoriPadding: 60
    property int dashVertPadding: {
		if (!Config.settings.componentControl.dockIsEnabled)
			return 60
		else if (Config.settings.dock.pinned)
			return 90
		else
			return 60
	}
	
	property bool ani
	
	active: false
	
	onIsDashboardOpenChanged: {
		if (root.isDashboardOpen == true) {
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
				id: dashboardWindow
			
				property var modelData
				screen: modelData
				
				anchors {
					bottom: true
					left: true
				}
				
				aboveWindows: true
				color: "transparent"
				
				implicitHeight: root.dashHeight + root.dashVertPadding
				implicitWidth: root.dashWidth + root.dashHoriPadding
				
				exclusionMode: ExclusionMode.Ignore
				
				mask: Region {
					item: maskId
				}
				
				visible: true
				
				ScrollView {
					id: maskId
					implicitHeight: 0
					implicitWidth: root.dashWidth
					
					anchors {
						bottom: parent.bottom
						top: undefined
						left: parent.left
						right: undefined
					}
					
					anchors.leftMargin: -1 * root.dashWidth

                    opacity: 0
					
					Timer {
						running: root.ani
						repeat: false
						interval: 1
						onTriggered: {
							maskId.implicitHeight = root.dashHeight
                            maskId.anchors.leftMargin = root.dashHoriPadding
                            maskId.opacity = 1
						}
					}
					
					Timer {
						running: !root.ani
						repeat: false
						interval: 1
						onTriggered: {
                            maskId.anchors.leftMargin = -1 * root.dashWidth
							maskId.implicitHeight = 0
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
					
					anchors.bottomMargin: root.dashVertPadding
					
					clip: true

                    Behavior on anchors.leftMargin {
						PropertyAnimation {
							duration: 200
							easing.type: Easing.InSine
						}
					}

                    Behavior on implicitHeight {
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

					Rectangle {
						anchors.top: parent.top
						width: root.dashWidth
						height: root.dashHeight - 545
						
						color: Colours.palette.surface
						
						radius: Config.settings.borderRadius

						NotificationLog {}
					}
					
					Rectangle {
						anchors.bottom: parent.bottom
						width: root.dashWidth
						height: 525
						
						color: Colours.palette.surface
						
						radius: Config.settings.borderRadius

                        MouseArea {
                            property int startX

                            anchors.fill: parent
                            acceptedButtons: Qt.LeftButton

                            onPressed: event => {
                                startX = event.x;
                            }

                            onPositionChanged: event => {
                                let differance =  startX - event.x
                                if (differance > 30) {
                                    IPCLoader.isDashboardOpen = false
                                }
                            }
                        }

                        ColumnLayout {
                            spacing: 10

                            Toggles {}

							Music {}

							Sliders {}

							Bottom {}
                        }
					}
				}
			}
		}
	}
}