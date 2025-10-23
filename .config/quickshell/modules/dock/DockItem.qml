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

Rectangle {
    id: root
    required property var app
    property bool hovered: false

    function iconFromName(iconName, fallbackName) {
        const fallback = fallbackName || "application-x-executable"
        try {
            if (iconName && typeof Quickshell !== 'undefined' && Quickshell.iconPath) {
                const p = Quickshell.iconPath(iconName, fallback)
                if (p && p !== "")
                    return p
            }
        } catch (e) {

        // ignore and fall back
        }
        try {
            return Quickshell.iconPath("application-x-executable")
        } catch (e2) {
            return ""
        }
    }

    // Resolve icon path for a DesktopEntries appId - safe on missing entries
    function iconForAppId(appId, fallbackName) {
        console.log(appId)
        const fallback = fallbackName || "application-x-executable"

        if (!appId)
            return root.iconFromName(fallback, fallback)

        if (typeof DesktopEntries === 'undefined' || !DesktopEntries.byId)
            return root.iconFromName(fallback, fallback)

        const entry = (DesktopEntries.heuristicLookup) ? DesktopEntries.heuristicLookup(appId) : DesktopEntries.byId(appId)
        const name = entry && entry.icon ? entry.icon : ""
        return root.iconFromName(name || fallback, fallback)    
    }

    Layout.preferredWidth: root.app.pinned === null ? 2 : 45
    Layout.preferredHeight: root.app.pinned === null ? 30 : 45
    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
    color: {
        if (root.app.pinned === null)
            return Colours.palette.surface_container_highest
        else if (root.hovered)
            return Colours.palette.surface_container
        else
            return "transparent"
    }

    radius: Config.settings.borderRadius - 5

    Behavior on color {
		PropertyAnimation {
		    duration: Config.settings.animationSpeed
			easing.type: Easing.InSine
		}
	}

    ClippingWrapperRectangle {
        width: parent.width - 13
        height: width
        anchors.left: parent.left
        anchors.leftMargin: (parent.width / 2) - (width / 2)
        anchors.top: parent.top
        anchors.topMargin: 5
        color: "transparent"
        radius: 10
        visible: root.app.pinned !== null
        
        child: IconImage {
            source: root.iconForAppId(root.app.appId)
            visible: parent.visible
            width: parent?.width
            height: parent?.height

            MultiEffect {
                source: parent
                opacity: Config.settings.dock.colouredIcons ? 1 : 0
                anchors.fill: parent
                colorizationColor: Colours.palette.primary
                colorization: Config.settings.dock.colouredIconsAmount

                Behavior on opacity {
                    PropertyAnimation {
                        duration: Config.settings.animationSpeed
                        easing.type: Easing.InSine
                    }
                }
            }
        }
    }

    Rectangle {
        visible: root.app.pinned !== null
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: (parent.width / 2) - (width / 2)
        width: {
            let initial = 20

            if (root.app.toplevel?.activated)
                initial = 25
            else if (root.app.toplevel?.maximized)
                initial = 25
            else if (root.app.toplevel?.minimized)
                initial = 10
            
            if (root.hovered) {
                if (root.app.toplevel?.activated)
                    initial += 3
                else
                    initial += 5
            }

            return initial
        }


        Behavior on width {
			PropertyAnimation {
				duration: Config.settings.animationSpeed
				easing.type: Easing.InSine
			}
		}

        height: 5
        radius: Config.settings.borderRadius

        color: {
            if (root.app.toplevel === null)
                return "transparent"

            if (root.hovered) {
                if (root.app.toplevel?.activated)
                    return Qt.alpha(Colours.palette.primary, 0.9)
                else if (root.app.toplevel?.maximized)
                    return Colours.palette.primary
                else {
                    return Qt.alpha(Colours.palette.outline, 0.7)
                }
            } else {
                if (root.app.toplevel?.activated)
                    return Qt.alpha(Colours.palette.primary, 0.7)
                else if (root.app.toplevel?.maximized)
                    return Colours.palette.primary
                else {
                    return Colours.palette.surface_container_highest
                }
            }
        }

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
        visible: root.app.pinned !== null

        onEntered: root.hovered = true
        onExited: root.hovered = false
        onClicked: {
            if (root.app.toplevel === null)
                DesktopEntries.heuristicLookup(root.app.appId)?.execute()
            else
                root.app.toplevel.activate()
        }
    }
}