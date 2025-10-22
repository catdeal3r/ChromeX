import Quickshell
import Quickshell.Io
import Quickshell.Widgets

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls

import qs.config
import qs.modules

Rectangle {
    id: root
    property bool hovered: false
    property bool selected: false

	width: parent.width
    height: 50
    color: {
        if (selected || hovered)
            return Colours.palette.surface_container_high
        else
            return Colours.palette.surface
    }
    radius: Config.settings.borderRadius

    Behavior on color {
		PropertyAnimation {
			duration: 200
			easing.type: Easing.InSine
		}
	}

    ClippingWrapperRectangle {
        id: entryIcon
        anchors.left: parent.left
        anchors.leftMargin: 10

        anchors.top: parent.top
        anchors.topMargin: (parent.height / 2) - (size / 2)

        property int size: 25
        height: size
        width: size
        radius: 1000

        color: "transparent"

        child: Image {
            source: Quickshell.iconPath(modelData.icon, "application-x-executable")
            layer.enabled: true
            layer.effect: MultiEffect {
                saturation: Config.settings.colours.genType == "scheme-monochrome" && !Config.settings.colours.useCustom ? -1.0 : 1.0
            }
        }
    }

    ColumnLayout {
        anchors.left: entryIcon.right
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.topMargin: (parent.height / 2) - (height / 2)

        height: 40
        spacing: -5

        Text {
            font.family: Config.settings.font
            font.weight: 400
            text: modelData.name
            font.pixelSize: 14
            color: {
                if (root.hovered || root.selected)
                    return Colours.palette.on_surface
                else
                    return Colours.palette.outline
            }

            Behavior on color {
                PropertyAnimation {
                    duration: 200
                    easing.type: Easing.InSine
                }
            }
        }

        Text {
            font.family: Config.settings.font
            font.weight: 400
            text: modelData.comment
            font.pixelSize: 12
            color: {
                if (root.hovered || root.selected)
                    return Qt.alpha(Colours.palette.on_surface, 0.7)
                else
                    return Qt.alpha(Colours.palette.outline, 0.7)
            }

            Behavior on color {
                PropertyAnimation {
                    duration: 200
                    easing.type: Easing.InSine
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onEntered: root.hovered = true
        onExited: root.hovered = false
        onClicked: {
            modelData.execute()
            IPCLoader.toggleLauncher()
        }
    }
}
