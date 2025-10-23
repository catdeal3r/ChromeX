import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Wayland

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls

import qs.modules.dock
import qs.config
import qs.modules.common
import qs.modules
import qs.services

Scope {
	signal finished();
	id: root
    property bool isHovered: false
    property bool isShown: false

    property var apps: {
        var list = [];
        var pinnedList = [];

        for (var app of Config.settings.dock.pinnedApps) {
            pinnedList.push(app.toLowerCase());
        }

        for (var app of pinnedList) {
            list.push({
                "pinned": true,
                "appId": app,
                "toplevel": null
            });
        }

        for (var listApp of list) {
            ToplevelManager.toplevels.values.forEach(app => {
                if (listApp.appId === app.appId.toLowerCase()) {
                    listApp.toplevel = app
                }
            });
        }


        var dividerAllowed = false

        var unpinnedList = [];

        ToplevelManager.toplevels.values.forEach(app => {
            if (!pinnedList.includes(app.appId.toLowerCase())) {
                unpinnedList.push({
                    "pinned": false,
                    "appId": app.appId,
                    "toplevel": app
                });
                dividerAllowed = true
            }
        });

        if (pinnedList.length > 0 && ToplevelManager.toplevels.values.length > 0 && Config.settings.dock.seperator && dividerAllowed) {
            list.push({
                "pinned": null,
                "appId": null,
                "toplevel": null
            });
        }

        for (var app of unpinnedList) {
            list.push({
                "pinned": false,
                "appId": app.appId,
                "toplevel": app.toplevel
            });
        }

        return list;
    }

	Variants {
        model: Quickshell.screens;
        
        PanelWindow {
            id: launcherWindow
                
            property var modelData
            screen: modelData
                    
            aboveWindows: true
            color: "transparent"
                    
            anchors {
                top: false
                bottom: true
                left: true
                right: true
            }
                    
            exclusionMode: ExclusionMode.Auto
            exclusiveZone: Config.settings.dock.pinned ? 40 : -10

            implicitHeight: 110
            
            mask: Region {
				item: hoverBase
			}

            Rectangle {
                id: hoverBase
                width: (dockLayout.width) + 40
                height: 110
                color: "transparent"

                anchors.top: parent.top
                anchors.topMargin: {
                    if (Config.settings.dock.pinned)
                        return 0
                    else if (root.isShown)
                        return 0
                    else
                        return height - 20
                }

                anchors.left: parent.left
                anchors.leftMargin: (parent.width / 2) - (width / 2)

                Behavior on anchors.topMargin {
					PropertyAnimation {
						duration: Config.settings.animationSpeed
						easing.type: Easing.InSine
					}
				}

                Behavior on width {
					PropertyAnimation {
						duration: Config.settings.animationSpeed
						easing.type: Easing.InSine
					}
				}

                Timer {
                    interval: 1
                    running: root.isHovered
                    repeat: false
                    onTriggered: root.isShown = true
                }

                Timer {
                    interval: 200
                    running: !root.isHovered
                    repeat: false
                    onTriggered: root.isShown = false
                }

                HoverHandler {
                    parent: parent
                    acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad | PointerDevice.Stylus

                    onHoveredChanged: {
                        root.isHovered = hovered
                    }
                }
                
                Rectangle {
                    id: dockBase
                    width: parent.width
                    height: 65
                    radius: Config.settings.borderRadius
                    anchors.top: parent.top
                    anchors.topMargin: 20
                    color: Colours.palette.surface

                    RowLayout {
                        id: dockLayout
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.topMargin: (parent.height / 2) - (height / 2)
                        anchors.leftMargin: (parent.width / 2) - (width / 2)
                        spacing: 15

                        Repeater {
                            model: root.apps

                            delegate: DockItem {
                                required property var modelData
                                app: modelData
                            }
                        }
                    }
                }
            }
        }
    }
}