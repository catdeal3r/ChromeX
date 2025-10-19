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

Rectangle {
    id: root
    color: "transparent"
    property int page: 0
    
    Rectangle {
        width: parent.width - 30
        height: parent.height - 60

        anchors.top: parent.top
        anchors.topMargin: (parent.height / 2) - (height / 2)

        anchors.left: parent.left
        anchors.leftMargin: (parent.width / 2) - (width / 2)
        color: "transparent"

        Text {
            anchors.centerIn: parent
            text: "Coming soon ..."
            color: Colours.palette.on_surface
            font.family: Config.settings.font
            font.pixelSize: 25
        }
    }
}
