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

    property var apps: {
        var list = [];
        var pinnedList = [ "org.gnome.nautilus", "firefox", "obsidian" ];
        ToplevelManager.toplevels.values.forEach(app => {
            if (!list.includes({ "appId": app.appId })) {
                list.push({
                    "pinned": false,
                    "appId": app.appId,
                    "toplevel": app,
                });
            }
        });

        var listIds = list.map(function(item){ return item.appId.toLowerCase() });

        if (pinnedList.length > 0 && ToplevelManager.toplevels.values.length > 0) {
            list.push({
                "pinned": null,
                "appId": null,
                "toplevel": null
            });
        }

        for (var appId of pinnedList) {
            if (!listIds.includes(appId.toLowerCase())) {
                list.push({
                    "pinned": true,
                    "appId": appId,
                    "toplevel": null
                });
            }
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
                left: false
                right: false
            }
                    
            exclusionMode: ExclusionMode.Ignore
            exclusiveZone: Config.settings.isDockPinned ? 30 : 0

            implicitHeight: 110
            implicitWidth: (dockLayout.width) + 40
            
            mask: Region {
				item: hoverBase
			}

            Rectangle {
                id: hoverBase
                width: parent.width
                height: 110
                color: "transparent"

                anchors.top: parent.top
                anchors.topMargin: {
                    if (Config.settings.isDockPinned)
                        return 0
                    else if (root.isHovered)
                        return 0
                    else
                        return height - 20
                }

                Behavior on anchors.topMargin {
					PropertyAnimation {
						duration: Config.settings.animationSpeed
						easing.type: Easing.InSine
					}
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