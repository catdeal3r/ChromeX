import Quickshell
import Quickshell.Io

import QtQuick

import qs.config

Rectangle {
    id: root
    property string text: "Placeholder"
    property string iconCode: "settings"
    property int iconSize: 23

    Text {
        id: icon
        text: root.iconCode
        font.family: Config.settings.iconFont
        font.pixelSize: root.iconSize
        color: Colours.palette.on_surface
    }

    Text {
        anchors.left: icon.right
        anchors.leftMargin: 10
        text: root.text
        font.family: Config.settings.font
        font.pixelSize: 20
        color: Colours.palette.on_surface
    }
}
