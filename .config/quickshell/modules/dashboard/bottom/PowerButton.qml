import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Widgets

import qs.config

Rectangle {
    id: root
    Layout.preferredWidth: hovered ? 110 : 70
    Layout.preferredHeight: 30

    property string iconCode: "settings"
    property string text: "Placeholder"
    property var toRun

    property bool hovered: false

    color: hovered ? Colours.palette.primary_container : "transparent"

    radius: Config.settings.borderRadius

    Behavior on color {
        PropertyAnimation {
            duration: Config.settings.animationSpeed
            easing.type: Easing.InSine
        }
    }

    Behavior on Layout.preferredWidth {
        PropertyAnimation {
            duration: Config.settings.animationSpeed
            easing.type: Easing.InSine
        }
    }

    Text {
        id: icon
        anchors.left: parent.left
        anchors.leftMargin: 8

        anchors.top: parent.top
        anchors.topMargin: 5
        text: root.iconCode
        font.family: Config.settings.iconFont
        font.pixelSize: 16
        color: root.hovered ? Colours.palette.on_primary_container : Qt.alpha(Colours.palette.on_surface, 0.8)

        Behavior on color {
            PropertyAnimation {
                duration: Config.settings.animationSpeed
                easing.type: Easing.InSine
            }
        }
    }

    Text {
        anchors.left: icon.left
        anchors.leftMargin: 20

        anchors.top: parent.top
        anchors.topMargin: 6

        text: root.text
        font.family: Config.settings.font
        font.pixelSize: 14
        color: root.hovered ? Colours.palette.on_primary_container : Qt.alpha(Colours.palette.on_surface, 0.8)

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

        onEntered: root.hovered = true
        onExited: root.hovered = false
        onClicked: root.toRun()
    }
}